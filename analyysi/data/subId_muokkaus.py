# -*- coding: utf-8 -*-
"""
Created on Tue Feb 16 16:03:05 2016

@author: Erno
"""

import json

n = '34'

with open('tulokset_KH' + n + '.json', 'r') as f:
    json_data = json.load(f)
    json_data['subId'] = "S" + n
    
with open('tulokset_KH' + n + '.json', 'w') as f:
    f.write(json.dumps(json_data))
    
    

