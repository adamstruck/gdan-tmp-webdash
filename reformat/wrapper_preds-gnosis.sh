#!/bin/bash

raw_dir=${1} #absolute path to /data/GROUP_RESULTS_RAW_FINAL/Gnosis_results/2020-04-08_extracted
temp_dir=${2} # absolute path to /TEMP_DIR
output_dir=${3} #absolute path to /data/library_reformating
base=${4} #absolute path to /reformat

mkdir ${temp_dir}

# Reformat step 1: convert prob > crips predictions, classACC:2 or ACC:2 -> ACC:ACC_2
    # TODO : add loop to process all files
cd ${raw_dir}
echo 'starting reformat step 1'
commentlines=$(awk '/^#/{a++}END{print a}' ACC_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/ACC_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-ACC_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' BLCA_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/BLCA_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-BLCA_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' BRCA_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/BRCA_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-BRCA_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' CESC_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/CESC_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-CESC_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' COADREAD_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/COADREAD_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-COADREAD_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' ESCC_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/ESCC_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-ESCC_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' GEA_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/GEA_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-GEA_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' HNSC_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/HNSC_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-HNSC_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' KIRCKICH_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/KIRCKICH_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-KIRCKICH_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' KIRP_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/KIRP_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-KIRP_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' LGGGBM_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/LGGGBM_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-LGGGBM_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' LIHCCHOL_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/LIHCCHOL_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-LIHCCHOL_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' LUAD_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/LUAD_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-LUAD_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' LUSC_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/LUSC_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-LUSC_single_sample_predictions.tsv
echo 'finished 5 more'
commentlines=$(awk '/^#/{a++}END{print a}' MESO_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/MESO_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-MESO_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' OV_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/OV_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-OV_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' PAAD_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/PAAD_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-PAAD_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' PCPG_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/PCPG_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-PCPG_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' PRAD_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/PRAD_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-PRAD_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' SARC_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/SARC_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-SARC_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' SKCM_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/SKCM_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-SKCM_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' TGCT_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/TGCT_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-TGCT_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' THCA_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/THCA_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-THCA_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' THYM_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/THYM_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-THYM_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' UCEC_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/UCEC_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-UCEC_single_sample_predictions.tsv
commentlines=$(awk '/^#/{a++}END{print a}' UVM_single_sample_predictions.tsv)
python3 ${base}/reformat-gnosis-preds.py \
    -in ${raw_dir}/UVM_single_sample_predictions.tsv \
    -cl ${commentlines} \
    -out ${temp_dir}/reformat-UVM_single_sample_predictions.tsv


# Reformat step 2: 2020-03-13 08:17:44.059 -> 2020-03-13T08:17:44.059, add "model" infront of model int
echo 'Starting reformat step 2'
python3 ${base}/reformat-gnosis-preds-STEP2.py \
    -in ${temp_dir} \
    -out ${output_dir}

echo 'Cleaning up workspace'
rm -r ${temp_dir}
