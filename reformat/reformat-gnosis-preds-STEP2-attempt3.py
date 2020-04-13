#!/usr/bin/env python3

## Purpose to run after reformat-gnosis-preds.py

import os
import glob
##############
ft_input = '/Users/leejor/Ellrott_Lab/gdan-tmp-webdash/reformat/final_reformatted_files/'
ft_output = "/Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data//GNOSIS-fixattempt3-predictions/"
##############

# Read in all feature files from input dir
os.chdir(ft_input)
files = glob.glob('reformat-*_single_sample_predictions.tsv')


os.chdir(ft_output)
# Iterate through all files in a dir
for f in files:
    # set up file names
    tumor = f.strip().split("-")[1].split('_')[0] #a== ACC/etc
    outputname = "reformat-" + tumor + "_single_sample_predictions.tsv"

    # Iterate through one file
    with open(ft_input+f, 'r') as fh, open(outputname, 'w') as out:
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

                # fix headers of model
                for i in range(5, nmodels):
                    model = line[i]
                    classifer = model.strip().split("|")[0]
                    ftmethod = model.strip().split("|")[1]
                    temporal = model.strip().split("|")[2]
                    date = temporal.split(" ")[0]
                    time = temporal.split(" ")[1]
                    crisp = model.strip().split("|")[3]

                    classifer = tumor+":"+classifer
                    ftmethod = tumor + ":model" + ftmethod
                    temporal = date + "T" + time
                    #print(model)
                    print(classifer, ftmethod, temporal, crisp)

                    out.write("\t" + classifer + "|" + ftmethod + "|" + temporal + "|" + crisp)

                # add tumor type to start of model name
                out.write('\n')

                irow+=1
            else:
                out.write(line)

    fh.close()
    out.close()
    print('Created new file: ', outputname)
