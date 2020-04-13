#!/usr/bin/env python3

#######
# Imports and functions
#######

import json
import pandas as pd
import argparse


def get_arguments():
    parser = argparse.ArgumentParser(description='')
    parser.add_argument("-in", "--input", help ="name of input file", required=True, type=str)
    parser.add_argument("-out", "--output", help ="name of output file", required=True, type=str)
    return parser.parse_args()

args = get_arguments()
pred_file = args.input
output_name = args.output



def prob2crisp(name):
    """
    input one model name that will convert last bit of p to c
    """
    new_model_name = name.split('|')[: -1]
    new_model_name.append('c')#add c for crisp
    new_model_name = '|'.join(new_model_name)
    return new_model_name

def qc_prediction(PREDICTION_C):
    import re
    # 1. Search and remove class if in string. classACC:2 -> ACC:2
    wrong = re.match('class', PREDICTION_C)
    if wrong:
        PREDICTION_C = re.sub('class', '', PREDICTION_C)
        #print(PREDICTION_C)

    # 2. Search and replace subtype name. ACC:2 -> ACC:ACC_2
    tumor, subtype = re.split(r":", PREDICTION_C)
    if tumor not in subtype:
        PREDICTION_C = re.sub(subtype, tumor+"_"+subtype, PREDICTION_C)
        #print(PREDICTION_C)
    return PREDICTION_C


#####
# Read in
#####
# Read in file
raw_pred = pd.read_csv(pred_file, skiprows=4178, sep='\t')
# raw_pred = pd.read_csv(pred_file, skiprows=4178, sep='\t', index_col=0)
#raw_pred


#####
# Create template of new file of crisp predictions
#####
matrix_crisp = raw_pred.iloc[:, :4]
#check format Labels col. ACC:2 -> ACC:ACC_2
tmp = []
for i in raw_pred["Label"]:
    if i != qc_prediction(i):
        i = qc_prediction(i)
        tmp.append(i)
    else:
        tmp.append(i)
#add Label col to matrix
matrix_crisp['Label']= tmp
#matrix_crisp


######
# Create crisp matrix
######
# create df of just model predictions
df = raw_pred.iloc[:,5:]

models = df.columns

col_ct = 0 # debugging
row_ct = 0 # debugging

for m in models:
    #print("###", i, "###")
    # get crisp label from probabilites in a given cell
    new_col = []
    for row in df[m]:
        #print(row)
        row = row.replace('~0', '0') #rm ~
        contents_dict = json.loads(row)
        for k,v in contents_dict.items():
            if k=='classification':
                #print(v)
                subtype_crisp = max(v, key=v.get)
                subtype_crisp = qc_prediction(subtype_crisp)
                #print(subtype_crisp)
                new_col.append(subtype_crisp)

        row_ct+=1
    #add crisp to matrix_crisp
    i = prob2crisp(m)
    matrix_crisp[i] = new_col

    col_ct+=1


#rename col
matrix_crisp=matrix_crisp.rename(columns = {'Unnamed: 0':'Sample_ID'})
# save output
matrix_crisp.to_csv(output_name, sep='\t', index=False)
