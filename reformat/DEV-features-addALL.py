#!/usr/bin/env python3

## Purpose to run after reformat-gnosis-preds.py

import os
import glob

import argparse

def get_arguments():
    parser = argparse.ArgumentParser(description='')
    parser.add_argument("-in", "--input", help ="input dir", required=True, type=str)
    parser.add_argument("-out", "--output", help ="output dir", required=True, type=str)
    return parser.parse_args()

args = get_arguments()
f = args.input # /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/TESTING2/features_reformatted_gnosis20200408.tsv
ft_output = args.output # /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/TESTING2_output



# set up file names
outputname = "TESTING2--features_reformatted_gnosis20200408.tsv"

# Iterate through one file
with open(f, 'r') as fh, open(ft_output+"/"+outputname, 'w') as out:
    irow = 0
    for line in fh:
        # Write col headers to out
        if irow == 0:
            line = line.strip().split('\t')
            nmodels = len(line)
            print('total models', nmodels)
            samp = line[0]
            repeat = line[1]
            fold = line[2]
            # No reformat all meta data cols
            out.write(samp + '\t' + repeat + '\t'  + fold + "\n")
            irow+=1
        else:
            classifer = line.split('\t')[0]
            ftmethod = line.split('\t')[1]
            temporal = line.split('\t')[2]


            classifer = "ALL:" + classifer #new line


            newline = classifer + '\t' + ftmethod + '\t'  + temporal
            out.write(newline)


print('Created new file: ', outputname)
