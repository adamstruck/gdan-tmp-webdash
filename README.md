## Web Dashboard For Viewing GDAN TMP Machine Learning Results
https://www.synapse.org/#!Synapse:syn8011998/wiki/411602

## General Organization

```
data/
├── download_data.sh       <- download tarball
├── load_sqlite.R          <- prepare feature database
├── features.sqlite        <- output database
|
├── v8-cv-matrices          <- raw tarball contents
├── v8-feature-matrices     <- raw tarball contents
├── v8-qc                   <- raw tarball contents
|
├── original_pred_matrices  <- group results (previous group results raw, will be rm later)
├── tmpdir                  <- obj3 tsv
├── feature-sets            <- MAIN: unified feature set of all group results
|   ├── ...
|   └── ...
└── predictions             <- MAIN: group results
|   ├── ...
|   └── ...
|   
|
├── GROUP_RESULTS_RAW_FINAL
|   ├── AKLIMATE
|       └── aklimate_predictions_and_features_20200430.tar.gz
|   ├── CloudForest
|       └──
|   ├── GEXP_NN
|       ├── Features-20200320_allCOHORTS_20200203Tarball_JasleenGrewal.txt
|       └── 2020-03-20-allCOHORTS_20200203Tarball_JasleenGrewal.gz
|   ├── Gnosis_results
|       ├── 2020-04-08.zip
|       └── 2020-04-08_extracted
|           ├── ${tumor}_features_sets.tsv
|           └── ${tumor}_single_sample_predictions.tsv
|   └── OHSU_results
|       ├── fbed_rfe_feats.csv       <- feature set
|       └── reprocess.tgz            <- prediction files
|           ├── fbed_ada
|           ├── fbed_bnb
|           ├── fbed_dt
|           ├── fbed_et
|           ├── fbed_gnb
|           ├── fbed_gp
|           ├── fbed_knn
|           ├── fbed_logreg
|           ├── fbed_pa
|           ├── fbed_rf
|           ├── fbed_sgd
|           ├── fbed_svm
|           ├── rfe_ada
|           ├── rfe_bnb
|           ├── rfe_dt
|           ├── rfe_et
|           ├── rfe_gnb
|           ├── rfe_knn
|           ├── rfe_logreg
|           ├── rfe_pa
|           ├── rfe_rf
|           ├── rfe_sgd
|           ├── rfe_svm
```

## Quick Start: Start the Shiny Application

- Create dirs with prefix `v8-` and fill contents (see General Organization)
- Prepare feature database `Rscript load_sqlite.R ./v8-feature-matrices/ ./features.sqlite`. Pulls only files ending in .tsv in v8-feature-matrices/
- Add prediction file(s) to: `data/predictions`. These are the classifier results.
- Add feature set file(s) to: `data/feature-sets`. These are the features the model was shown when producing classifier results
- Create obj3 of prediction and feature-set dirs. Reduces memory usage when running app
```
Rscript gen-obj3.R <path/to/predictions_dir> <path/to/featureset_dir> <path>/data/tmpdir/tmp--combo_rf-gnosis_obj3.tsv
```

- Run the app

  ```
  docker-compose up
  ```

The app will be available at [http://localhost:3838](http://localhost:3838)

## (Optional) Download Data From Synapse

If you want to be able to examine feature values in the app do the following:

- Install the synapse python client:
  ```
  pip install synapseclient boto3
  ```
- Download the V8 tarball and place contents in appropriate `v8-` prefix dirs :

  ```
  cd data
  bash download_data.sh
  ```

- Prepare the feature database:

  ```
  Rscript load_sqlite.R ./v8-feature-matrices/ ./features.sqlite
  ```

- Run the app

  ```
  docker-compose up
  ```

## Reformat Gnosis_results/2020-03-10_extracted/

1. Fix feature set matrices format

```
cd reformat
bash wrapper_ftset.sh ~/Ellrott_Lab/gdan-tmp-webdash/data/original_pred_matrices/Gnosis_results/2020-03-10_extracted ~/Ellrott_Lab/gdan-tmp-webdash/reformat/temp_dir ~/Ellrott_Lab/gdan-tmp-webdash/data/feature-sets/fixattempt2--all-features_sets_gnosis_corrected.tsv
```

2. Fix prediction matrices format

```
cd reformat
bash wrapper_preds.sh /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/original_pred_matrices/Gnosis_results/2020-03-10_extracted /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/predictions/
```

# WIP - Reformat Gnosis_results/2020-04-08_extracted

Reformat Gnosis files - feature sets

- [x] Reformat Gnosis feature set files

1. Reformat feature set matrices

Run:

```
cd reformat
./wrapper_ftset.sh ../data/GROUP_RESULTS_RAW_FINAL/Gnosis_results/2020-04-08_extracted ./TEMP_DIR ../data/library_reformating/features_reformatted_gnosis20200408.tsv
```
outputs `data/library_reformating/features_reformatted_gnosis20200408.tsv`



+ Compare this with last run fixattempt2--reformat-${tumor}_single_sample_predictions.tsv
