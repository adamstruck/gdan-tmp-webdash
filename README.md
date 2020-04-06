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
├── original_pred_matrices  <- group results
├── feature-sets            <- MAIN: unified feature set of all group results
├── predictions             <- MAIN: group results
```

## Quick Start: Start the Shiny Application

- Create dirs with prefix `v8-` and fill contents (see General Organization)
- Prepare feature database `Rscript load_sqlite.R ./v8-feature-matrices/ ./features.sqlite`. Pulls only files ending in .tsv in v8-feature-matrices/
- Add prediction file(s) to: `data/predictions`. These are the classifier results.
- Add feature set file(s) to: `data/feature-sets`. These are the features the model was shown when producing classifier results
- Run the app

  ```
  docker-compose up
  ```

The app will be available at [http://localhost:3838](http://localhost:3838).

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

*Expected Data Directory Layout*

```
data/
├── features.sqlite
├── feature-sets
│   ├── featuresets_v8.tsv
│   └── ...
└── predictions
    ├── ACC_randomforest_200127.tsv
    └── ...
```


## Reformat Gnosis files as of 4/5/20

1. Fix feature set matrices format `wrapper_ftset.sh`

2. Fix prediction matrices format `wrapper_preds.sh`

3. Move these into `../data/feature-sets/` and `../data/predictions`
