#!/usr/bin/env Rscript


# Purpose: create obj3 and store in tmp data/tmpdir
#    This will be pulled in by webdash/global.R to speed up app start up
#    otherwise slow at processing new files to create `model_summary` for large datasets

suppressMessages({
  library(foreach)
  library(magrittr)
  library(dplyr)
  library(data.table)
  library(tidyr)
})
## options(shiny.trace = TRUE) #enable tracing


#############
# Section 1: load_data.R
#   Purpose == get object `predictions` that are needed for input of section 2
#############
# Input paths
message("loading prediction files...")
output_files <- list.files("/home/ubuntu/gdan-tmp-webdash/data/predictions", full.names = T)
featureset_files <- list.files("/home/ubuntu/gdan-tmp-webdash/data/feature-sets", full.names = T)
# Generate predictions object from prediction files
predictions <- foreach(f = output_files, .combine = dplyr::bind_rows) %do% {
  #message('Currently working on file: ')
  #print(f)
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



#############
# Section 2. global.R
#    Prediction output of load_data.R
#############
# sanity check
message('sanity check:' )
print(unique(predictions$cancer_id))

# Begin with slow part of global.R, can take >2 hours with 2 large datasets
# 1. Create obj1
message('creating obj1' )
obj1 <- predictions %>%
  dplyr::group_by(cancer_id, model_id, featureset_id, type) %>%
  dplyr::summarize(correct = table(as.numeric(predicted_value) == as.numeric(actual_value))["TRUE"],
                   total = dplyr::n()) %>%
  dplyr::ungroup() %>%
  dplyr::mutate(tpr = round(correct / total, digits = 3)) %>%
  dplyr::select(cancer_id, model_id, featureset_id, type, tpr) %>%
  tidyr::spread(type, tpr)
# 2. Create obj2
message('creating obj2' )
obj2 <- predictions %>%
  dplyr::select(cancer_id, model_id, featureset_id, date, prediction_id) %>%
  dplyr::distinct()
# 3. Create obj3
message('creating obj3' )
obj3 <- dplyr::left_join(obj1, obj2) %>%
    # rename cols
    dplyr::rename(Project = cancer_id, Model = model_id, Features = featureset_id,Date = date, TPR_Training = training, TPR_Testing = testing)


# Write the already created obj3 to disc
write.table(obj3, file='/home/ubuntu/gdan-tmp-webdash/data/tmpdir/tmp--obj3-FINAL.tsv', sep='\t', col.names=TRUE, row.names=FALSE)
