#!/bin/bash

raw_file=${1} #../data/GROUP_RESULTS_RAW_FINAL/GEXP_NN/Features-20200320_allCOHORTS_20200203Tarball_JasleenGrewal.txt
output_file=${2} #../data/library_reformating/features_reformatted_gexpnn20200320allCOHORTS.tsv

# 1. reformat feature file
python reformat-gexpnn-ftset.py \
    -in ${raw_file} \
    -out ${output_file}

echo 'Created file: '${output_file}
