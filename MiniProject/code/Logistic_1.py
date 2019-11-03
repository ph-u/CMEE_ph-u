#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Logistic_1.py
# Desc: model-fitting for `LogisticGrowthMetaData.csv`
# Input: ```python3 Logistic_1.py```
# Output: analysis result output in `result` subdirectory
# Arguments: 0
# Date: Nov 2019

"""model-fitting for LogisticGrowthMetaData.csv"""

__appname__='Logistic_1.py'
__author__='PokMan HO (pok.ho19@imperial.ac.uk)'
__version__='0.0.1'
__license__='License for this code / program'

## lib
import sys
import os

## logistic equations
def log0(N0, r, t, K):
    """traditional Logistic equation"""
    a=N0*K*exp(r*t)/(K+N0*(exp(r*t)-1))
    return(a)
def Gom(Nmx, Nmn, rmx, ld, t):
    """modified Gompertz model"""
    a.0=log(Nmx/Nmn)
    a.1=a.0*exp(-exp(rmx*exp/a.0*(ld-t)+1))
    return(a.1)
def Bar(args):
    """Baranyi model"""

## raw data
