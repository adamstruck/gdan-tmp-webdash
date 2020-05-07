##-------------------------
## Global variables
##-------------------------
DEFAULT_GRAPH <- ifelse(Sys.getenv("GDAN_TMP_GRAPH") == "", "gdan_tmp", Sys.getenv("GDAN_TMP_GRAPH"))
DEFAULT_GRIP_HOST <- ifelse(Sys.getenv("GRIP_HOST") == "", "localhost:8201", Sys.getenv("GRIP_HOST"))

message("GRIP HOST: ", DEFAULT_GRIP_HOST)
message("GRAPH: ", DEFAULT_GRAPH)

hclustfunc <- function(x, method = "complete", dmeth = "euclidean") {
  hclust(dist(x, method = dmeth), method = method)
}

# source("helpers.R")
# cancers <- getCancers()
# features <- getFeatures()
# featureSets <- getFeatureSets(NULL)
# predictions <- getPredictions(NULL)

message('...starting load_data.R\n\t', Sys.time())
source("load_data.R")
# creates variables:
# predictions
# featureSets
# feature_con
# cancers
#

# message('...generating model summary\n\t', Sys.time())
# message('...GNOSIS - reading /data/tmpdir/tmp--combo_rf-gnosis_obj3.tsv\n\t', Sys.time())
# obj3 <- data.table::fread('/mnt/data/tmpdir/tmp--combo_rf-gnosis_obj3.tsv') %>%
#     dplyr::as_tibble() %>%
#     dplyr::mutate(Date = as.Date(Date))
message('...generating model summary\n\t', Sys.time())
message('...GNOSIS - reading /data/tmpdir/tmp--fixattempt2--gnosis_obj3.tsv\n\t', Sys.time())
obj3 <- data.table::fread('/mnt/data/tmpdir/tmp--fixattempt2--gnosis_obj3.tsv') %>%
    dplyr::as_tibble() %>%
    dplyr::mutate(Date = as.Date(Date))


##
## message('...creating obj4\n\t', Sys.time())
## obj4 <- featureSets %>%
##     dplyr::group_by(featureset_id, cancer_id) %>%
##     dplyr::summarize(N_Features = dplyr::n()) %>%
##     dplyr::ungroup() %>%
##     dplyr::rename(Features = featureset_id, Project = cancer_id)
## message('### obj4 cols are ###')
## print(obj4)
## message('### obj4 cols are 22 ###')
## print(obj4$N_Features)

message('...now joining and adjusting col names\n\t', Sys.time())
suppressMessages({
  if (dim(predictions)[1] > 0) {
      model_summary <- dplyr::left_join(obj3,
        featureSets %>%
            dplyr::group_by(featureset_id, cancer_id) %>%
            dplyr::summarize(N_Features = dplyr::n()) %>%
            dplyr::ungroup() %>%
            dplyr::rename(Features = featureset_id, Project = cancer_id)
        ) %>%
        dplyr::group_by(Project) %>%
        dplyr::arrange(desc(TPR_Testing)) %>%
        dplyr::mutate(Model_Rank = dplyr::row_number()) %>%
        dplyr::arrange(Model_Rank, desc(TPR_Testing)) %>%
        dplyr::ungroup()
  } else {
    model_summary = dplyr::tibble(
      Project = character(),
      Model = character(),
      Features = character(),
      Date = date(),
      prediction_id = character(),
      TPR_Training = numeric(),
      TPR_Testing = numeric(),
      N_Features = numeric(),
      Model_Rank = numeric()
    )
  }
})


message('...populating selected models\n\t', Sys.time())
selected_models <- which(paste(model_summary$Project, model_summary$Model_Rank, sep = "|") %in% paste(cancers, 1,  sep = "|"))

message("selected models: ", paste(selected_models, collapse = ", "))




# ##-------------------------
# ## Global variables
# ##-------------------------
# DEFAULT_GRAPH <- ifelse(Sys.getenv("GDAN_TMP_GRAPH") == "", "gdan_tmp", Sys.getenv("GDAN_TMP_GRAPH"))
# DEFAULT_GRIP_HOST <- ifelse(Sys.getenv("GRIP_HOST") == "", "localhost:8201", Sys.getenv("GRIP_HOST"))
#
# message("GRIP HOST: ", DEFAULT_GRIP_HOST)
# message("GRAPH: ", DEFAULT_GRAPH)
#
# hclustfunc <- function(x, method = "complete", dmeth = "euclidean") {
#   hclust(dist(x, method = dmeth), method = method)
# }
#
# # source("helpers.R")
# # cancers <- getCancers()
# # features <- getFeatures()
# # featureSets <- getFeatureSets(NULL)
# # predictions <- getPredictions(NULL)
#
# message('...starting load_data.R\n\t', Sys.time())
# source("load_data.R")
# # creates variables:
# # predictions
# # featureSets
# # feature_con
# # cancers
# #
# message('...generating model summary\n\t', Sys.time())
# # message('...ADAM RANDOM FOREST - reading in tmp--obj3.tsv as obj3\n\t', Sys.time())
# # obj3 <- data.table::fread('/mnt/data/tmpdir/tmp--obj3.tsv') %>%
# #     dplyr::as_tibble() %>%
# #     # by default read in not as type date. so force it here
# #     dplyr::mutate(Date = as.Date(Date))
# message('...GNOSIS - reading in obj3.tsv as obj3\n\t', Sys.time())
# # obj3 <- data.table::fread('/mnt/data/tmpdir/tmp--gnosis_obj3.tsv') %>%
# # obj3 <- data.table::fread('/mnt/data/tmpdir/tmp--fixattempt2--gnosis_obj3.tsv') %>%
# # obj3 <- data.table::fread('/mnt/data/tmpdir/tmp--fixattempt2.4--gnosis_obj3.tsv') %>%
# obj3 <- data.table::fread('/mnt/data/tmpdir/tmp--combo_rf-gnosis_obj3.tsv') %>%
#     dplyr::as_tibble() %>%
#     # by default read in not as type date. so force it here
#     dplyr::mutate(Date = as.Date(Date))
#
# message('...creating obj4\n\t', Sys.time())
# obj4 <- featureSets %>%
#     dplyr::group_by(featureset_id, cancer_id) %>%
#     dplyr::summarize(N_Features = dplyr::n()) %>%
#     dplyr::ungroup() %>%
#     dplyr::rename(Features = featureset_id, Project = cancer_id)
#
# message('### obj4 cols are ###')
# print(obj4)
# message('### obj4 cols are 22 ###')
# print(obj4$N_Features)
#
# message('...now joining and adjusting col names\n\t', Sys.time())
# suppressMessages({
#   model_summary <- dplyr::left_join(obj3, obj4) %>%
#     dplyr::group_by(Project) %>%
#     dplyr::arrange(desc(TPR_Testing)) %>%
#     dplyr::mutate(Model_Rank = dplyr::row_number()) %>%
#     dplyr::arrange(Model_Rank, desc(TPR_Testing)) %>%
#     dplyr::ungroup()
# })
#
#
# message('...populating selected models\n\t', Sys.time())
# selected_models <- which(paste(model_summary$Project, model_summary$Model_Rank, sep = "|") %in% paste(cancers, 1,  sep = "|"))
#
# message("selected models: ", paste(selected_models, collapse = ", "))
