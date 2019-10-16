#!/bin/env python3

## imports
import random
import time
import numpy

## variables
r=1.2
K=1
sigma=.2
numyears=100

##func
def stochrick(p0=list([random.random()+.5 for i in range(1000)]),r=1.2,K=1,sigma=.2,numyears=100):
    ## initialize
    N=numpy.zeros((numyears,len(p0)))
    N[0,]=p0
    for pop in range(len(p0)):
        for yr in range(1,numyears):
            N