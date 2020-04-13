#!/bin/bash/env python3

## Purpose = reformat the feature files of gnosis.

import os
import glob

import argparse

def get_arguments():
    parser = argparse.ArgumentParser(description='')
    parser.add_argument("-in", "--input", help ="input dir", required=True, type=str)
    parser.add_argument("-out", "--output", help ="output dir", required=True, type=str)
    return parser.parse_args()

args = get_arguments()
ft_input = args.input
ft_output = args.output


# Read in all feature files from input dir
os.chdir(ft_input)
files = glob.glob('*_features_sets.tsv')

# # Iterate through one file
# with open(ft_input, 'r') as fh, open(ft_output, 'w') as out:
#     irow = 0
#     for line in fh:
#         # Write col headers to out
#         if irow == 0:
#             out.write(line)
#             irow+=1
#         else:
#             line = line.strip().split('\t')
#             ftmethod = line[0]
#             tumor = line[1]
#             ftset = line[2]

#             # No reformat to ftmethod
#             out.write(ftmethod + '\t')

#             # reformat tumor
#             tumor = "[" + "\"" + tumor + "\"" + "]"
#             out.write(tumor + '\t')

#             # no reformat ftset
#             out.write(ftset + "\n")


os.chdir(ft_output)
# Iterate through all files in a dir
for f in files:
    # set up file names
    a = f.strip().split("_")[0] #a== ACC/etc
    outputname = a + "_gnosis_corrected.tsv"


    # Reformat and save tsv outputs
    with open(ft_input+"/"+f, 'r') as fh, open(outputname, 'w') as out:
        irow = 0
        for line in fh:
            # Write col headers to out
            if irow == 0:
                out.write(line)
                irow+=1
            else:
                line = line.strip().split('\t')
                ftmethod = line[0]
                tumor = line[1]
                ftset = line[2]

                # No reformat to ftmethod
                ftmethod = 'model' + ftmethod
                out.write(ftmethod + '\t')

                # reformat tumor
                tumor = "[" + "\"" + tumor + "\"" + "]"
                out.write(tumor + '\t')

                # no reformat ftset
                out.write(ftset + "\n")

    print("Created file: ", outputname)
