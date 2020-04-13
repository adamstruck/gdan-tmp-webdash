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
message('...generating model summary\n\t', Sys.time())
# message('...ADAM RANDOM FOREST - reading in tmp--obj3.tsv as obj3\n\t', Sys.time())
# obj3 <- data.table::fread('/mnt/data/tmpdir/tmp--obj3.tsv') %>%
#     dplyr::as_tibble() %>%
#     # by default read in not as type date. so force it here
#     dplyr::mutate(Date = as.Date(Date))
message('...GNOSIS - reading in obj3.tsv as obj3\n\t', Sys.time())
# obj3 <- data.table::fread('/mnt/data/tmpdir/tmp--gnosis_obj3.tsv') %>%
# obj3 <- data.table::fread('/mnt/data/tmpdir/tmp--fixattempt2--gnosis_obj3.tsv') %>%
# obj3 <- data.table::fread('/mnt/data/tmpdir/tmp--fixattempt2.4--gnosis_obj3.tsv') %>%
obj3 <- data.table::fread('/mnt/data/tmpdir/tmp--combo_rf-gnosis_obj3.tsv') %>%
    dplyr::as_tibble() %>%
    # by default read in not as type date. so force it here
    dplyr::mutate(Date = as.Date(Date))

message('...creating obj4\n\t', Sys.time())
obj4 <- featureSets %>%
    dplyr::group_by(featureset_id, cancer_id) %>%
    dplyr::summarize(N_Features = dplyr::n()) %>%
    dplyr::ungroup() %>%
    dplyr::rename(Features = featureset_id, Project = cancer_id)

message('### obj4 cols are ###') #JAL
print(obj4)#JAL
message('### obj4 cols are 22 ###')#JAL
print(obj4$N_Features)#JAL

message('...now joining and adjusting col names\n\t', Sys.time())
suppressMessages({
  model_summary <- dplyr::left_join(obj3, obj4) %>%
    dplyr::group_by(Project) %>%
    dplyr::arrange(desc(TPR_Testing)) %>%
    dplyr::mutate(Model_Rank = dplyr::row_number()) %>%
    dplyr::arrange(Model_Rank, desc(TPR_Testing)) %>%
    dplyr::ungroup()
})


message('...populating selected models\n\t', Sys.time())
selected_models <- which(paste(model_summary$Project, model_summary$Model_Rank, sep = "|") %in% paste(cancers, 1,  sep = "|"))

message("selected models: ", paste(selected_models, collapse = ", "))



###### COPY OF KNOWN TO WORK CODE IS SHOWN BELOW ######
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
# source("load_data.R")
# # creates variables:
# # predictions
# # featureSets
# # feature_con
# # cancers
# #
# message('...generating model summary')
# suppressMessages({
#   model_summary <- dplyr::left_join(
#     # Join. so cols == c(cancer_id,model_id,featureset_id,testing,training,date,prediction_id)
#     dplyr::left_join(
#       predictions %>%
#         # create groups == which cols will be kept after next step
#         dplyr::group_by(cancer_id, model_id, featureset_id, type) %>%
#         # condense down so cols only are the4 sel above + 'correct' and 'total'
#         dplyr::summarize(correct = table(as.numeric(predicted_value) == as.numeric(actual_value))["TRUE"],
#                          total = dplyr::n()) %>%
#         dplyr::ungroup() %>%
#         # create tpr col and fill for each row. KEY is that now test and train are represented by sep rows (in type col)
#         dplyr::mutate(tpr = round(correct / total, digits = 3)) %>%
#         # keep only the specified cols
#         dplyr::select(cancer_id, model_id, featureset_id, type, tpr) %>%
#         # now reorganize info so that only have cols c('cancer_id', "model_id", 'featureset_id', 'testing', 'training')
#         tidyr::spread(type, tpr),
#       predictions %>%
#         # keep only specified rows
#         dplyr::select(cancer_id, model_id, featureset_id, date, prediction_id) %>%
#         # keep only rows that are not repeats of other rows
#         dplyr::distinct()
#     ) %>%
#       dplyr::rename(Project = cancer_id, Model = model_id, Features = featureset_id,
#                     Date = date, TPR_Training = training, TPR_Testing = testing),
#     featureSets %>%
#       dplyr::group_by(featureset_id, cancer_id) %>%
#       dplyr::summarize(N_Features = dplyr::n()) %>%
#       dplyr::ungroup() %>%
#       dplyr::rename(Features = featureset_id, Project = cancer_id)
#   ) %>%
#     dplyr::group_by(Project) %>%
#     dplyr::arrange(desc(TPR_Testing)) %>%
#     dplyr::mutate(Model_Rank = dplyr::row_number()) %>%
#     dplyr::arrange(Model_Rank, desc(TPR_Testing)) %>%
#     dplyr::ungroup()
# })
#
# message('...populating selected models')
# selected_models <- which(paste(model_summary$Project, model_summary$Model_Rank, sep = "|") %in% paste(cancers, 1,  sep = "|"))
#
# message("selected models: ", paste(selected_models, collapse = ", "))
