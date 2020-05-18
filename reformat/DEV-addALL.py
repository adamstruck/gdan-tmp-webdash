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
ft_input = args.input # /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/TESTING2
ft_output = args.output # /Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/TESTING2_output


# Read in all feature files from input dir
os.chdir(ft_input)
files = glob.glob('predictions_reformatted_gnosis20200408-*.tsv')


os.chdir(ft_output)
# Iterate through all files in a dir
for f in files:
    # set up file names
    tumor = f.strip().split("-")[1].split('_')[0] #a== ACC/etc
    outputname = "TESTING2--predictions_reformatted_gnosis20200408-" + tumor + ".tsv"

    # Iterate through one file
    with open(ft_input+"/"+f, 'r') as fh, open(outputname, 'w') as out:
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
                test = line[3]
                label = line[4]
                # No reformat all meta data cols
                out.write(samp + '\t' + repeat + '\t'  + fold + '\t'  + test + '\t'  + label)


                # reformat all models
                for i in range(5, nmodels):
                    header = line[i]
                    classifer = header.split('|')[0]
                    ftmethod = header.split('|')[1].strip("\"")
                    temporal = header.split('|')[2]
                    crisp = header.split('|')[3]

                    ftmethod = "ALL:" + ftmethod #new line


                    newline = classifer+ "|"+ftmethod+"|"+temporal+"|"+crisp
                    out.write('\t' + newline)

                out.write('\n')
                irow+=1
            else:
                out.write(line)

    print('Created new file: ', outputname)
