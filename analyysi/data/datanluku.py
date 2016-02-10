# -*- coding: utf-8 -*-
"""
Created on Thu Oct 15 13:18:52 2015

@author: eplehton
"""


import json
import numpy as np


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
        elif np.issubdtype('S', t):
            fmt += "%s"
        elif np.issubdtype('U', t):
            fmt += "%U"
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





def processFile(filename):
    with open(filename) as f:
        
        
        data = json.load(f)
        
        sub_id = "{0}".format(data['subId'])
        rounds = data['rounds']
        
        data_table = {}
    
        game_labels = ['isTestGame', 'successInStatic', 'gameNumber', 'gameInterval', 'previousIntervalChange', 'pressesToSuccess', 'duration']    
        
        labels = ['subId', 'roundId', 'group']    
        labels.extend(game_labels)
    
        for lab in labels:
            data_table[lab] = []    
        
        for r in rounds: 
            
            round_id = int(r['roundId'])
            group = int(r['group'])
            
            games = r['games']
            
            
            for g in games:            
                print(g)
                for glab in game_labels:            
                    if not glab in g:
                        val = 0
                    else:
                        val = g[glab]
                    data_table[glab].append(val)
                    #data_table[glab].append(g[glab])
                data_table['subId'].append(sub_id)
                data_table['roundId'].append(round_id)
                data_table['group'].append(group)
                
            
        round_lst = []
        for val in labels:
            round_lst.append(data_table[val])
        
        table = np.core.records.fromarrays(round_lst, names=labels)
        
        return table
        #np.savetxt('data/rounds.txt', table)
        #rec2csv(table, subId +  '_data.txt', delimiter=',')
        

#import sys
#subId = sys.argv[1]

import glob
jsonFiles = glob.glob('*.json')

dataTables = []
for jfile in jsonFiles:
    dt = processFile(jfile)
    dataTables.append(dt)

bigDataTable = np.hstack(dataTables)

rec2csv(bigDataTable, 'datat.txt', delimiter=',')






