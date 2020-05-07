LOAD_THREADS <- ifelse(Sys.getenv("LOAD_THREADS") == "", 1, as.integer(Sys.getenv("LOAD_THREADS")))

suppressMessages({
  library(foreach)
  library(magrittr)
  library(doParallel)
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
      ptype <- tmp %>% head(1) %>% dplyr::pull(ptype)
      if (ptype == "p") {
        tmp$predicted_value <- lapply(tmp$predicted_value, function(x) {
          jsonlite::parse_json(x)$classification %>% which.max() %>% names()
        }) %>% cleanLabels()
      } else {
        tmp$predicted_value <- cleanLabels(tmp$predicted_value)
      }

      tmp <- tmp %>%
        dplyr::mutate(actual_value = cleanLabels(actual_value),
                      type = ifelse(type == 1, "testing", "training")) %>%
        tidyr::separate(actual_value, sep = ":",
                        into = c("cancer_id", "extra"),
                        remove = F) %>%
        dplyr::select(-extra, -ptype)

      dtypes <- lapply(tmp, class)
      if (dtypes$`repeat` == "character") {
        tmp <- tmp %>% mutate(`repeat` = as.integer(stringr::str_replace(`repeat`, "R", "")))
      }
      if (dtypes$fold == "character") {
        tmp <- tmp %>% mutate(fold = as.integer(stringr::str_replace(fold, "F", "")))
      }
      try({
        tmp$date <- as.Date(parsedate::parse_iso_8601(tmp$date))
      })
      if (class(tmp$date) == "character") {
        tmp$date <- as.Date(NA)
      }
      tmp
    },
    error = function(e) {
      message(e, ": ", f)
      NULL
    })
  } %>%
    dplyr::mutate(predicted_value = as.factor(predicted_value),
                  actual_value = as.factor(actual_value))
}

message("loading feature set files...")
featureset_files <- list.files("/mnt/data/feature-sets", recursive = T, full.names = T) %>% sort()
if (length(featureset_files) == 0) {
  message("no feature set files were found!")
  featureSets <- dplyr::tibble(
    featureset_id = character(),
    cancer_id = character(),
    feature_id = character())
} else {
  featureSets <- foreach(f = featureset_files, .combine = dplyr::bind_rows,
                         .multicombine = T, .maxcombine = 10,
                         .packages = c("magrittr")) %dopar% {
    message("loading feature set file: ", f)
    sep <- ifelse(endsWith(f, ".csv"), ",", "\t")
    suppressMessages({
      tmp <- readr::read_delim(f, comment = "#", delim = sep)
    })
    if (!all(colnames(tmp) == c("Feature_Set_ID", "TCGA_Projects", "Features"))) {
      message("ERROR: incorrect header for: ", f)
      return(NULL)
    }
    tmp %>%
      tidyr::replace_na(list(TCGA_Projects = "[]", Features = "[]")) %>%
      dplyr::mutate(Features = purrr::map(Features, jsonlite::fromJSON),
                    TCGA_Projects = purrr::map(TCGA_Projects, jsonlite::fromJSON)) %>%
      tidyr::unnest(TCGA_Projects) %>%
      tidyr::unnest(Features) %>%
      dplyr::rename(featureset_id = Feature_Set_ID,
                    cancer_id = TCGA_Projects,
                    feature_id = Features) %>%
      dplyr::mutate(feature_id = as.character(feature_id),
                    cancer_id = as.character(cancer_id))
  }
}

message("getting cancer list...")
cancers <- predictions %>% dplyr::pull(cancer_id) %>% unique()

message("done loading data")
