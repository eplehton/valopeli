# -*- coding: utf-8 -*-
"""
Created on Tue Oct 27 16:12:58 2015

@author: eplehton
"""

import matplotlib.pyplot as plt
import numpy as np
from scipy.special import expit
from scipy.special import logit
from scipy.stats import norm

expit(0.342)

c = -2

x = np.linspace(-10.0, 10.0, 100)

y = expit(x)

plt.plot(x + 400, y)




performance = norm.rvs(loc=0.7, scale=.01, size=10)


logit(performance)



## sigmoidisen funktion hakeminen

from scipy import stats
import numpy as np
from scipy.optimize import minimize
import pylab as py

#ydata = np.array([0.1,0.15,0.2,0.3,0.7,0.8,0.9, 0.9, 0.95])
#xdata = np.array(range(0,len(ydata),1))

ydata = np.array([0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9])
xdata = np.array([340, 350, 370, 382, 400, 450, 475, 500, 550])


def sigmoid(params):
    k = params[0]
    x0 = params[1]   
    sd = params[2]

    yPred = 1 / (1+ np.exp(-k*(xdata-x0)))

    # Calculate negative log likelihood
    LL = -np.sum( stats.norm.logpdf(ydata, loc=yPred, scale=sd ) )

    return(LL)


initParams = [1, 400, 0.1]

results = minimize(sigmoid, initParams, method='Nelder-Mead')
print(results.x)

estParms = results.x
yOut = yPred = 1 / (1+ np.exp(-estParms[0]*(xdata-estParms[1])))

py.clf()
py.plot(xdata,ydata, 'go')
py.plot(xdata, yOut)
py.show()




def muutos(desired_outcome_p, outcome, epsilon):
    
    outcome_p = 1.0 * np.sum(outcome) / len(outcome)    
    
    delta = desired_outcome_p - outcome_p
    
    print(desired_outcome_p, outcome_p, )
    print(delta)
    
    return epsilon * delta

    
muutos(0.5, [0, 1, 1, 0, 1, 1, 1, 0, 1], 50)


def muutos2(desired_outcome_p, outcome, epsilon):
    #outcome_p = 1.0 * np.sum(outcome) / len(outcome)    
    
    #delta = desired_outcome_p - outcome_p
    print(outcome)    
    weights = np.linspace(0, 1, len(outcome))    
    
    delta2 = np.mean(weights * (desired_outcome_p - np.array(outcome)))
    
    return epsilon * delta2
    
    

changes = []
outcome_ps = []

for i in range(100):
    out = np.random.random_integers(0, 1, size=10)
    op = 1.0 * np.sum(out) / len(out)
    outcome_ps.append(op)
    
    c = muutos2(0.5, out, 50)  
    changes.append(c)
    
plt.plot(changes, outcome_ps, '.')

    


#x0 = 400
#k = 1.0
#L = 1.0
#
#yPred = L / (1 + np.exp( -k * (xdata-x0)))
#
#plt.plot(xdata, yPred)


def playerSigmoid(interval):
    return 1 / (1+ np.exp(-estParms[0]*(interval-estParms[1])))
    

outcomes = []
interval = 420
for i in range(100):
    
    p = playerSigmoid(interval)
    r = np.random.random()
    out = 1 * (r < p)
    outcomes.append(out)
    print(out)
    
print( np.mean(outcomes) )
    

outcomes = []
interval = 300
intervals = []
sigmoid_values = []

for i in range(100):
    
    p = playerSigmoid(interval)
    r = np.random.random()
    out = 1 * (r < p)

    outcomes.append(out)
    
    #if len(outcomes) > 20:
    #    deltaInterval = muutos2(0.7, outcomes[-21:-1], 30)
    #    interval += deltaInterval 
    #    print(interval, deltaInterval)
        
    #if len(outcomes) > 20:
    deltaInterval = muutos2(0.5, outcomes, 50)
    interval += deltaInterval 
    print(interval, deltaInterval)


    sigmoid_values.append(p)    
    intervals.append(interval)
    
    
print( np.mean(outcomes) )
plt.plot(intervals)
plt.plot(intervals, sigmoid_values)

    


    
    
    