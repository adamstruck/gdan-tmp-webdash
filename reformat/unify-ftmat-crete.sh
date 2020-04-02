#!/bin/bash

cd ../data/original_pred_matrices/Gnosis_results/2020-03-10_extracted/

echo 'will concat these files:'
ls -1  | grep .*features_sets*


{ cat ACC_features_sets.tsv; sed '1d' CESC_features_sets.tsv; \
    sed '1d' ESCC_features_sets.tsv; \
    sed '1d' KIRCKICH_features_sets.tsv; \
    sed '1d' KIRP_features_sets.tsv; \
    sed '1d' LIHCCHOL_features_sets.tsv; \
    sed '1d' MESO_features_sets.tsv; \
    sed '1d' PAAD_features_sets.tsv; \
    sed '1d' PCPG_features_sets.tsv; \
    sed '1d' PRAD_features_sets.tsv; \
    sed '1d' SARC_features_sets.tsv; \
    sed '1d' TGCT_features_sets.tsv; \
    sed '1d' THYM_features_sets.tsv; \
    sed '1d' UVM_features_sets.tsv; } \
    > ../../../../reformat/concat--2020-03-10_extracted--features_sets.tsv
