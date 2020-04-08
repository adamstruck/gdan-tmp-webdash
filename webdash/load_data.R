suppressMessages({
  library(foreach)
  library(magrittr)
})

## options(shiny.trace = TRUE) # JAL

message("loading prediction files...")
output_files <- list.files("/mnt/data/predictions", full.names = T)
predictions <- foreach(f = output_files, .combine = dplyr::bind_rows) %do% {
  message('Currently working on file: ')
  print(f)
  data.table::fread(f) %>%
    dplyr::as_tibble() %>%
    # "melt" so new cols==c('prediction_id', 'predicted_value') where is c(modelheader, predicted val)
    tidyr::gather(-Sample_ID, -Repeat, -Fold, -Test, -Label, key = "prediction_id", value = "predicted_value") %>%
    # rename certain cols
    dplyr::rename(sample_id = Sample_ID, `repeat` = Repeat, fold = Fold, actual_value = Label, type = Test) %>%
    # add new cols that are split str of 'prediction_id'. but keep 'prediction_id' col
    tidyr::separate(prediction_id, sep = "\\|", into = c("model_id", "featureset_id", "date", "ptype"), remove = F) %>%
    # add new cols == c('cancer_id', 'extra') is c(ACC, ACC_2)
    tidyr::separate(actual_value, sep = ":", into = c("cancer_id", "extra"), remove = F) %>%
    # rm cols. note c('extra', 'ptype')==c(ACC_2, c for crisp)
    dplyr::select(-ptype, -extra) %>%
    # replace vals in 'type' col. example 1,0,1 --> testing, training, testing
    dplyr::mutate(type = ifelse(type == 1, "testing", "training"))
} %>%
  # change data "type". factors, date
  dplyr::mutate(predicted_value = as.factor(predicted_value),
                actual_value = as.factor(actual_value),
                date = as.Date(date)) %>%
  # sep col 'model_id" and place index0 in col 'cancer_id' and index1 in 'model_id'
  tidyr::separate(model_id, "\\:", into = c("cancer_id", "model_id"))

message("loading feature set files...")
featureset_files <- list.files("/mnt/data/feature-sets", full.names = T)
featureSets <- foreach(f = featureset_files, .combine = dplyr::bind_rows) %do% {
    data.table::fread(f) %>%
        dplyr::as_tibble() %>%
            # THIS LINE IS GNOSIS SPECIFIC - new line
            dplyr::mutate(Features = as.character(Features)) %>%
            dplyr::mutate(Features = purrr::map(Features, jsonlite::fromJSON),
                          TCGA_Projects = purrr::map(TCGA_Projects, jsonlite::fromJSON)) %>%
            tidyr::unnest(TCGA_Projects) %>%
            tidyr::unnest(Features) %>%
            dplyr::rename(featureset_id = Feature_Set_ID,
                          cancer_id = TCGA_Projects,
                          feature_id = Features)
}

message("connecting to feature database...")
feature_con <- DBI::dbConnect(RSQLite::SQLite(), "/mnt/data/features.sqlite")

message("getting cancer list...")
cancers <- predictions %>% dplyr::pull(cancer_id) %>% unique()

message("done loading data")
