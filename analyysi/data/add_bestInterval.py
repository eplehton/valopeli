# -*- coding: utf-8 -*-
"""
Created on Sun Mar 20 12:07:25 2016

@author: Erno
"""

n = '30_TESTI'

import json


with open('tulokset_KH' + n + '.json', 'r') as f:
    json_data = json.load(f)
    
print json_data[round]
    