#!/usr/bin/env python3

# fix final output of tmp--fixattempt2--gnosis_obj3.tsv where prediciton id is not matching

import os
import glob
##############
ft_input = '/Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/tmpdir/tmp--fixattempt2--gnosis_obj3.tsv'
ft_output = '/Users/leejor/Ellrott_Lab/gdan-tmp-webdash/data/tmpdir/tmp--fixattempt2.4--gnosis_obj3.tsv'
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

            # No reformat
            out.write(line[0]+ '\t'+ line[1]+ '\t'+ line[2]+ '\t'+ line[3]+ '\t'+ line[4]+ '\t'+ line[5])

            # reformat tumor
            predID = line[6]
            predID = predID.strip().strip("\"").split("|")
            classifer = predID[0]
            ftmethod = predID[1]
            ftmethod = "model" + ftmethod
            temporal = predID[2].split(" ")
            date = temporal[0]
            time = temporal[1]
            temporal = date + "T" + time
            crisp = predID[3]
            new = "\"" + classifer + "|" + ftmethod + "|" + temporal + "|" + crisp
            out.write("\t" + new + "\n")


fh.close()
out.close()
