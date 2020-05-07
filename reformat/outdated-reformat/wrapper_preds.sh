#!/bin/bash

raw_dir=${1}
path_to_temp=${2}
output_dir=${3}

mkdir ${path_to_temp}/temp_preds

# reformat prediction files
    # TODO : add loop to process all files
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/ACC_single_sample_predictions.tsv \
    -out ${path_to_temp}/temp_preds/reformat-ACC_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/CESC_single_sample_predictions.tsv \
    -out ${path_to_temp}/temp_preds/reformat-CESC_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/ESCC_single_sample_predictions.tsv \
    -out ${path_to_temp}/temp_preds/reformat-ESCC_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/KIRCKICH_single_sample_predictions.tsv \
    -out ${path_to_temp}/temp_preds/reformat-KIRCKICH_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/KIRP_single_sample_predictions.tsv \
    -out ${path_to_temp}/temp_preds/reformat-KIRP_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/LIHCCHOL_single_sample_predictions.tsv \
    -out ${path_to_temp}/temp_preds/reformat-LIHCCHOL_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/MESO_single_sample_predictions.tsv \
    -out ${path_to_temp}/temp_preds/reformat-MESO_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/PAAD_single_sample_predictions.tsv \
    -out ${path_to_temp}/temp_preds/reformat-PAAD_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/PCPG_single_sample_predictions.tsv \
    -out ${path_to_temp}/temp_preds/reformat-PCPG_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/PRAD_single_sample_predictions.tsv \
    -out ${path_to_temp}/temp_preds/reformat-PRAD_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/SARC_single_sample_predictions.tsv \
    -out ${path_to_temp}/temp_preds/reformat-SARC_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/TGCT_single_sample_predictions.tsv \
    -out ${path_to_temp}/temp_preds/reformat-TGCT_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/THYM_single_sample_predictions.tsv \
    -out ${path_to_temp}/temp_preds/reformat-THYM_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/UVM_single_sample_predictions.tsv \
    -out ${path_to_temp}/temp_preds/reformat-UVM_single_sample_predictions.tsv


# Clean up code
python3 reformat-gnosis-preds-STEP2.py \
    -in ${path_to_temp} \
    -out ${output_dir}

rm -r temp_preds
