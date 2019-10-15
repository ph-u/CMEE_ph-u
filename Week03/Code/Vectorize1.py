#!/bin/env python3

## imports
import random
import time
import numpy

## variables
M=[[random.random() for x in range(1000)]for y in range(1000)]

## func
def SumAllElements(M):
    Dimensions=[len(M),len(M[0])]
    Tot=0
    for i in range(Dimensions[0]):
        for j in range(Dimensions[1]):
            Tot=Tot+M[i][j]
    return(Tot)

print("Using loops, the time taken is:")
start=time.time()
SumAllElements(M)
print("%s" %(round(time.time()-start,3)))

print("Using the built vectorized function, the time taken is:")
start=time.time()
numpy.sum(M)
print("%s" %(round(time.time()-start,3)))