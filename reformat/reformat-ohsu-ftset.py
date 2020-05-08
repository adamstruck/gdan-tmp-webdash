#!/bin/bash/env python3

import os
import argparse
import pandas as pd

def get_arguments():
    parser = argparse.ArgumentParser(description='')
    parser.add_argument("-in", "--input", help ="input dir", required=True, type=str)
    parser.add_argument("-out", "--output", help ="output dir", required=True, type=str)
    return parser.parse_args()

args = get_arguments()
ft_input = args.input
ft_output = args.output

#convert to tsv
df = pd.read_csv(ft_input, sep=',')
df.to_csv("TEMP_DIR/fbed_rfe_feats.tsv", sep='\t', index=False)

# Reformat and save tsv outputs
with open('TEMP_DIR/fbed_rfe_feats.tsv', 'r') as fh, open(ft_output, 'w') as out:
    irow = 0
    for line in fh:
        # skip any commented lines
        if line.startswith("#"):
            continue
        # Write col headers to out
        elif irow == 0:
            line = line.split('\t')
            out.write(line[0]+'\t'+line[1]+'\t'+line[2])
            irow=1
        else:
            line = line.strip().split('\t')
            ftmethod = line[0]
            tumor = line[1]
            ftset = line[2]

            # No reformat to ftmethod
            out.write(ftmethod + '\t')

            # reformat tumor
            tumor = tumor.strip('"').strip("[").strip("]").replace('""','"')
            tumor = "[" + tumor + "]"
            out.write(tumor + '\t')

            # reformat ftset
            ftset = ftset.strip('"').replace('""','"').replace(" ","")
            out.write(ftset + "\n")


print("Created file: ", ft_output)
