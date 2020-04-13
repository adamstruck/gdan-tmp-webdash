#!/bin/bash

raw_dir=${1}
temp_dir=${2}
output_dir=${3}

mkdir temp_dir

# 1. reformat each individual tumor file
python reformat-gnosis-ftset.py \
    -in ${raw_dir} \
    -out ${temp_dir}
# python reformat-gnosis-ftset.py \
#     -in ~/Ellrott_Lab/gdan-tmp-webdash/data/original_pred_matrices/Gnosis_results/2020-03-10_extracted/ \
#     -out ~/Ellrott_Lab/gdan-tmp-webdash/reformat/temp_dir

# 2. concat all tumor files into one
cd temp_dir

echo 'will concat these files:'
ls -1  | grep .*gnosis_corrected.tsv

{ head -1 ACC_gnosis_corrected.tsv; \
    sed '1d' ACC_gnosis_corrected.tsv; \
    sed '1d' CESC_gnosis_corrected.tsv; \
    sed '1d' ESCC_gnosis_corrected.tsv; \
    sed '1d' KIRCKICH_gnosis_corrected.tsv; \
    sed '1d' KIRP_gnosis_corrected.tsv; \
    sed '1d' LIHCCHOL_gnosis_corrected.tsv; \
    sed '1d' MESO_gnosis_corrected.tsv; \
    sed '1d' PAAD_gnosis_corrected.tsv; \
    sed '1d' PCPG_gnosis_corrected.tsv; \
    sed '1d' PRAD_gnosis_corrected.tsv; \
    sed '1d' SARC_gnosis_corrected.tsv; \
    sed '1d' TGCT_gnosis_corrected.tsv; \
    sed '1d' THYM_gnosis_corrected.tsv; \
    sed '1d' UVM_gnosis_corrected.tsv; } \
    > ${output_dir}

cd ..
rm -r temp_dir
