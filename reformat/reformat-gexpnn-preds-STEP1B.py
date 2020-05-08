#!/usr/bin/env python3

import pandas as pd

ft_input='TEMP_DIR/tmp-predictions_reformatted_gexpnn20200320allCOHORTS.tsv'

df = pd.read_csv(ft_input,sep='\t')

# Get all tumors present in df (ACC, BRCA, ...)
temp = df['Label'].unique()
u_tumor = {} #k=tumor, v=1
for t in temp:
    t= t.split(":")[0]
    if t not in u_tumor:
        u_tumor[t]=1

# write out files for each tumor
for t in u_tumor:
    print('starting ', t)
    subset  = df[df['Label'].str.contains(t)]
    subset.to_csv('TEMP_DIR/intermediat-'+t+".tsv",sep='\t',index=False)
