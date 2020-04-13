#!/bin/bash/env python3

## Purpose = reformat the feature files of gnosis.
## this will replace 01_unify-ftmat-crete.sh and 02_reformat-feature-set.py

import os
import glob
##############
ft_input = '/Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/data/original_pred_matrices/Gnosis_results/2020-03-10_extracted/'
ft_output = '/Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/processed'
##############



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
#             model = line[0]
#             tumor = line[1]
#             ftset = line[2]

#             # No reformat to model
#             out.write(model + '\t')

#             # reformat tumor
#             tumor = "[" + "\"" + tumor + "\"" + "]"
#             out.write(tumor + '\t')

#             # no reformat ftset
#             out.write(ftset + "\n")

# fh.close()
# out.close()




os.chdir(ft_output)

# Iterate through all files in a dir
for f in files:
    # set up file names
    a = f.strip().split("_")[0] #a== ACC/etc
    outputname = a + "_gnosis_corrected.tsv"


    # Reformat and save tsv outputs
    with open(ft_input+f, 'r') as fh, open(outputname, 'w') as out:
        irow = 0
        for line in fh:
            # Write col headers to out
            if irow == 0:
                out.write(line)
                irow+=1
            else:
                line = line.strip().split('\t')
                model = line[0]
                tumor = line[1]
                ftset = line[2]

                # No reformat to model
                out.write(model + '\t')

                # reformat tumor
                tumor = "[" + "\"" + tumor + "\"" + "]"
                out.write(tumor + '\t')

                # no reformat ftset
                out.write(ftset + "\n")

    fh.close()
    out.close()
    print("Created file: ", outputname)
