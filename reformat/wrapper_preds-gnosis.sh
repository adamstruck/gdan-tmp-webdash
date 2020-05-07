#!/bin/bash

raw_dir=${1} #../data/GROUP_RESULTS_RAW_FINAL/Gnosis_results/2020-04-08_extracted
temp_dir=${2} #./TEMP_DIR
output_dir=${3} #../data/library_reformating

mkdir ${temp_dir}

# Reformat step 1: convert prob > crips predictions, classACC:2 or ACC:2 -> ACC:ACC_2
    # TODO : add loop to process all files
echo 'starting reformat step 1'
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/ACC_single_sample_predictions.tsv \
    -out ${temp_dir}/reformat-ACC_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/CESC_single_sample_predictions.tsv \
    -out ${temp_dir}/reformat-CESC_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/ESCC_single_sample_predictions.tsv \
    -out ${temp_dir}/reformat-ESCC_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/KIRCKICH_single_sample_predictions.tsv \
    -out ${temp_dir}/reformat-KIRCKICH_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/KIRP_single_sample_predictions.tsv \
    -out ${temp_dir}/reformat-KIRP_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/LIHCCHOL_single_sample_predictions.tsv \
    -out ${temp_dir}/reformat-LIHCCHOL_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/MESO_single_sample_predictions.tsv \
    -out ${temp_dir}/reformat-MESO_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/PAAD_single_sample_predictions.tsv \
    -out ${temp_dir}/reformat-PAAD_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/PCPG_single_sample_predictions.tsv \
    -out ${temp_dir}/reformat-PCPG_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/PRAD_single_sample_predictions.tsv \
    -out ${temp_dir}/reformat-PRAD_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/SARC_single_sample_predictions.tsv \
    -out ${temp_dir}/reformat-SARC_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/TGCT_single_sample_predictions.tsv \
    -out ${temp_dir}/reformat-TGCT_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/THYM_single_sample_predictions.tsv \
    -out ${temp_dir}/reformat-THYM_single_sample_predictions.tsv
python3 reformat-gnosis-preds.py \
    -in ${raw_dir}/UVM_single_sample_predictions.tsv \
    -out ${temp_dir}/reformat-UVM_single_sample_predictions.tsv


# Reformat step 2: 2020-03-13 08:17:44.059 -> 2020-03-13T08:17:44.059, add "model" infront of model int
echo 'Starting reformat step 2'
python3 reformat-gnosis-preds-STEP2.py \
    -in ${temp_dir} \
    -out ${output_dir}

echo 'Cleaning up workspace'
rm -r ${temp_dir}
