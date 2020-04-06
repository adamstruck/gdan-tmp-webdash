#!/bin/bash

# 1. reformat each individual tumor file
python reformat-gnosis-ftset.py

# 2. concat all tumor files into one
cd processed

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
    > /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/final_reformatted_files/all-features_sets_gnosis_corrected.tsv
