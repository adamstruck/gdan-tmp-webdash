#!/bin/bash


# reformat prediction files

python3 reformat-gnosis-preds.py \
    -in /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/original_pred_matrices/Gnosis_results/2020-03-10_extracted/ACC_single_sample_predictions.tsv \
    -out /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/final_reformatted_files/reformat-ACC_single_sample_predictions.tsv

python3 reformat-gnosis-preds.py \
    -in /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/original_pred_matrices/Gnosis_results/2020-03-10_extracted/CESC_single_sample_predictions.tsv \
    -out /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/final_reformatted_files/reformat-CESC_single_sample_predictions.tsv

python3 reformat-gnosis-preds.py \
    -in /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/original_pred_matrices/Gnosis_results/2020-03-10_extracted/ESCC_single_sample_predictions.tsv \
    -out /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/final_reformatted_files/reformat-ESCC_single_sample_predictions.tsv

python3 reformat-gnosis-preds.py \
    -in /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/original_pred_matrices/Gnosis_results/2020-03-10_extracted/KIRCKICH_single_sample_predictions.tsv \
    -out /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/final_reformatted_files/reformat-KIRCKICH_single_sample_predictions.tsv

python3 reformat-gnosis-preds.py \
    -in /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/original_pred_matrices/Gnosis_results/2020-03-10_extracted/KIRP_single_sample_predictions.tsv \
    -out /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/final_reformatted_files/reformat-KIRP_single_sample_predictions.tsv

python3 reformat-gnosis-preds.py \
    -in /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/original_pred_matrices/Gnosis_results/2020-03-10_extracted/LIHCCHOL_single_sample_predictions.tsv \
    -out /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/final_reformatted_files/reformat-LIHCCHOL_single_sample_predictions.tsv

python3 reformat-gnosis-preds.py \
    -in /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/original_pred_matrices/Gnosis_results/2020-03-10_extracted/MESO_single_sample_predictions.tsv \
    -out /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/final_reformatted_files/reformat-MESO_single_sample_predictions.tsv

python3 reformat-gnosis-preds.py \
    -in /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/original_pred_matrices/Gnosis_results/2020-03-10_extracted/PAAD_single_sample_predictions.tsv \
    -out /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/final_reformatted_files/reformat-PAAD_single_sample_predictions.tsv

python3 reformat-gnosis-preds.py \
    -in /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/original_pred_matrices/Gnosis_results/2020-03-10_extracted/PCPG_single_sample_predictions.tsv \
    -out /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/final_reformatted_files/reformat-PCPG_single_sample_predictions.tsv

python3 reformat-gnosis-preds.py \
    -in /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/original_pred_matrices/Gnosis_results/2020-03-10_extracted/PRAD_single_sample_predictions.tsv \
    -out /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/final_reformatted_files/reformat-PRAD_single_sample_predictions.tsv

python3 reformat-gnosis-preds.py \
    -in /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/original_pred_matrices/Gnosis_results/2020-03-10_extracted/SARC_single_sample_predictions.tsv \
    -out /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/final_reformatted_files/reformat-SARC_single_sample_predictions.tsv

python3 reformat-gnosis-preds.py \
    -in /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/original_pred_matrices/Gnosis_results/2020-03-10_extracted/TGCT_single_sample_predictions.tsv \
    -out /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/final_reformatted_files/reformat-TGCT_single_sample_predictions.tsv

python3 reformat-gnosis-preds.py \
    -in /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/original_pred_matrices/Gnosis_results/2020-03-10_extracted/THYM_single_sample_predictions.tsv \
    -out /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/final_reformatted_files/reformat-THYM_single_sample_predictions.tsv

python3 reformat-gnosis-preds.py \
    -in /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/original_pred_matrices/Gnosis_results/2020-03-10_extracted/UVM_single_sample_predictions.tsv \
    -out /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/final_reformatted_files/reformat-UVM_single_sample_predictions.tsv


# temp fix of reformat - will incorporate into previous code to clean up later
python3 reformat-gnosis-preds-STEP2.py
