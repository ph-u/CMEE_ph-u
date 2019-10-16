#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Vectorize2.py
# Desc: R program substitution -- `Vectorize2` (compare initial and modified stochastic with gaussian fluctuations Ricker Eqn computational time)
# Input: python3 Vectorize2.py
# Output: two blocks of two-lined terminal output
# Arguments: 0
# Date: Oct 2019

"""
R program substitution -- Vectorize2 (compare initial and modified stochastic with gaussian fluctuations Ricker Eqn computational time)
"""

__appname__='Vectorize2.py'
__author__="PMH"
__version__="0.0.1"
__license__="None"

## imports
import random
import time
import numpy
import math

## variables

##func
def stochrick(p0=list([random.random()+.5 for i in range(1000)]),r=1.2,K=1,sigma=.2,numyears=100):
    ## initialize
    N=numpy.zeros((numyears,len(p0)))
    N[0,]=p0
    for pop in range(len(p0)):
        for yr in range(1,numyears):
            N[yr][pop]=N[yr-1][pop]*math.exp(r*(1-N[yr-1][pop]/K)+float(numpy.random.normal(0,sigma,1)))
    return N

def stochrick_m(p0=1000,r=1.2,K=1,sigma=0.2,numyears=100):
    ## initialize
    N=numpy.zeros((numyears,p0))
    N[0]=list([random.random()+.5 for i in range(p0)])
    ## calculate
    for pop in range(p0):
        for yr in range(1,numyears):
            N[yr][pop]=N[yr-1][pop]*math.exp(r*(1-N[yr-1][pop]/K)+float(numpy.random.normal(0,sigma,1)))
    return N

print("My Vectorized Stochastic Ricker takes:")
start=time.time()
stochrick_m()
print("%s" %(round(time.time()-start,3)))

print("Vectorized Stochastic Ricker takes:")
start=time.time()
stochrick()
print("%s" %(round(time.time()-start,3)))