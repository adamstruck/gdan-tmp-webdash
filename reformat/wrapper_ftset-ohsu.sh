#!/bin/bash

raw_file=${1} #absolute path to /data/GROUP_RESULTS_RAW_FINAL/OHSU_results/fbed_rfe_feats.csv
output_file=${2} #absolute path to /data/library_reformating/features_reformatted_ohsu20200331.tsv

mkdir TEMP_DIR

# 1. reformat each individual tumor file
python reformat-ohsu-ftset.py \
    -in ${raw_file} \
    -out ${output_file}

rm -r TEMP_DIR
