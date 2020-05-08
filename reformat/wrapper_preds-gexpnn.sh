#!/bin/bash

raw_file=${1} #../data/GROUP_RESULTS_RAW_FINAL/GEXP_NN/2020-03-20-allCOHORTS_20200203Tarball_JasleenGrewal
temp_dir=${2} #./TEMP_DIR
output_dir=${3} #../data/library_reformating

mkdir ${temp_dir}

# Reformat step 1: convert prob > crips predictions, classACC:2 or ACC:2 -> ACC:ACC_2
    # TODO : add loop to process all files
echo 'starting reformat step 1'
python3 reformat-gexpnn-preds.py \
    -in ${raw_file} \
    -out ${temp_dir}/tmp-predictions_reformatted_gexpnn20200320allCOHORTS.tsv


# # Reformat step 2: 2020-03-13 08:17:44.059 -> 2020-03-13T08:17:44.059, add "model" infront of model int
# echo 'Starting reformat step 2'
# python3 reformat-gexpnn-preds-STEP2.py \
#     -in ${temp_dir} \
#     -out ${output_dir}
# 
# echo 'Cleaning up workspace'
# rm -r ${temp_dir}
