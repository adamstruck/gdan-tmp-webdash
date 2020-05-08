#!/bin/bash

raw_dir=${1} #../data/GROUP_RESULTS_RAW_FINAL/AKLIMATE/aklimate_predictions_and_features_20200430
output_file=${2} # <absolutepathto-data/library_reformating/features_reformatted_aklimate20200430.tsv>


cd ${raw_dir}


{ head -1 ACC/features.tsv; \
    sed '1d' BLCA/features.tsv; \
    sed '1d' BRCA/features.tsv; \
    sed '1d' CESC/features.tsv; \
    sed '1d' COADREAD/features.tsv; \
    sed '1d' ESCC/features.tsv; \
    sed '1d' GEA/features.tsv; \
    sed '1d' HNSC/features.tsv; \
    sed '1d' KIRCKICH/features.tsv; \
    sed '1d' KIRP/features.tsv; \
    sed '1d' LGGGBM/features.tsv; \
    sed '1d' LIHCCHOL/features.tsv; \
    sed '1d' LUAD/features.tsv; \
    sed '1d' LUSC/features.tsv; \
    sed '1d' MESO/features.tsv; \
    sed '1d' OV/features.tsv; \
    sed '1d' PAAD/features.tsv; \
    sed '1d' PCPG/features.tsv; \
    sed '1d' PRAD/features.tsv; \
    sed '1d' SARC/features.tsv; \
    sed '1d' SKCM/features.tsv; \
    sed '1d' TGCT/features.tsv; \
    sed '1d' THCA/features.tsv; \
    sed '1d' THYM/features.tsv; \
    sed '1d' UCEC/features.tsv; \
    sed '1d' UVM/features.tsv; } \
    > ${output_file}
