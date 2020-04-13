#!/usr/bin/env Rscript

# ######## Hardcoded objects
# prediction_dir = "<path>/data/predictions"
# features_dir = "<path>/data/feature-sets"
# output_obj3_name = '<path>/data/tmpdir/tmp--combo_rf-gnosis_obj3.tsv'
# #########################

suppressMessages({
  library(foreach)
  library(magrittr)
  library(dplyr)
  library(data.table)
  library(tidyr)
  library(argparse)
})

parser <- ArgumentParser()
parser$add_argument("-p", "--prediction_dir", type='character', help="input dir of prediction files")
parser$add_argument('-f', '--features_dir', type='character', help='input dir of feature set files')
parser$add_argument('-out', '--output_obj3_name', type='character', help='output file name of obj3')
args <- parser$parse_args()


## options(shiny.trace = TRUE) # JAL

message("loading prediction files...")
output_files <- list.files(args$prediction_dir, full.names = T)
featureset_files <- list.files(args$features_dir, full.names = T)

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


obj1 <- predictions %>%
  dplyr::group_by(cancer_id, model_id, featureset_id, type) %>%
  dplyr::summarize(correct = table(as.numeric(predicted_value) == as.numeric(actual_value))["TRUE"],
                   total = dplyr::n()) %>%
  dplyr::ungroup() %>%
  dplyr::mutate(tpr = round(correct / total, digits = 3)) %>%
  dplyr::select(cancer_id, model_id, featureset_id, type, tpr) %>%
  tidyr::spread(type, tpr)

obj2 <- predictions %>%
  dplyr::select(cancer_id, model_id, featureset_id, date, prediction_id) %>%
  dplyr::distinct()

obj3 <- dplyr::left_join(obj1, obj2) %>%
    # rename cols
    dplyr::rename(Project = cancer_id, Model = model_id, Features = featureset_id,Date = date, TPR_Training = training, TPR_Testing = testing)


write.table(obj3, file=args$output_obj3_name, sep='\t', col.names=TRUE, row.names=FALSE)

#####
# Manual check if file reads in and out correctly
#####
## new_copy_obj3 <- data.table::fread(args$output_obj3_name) %>%
##     dplyr::as_tibble() %>%
##     # by default read in not as type date. so force it here
##     dplyr::mutate(Date = as.Date(Date))
## # compare if these are the same. they should be if implemented correctly
## isTRUE( all.equal(copy_obj3, new_copy_obj3) )
