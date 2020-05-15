#!/bin/bash

# ./wrapper_preds-ohsu.sh /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/GROUP_RESULTS_RAW_FINAL/OHSU_results/sklrn_shiny_20200508 /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/TEMP_DIR /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/library_reformating

raw_dir=${1} #absolute path to /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/GROUP_RESULTS_RAW_FINAL/OHSU_results/sklrn_shiny_20200508
temp_dir=${2} #absolute path to /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/TEMP_DIR
output_dir=${3} #absolute path to /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/library_reformating

mkdir ${temp_dir}

# Reformat step 1: convert prob > crips predictions, classACC:2 or ACC:2 -> ACC:ACC_2
    # TODO : add loop to process all files
echo 'starting reformat step 1'
echo 'ACC'
python3 reformat-ohsu-preds.py \
    -in ${raw_dir}/sklrn_shiny_ACC_20200508.csv \
    -t ${temp_dir} \
    -out ${temp_dir}/predictions-ACC.tsv
echo 'BLCA'
python3 reformat-ohsu-preds.py \
    -in ${raw_dir}/sklrn_shiny_BLCA_20200508.csv \
    -t ${temp_dir} \
    -out ${temp_dir}/predictions-BLCA.tsv
# echo 'brca'
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_BRCA_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-BRCA.tsv
# echo 'cesc'
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_CESC_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-CESC.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_COADREAD_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-COADREAD.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_ESCC_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-ESCC.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_GEA_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-GEA.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_HNSC_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-HNSC.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_KIRCKICH_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-KIRCKICH.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_KIRP_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-KIRP.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_LGGGBM_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-LGGGBM.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_LIHCCHOL_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-LIHCCHOL.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_LUAD_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-LUAD.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_LUSC_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-LUSC.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_MESO_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-MESO.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_OV_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-OV.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_PAAD_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-PAAD.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_PCPG_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-PCPG.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_PRAD_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-PRAD.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_SARC_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-SARC.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_SKCM_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-SKCM.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_TGCT_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-TGCT.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_THCA_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-THCA.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_THYM_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-THYM.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_UCEC_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-UCEC.tsv
# python3 reformat-ohsu-preds.py \
#     -in ${raw_dir}/sklrn_shiny_UVM_20200508.csv \
#     -t ${temp_dir} \
#     -out ${temp_dir}/predictions-UVM.tsv
#
#
# # Reformat step 2: 2020-03-13 08:17:44.059 -> 2020-03-13T08:17:44.059, add "model" infront of model int
# echo 'Starting reformat step 2'
# python3 reformat-ohsu-preds-STEP2.py \
#     -in ${temp_dir} \
#     -out ${output_dir}
#
# echo 'Cleaning up workspace'
# rm -r ${temp_dir}
