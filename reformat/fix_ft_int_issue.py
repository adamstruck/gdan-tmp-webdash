#!/usr/bin/env python3


# purpose is to attempt to fix incompatible type char/int issue when run shiny app
    # attempt to change model name 6 --> 'model6' in 3 places
    # 1. predictions/
    # 2. feature-sets/
    # tmpdir/tmp--gnosis*** obj3 writout

############## obj3 writout
ft_input = '/Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/tmpdir/tmp--gnosis_obj3.tsv'
ft_output = '/Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/tmpdir/tmp--fixattempt2--gnosis_obj3.tsv'
##############
# Iterate through one file
with open(ft_input, 'r') as fh, open(ft_output, 'w') as out:
    irow = 0
    for line in fh:
        # Write col headers to out
        if irow == 0:
            out.write(line)
            irow+=1
        else:
            line = line.strip().split('\t')
            proj = line[0]
            classifer = line[1]
            ftmethod = line[2].strip("\"")
            test = line[3]
            train = line[4]
            date = line[5]
            pred_id = line[6]

            # No reformat
            out.write(proj + '\t')
            out.write(classifer + '\t')

            # Reformat so clear string
            ftmethod = "\"" + 'model' + ftmethod + "\""
            out.write(ftmethod + '\t')

            # No reformat
            out.write(test + '\t')
            out.write(train + '\t')
            out.write(date + '\t')
            out.write(pred_id + "\n")

fh.close()
out.close()


























############## Feature set matrix
ft_input = '/Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/GNOSIS_FIRST-feature-sets/all-features_sets_gnosis_corrected.tsv'
ft_output = '/Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/feature-sets/fixattempt2--all-features_sets_gnosis_corrected.tsv'
##############
# Iterate through one file
with open(ft_input, 'r') as fh, open(ft_output, 'w') as out:
    irow = 0
    for line in fh:
        # Write col headers to out
        if irow == 0:
            out.write(line)
            irow+=1
        else:
            line = line.strip().split('\t')
            model = line[0].strip("\"")
            tumor = line[1]
            ftset = line[2]

            # Reformat so clear string
            model = 'model' + model
            out.write(model + '\t')

            # No reformat to tumor
            out.write(tumor + '\t')

            # no reformat ftset
            out.write(ftset + "\n")

fh.close()
out.close()



############## Prediction files
ft_input = '/Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/GNOSIS_FIRST-predictions/'
ft_output = '/Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/predictions/'
##############
import os
import glob

# Read in all feature files from input dir
os.chdir(ft_input)
files = glob.glob('reformat*single_sample_predictions.tsv')


os.chdir(ft_output)
# Iterate through all files in a dir
for f in files:
    # set up file names
    a = f.strip()
    outputname = "fixattempt2--" + a

    # Reformat and save tsv outputs
    with open(ft_input+f, 'r') as fh, open(outputname, 'w') as out:
        irow = 0
        for line in fh:
            # fix col headers
            if irow == 0:
                line = line.strip().split('\t')
                nitems = len(line)
                s = line[0]
                r = line[1]
                f = line[2]
                t = line[3]
                l = line[4]

                # No reformat
                out.write(s + '\t')
                out.write(r + '\t')
                out.write(f + '\t')
                out.write(t + '\t')
                out.write(l)

                # reformat all models
                for i in range(5, nitems):
                    header = line[i]
                    classifer = header.split('|')[0]
                    ftmethod = header.split('|')[1].strip("\"")
                    temporal = header.split('|')[2]
                    crisp = header.split('|')[3]

                    #add "model" infront of model int
                    ftmethod = "model" + ftmethod

                    #fix temporal. 2020-03-13 08:17:44.059 -> 2020-03-13T08:17:44.059
                    date = temporal.split(" ")[0]
                    clock = temporal.split(" ")[1]
                    temporal = date + "T" + clock

                    newline = classifer+ "|"+ftmethod+"|"+temporal+"|"+crisp
                    out.write('\t' + newline)
                out.write('\n')
                irow+=1
            #Write all non col headers to out
            else:
                out.write(line)


    fh.close()
    out.close()
    print("Created file: ", outputname)
