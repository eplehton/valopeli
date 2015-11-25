# -*- coding: utf-8 -*-
"""
Created on Thu Oct 15 13:18:52 2015

@author: eplehton
"""


import json
import numpy as np
subId = "Pilot-IAR6"

def rec2csv(rec, filename, replace_nan=None, **kwargs):
    """
        Suitable fmt string will be formed based on data types if
        not provided in keyworded arguments.
    """    
    
    f = open(filename, 'w')
    
    
    delimiter = kwargs['delimiter'] if 'delimiter' in kwargs else ' '
    
    fmt = ""    
    
    for i, name in enumerate(rec.dtype.names):
            
        # format string specification
        if i != 0: 
            fmt += delimiter
        
        t = rec.dtype[name]
        if np.issubdtype(np.int, t):
            fmt += "%d"
        elif np.issubdtype(np.float, t):
            fmt += "%.8f"
        elif np.issubdtype(str, t):
            fmt += "%s"
        else:
            print("data type not understood, will fail!", t)

        
        # header specification
        if i != 0: 
            f.write(delimiter)
        f.write(name)
        
    f.write("\n")    
    
    
    if not 'fmt' in kwargs:
        kwargs['fmt'] = fmt
    
    #print(fmt, kwargs['fmt'])    
    
    np.savetxt(f, rec, **kwargs)
    f.close()

    if replace_nan != None:
        f = open(filename, 'r')
        lines = f.readlines()
        for i, ln in enumerate(lines):
            lines[i] = ln.replace('nan', replace_nan)
        f.close()
        f = open(filename, 'w')
        f.writelines(lines)
        f.close()


with open('data/tulokset_' + subId + '.json') as f:
    
    
    data = json.load(f)
    

    games = data['games']
    
    round_table = {}
    
    for g in games:

        labels = ['gameNumber', 'successInStatic', 'isStatic', 'gameInterval', 'finalInterval', 'previousIntervalChange']
        for lab in labels:
            if not lab in round_table:
                round_table[lab] = []
            round_table[lab].append(g[lab])
        #r2 = r.copy()
        #del r2['presses']
        #round_lst.append(r2)
        
        
    round_lst = []
    for val in labels:
        round_lst.append(round_table[val])
    
    table = np.core.records.fromarrays(round_lst, names=labels)
    print(table)
    
    #table.tofile('data/rounds.txt', sep=',')
    rec2csv(table, 'data/' + subId + '_data.txt', delimiter=',')
    
    