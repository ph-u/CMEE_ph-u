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
import csv ## read, write csv
import math ## math operation definitions
import lmfit ## non-linear model fitting <https://lmfit.github.io/lmfit-py/ ; http://cars9.uchicago.edu/software/python/lmfit/lmfit.pdf>

## logistic equations
def func_log0(N0, K, r, t):
    """traditional Logistic equation"""
    Nt=N0*K*math.exp(r*t)/(K+N0*(math.exp(r*t)-1))
    return Nt

def func_Gom(N0, K, r, ld, t):
    """modified Gompertz model"""
    A=log(K/N0)
    Nt=A*math.exp(-math.exp(r*math.exp(1)/A*(ld-t)+1))
    return Nt

def func_Bar(N0, K, r, ld, t):
    """Baranyi model"""
    h0=(math.exp(ld*r)-1)^-1
    At=t+r^-1*log((math.exp(-r*t)+h0)/(1+h0))
    Nt=N0 + r * At - log(1+math.exp(r * At - 1)/math.exp(K-N0))
    return Nt

def func_Buc(N0, K, tlag, tmx, t):
    """Buchanan model / three-phase logistic model"""
    if t <= tlag:
        Nt=N0
    elif t >= tmx:
        Nt=K
    else: Nt=K+r*(t-tlag)
    return Nt

## raw data
ls_f0=list(csv.reader(open("../data/Log_data.csv")))

## metadata arrangement
ls_f1=open("../data/Log_Metadata.txt").read().replace("\n","\t").split("\t")
if len(ls_f1)%2 != 0: ## if python read file badly
    del ls_f1[len(ls_f1)-1]
    ## completely empty line after indentation crucial

ls_f2=[[ls_f1[i],ls_f1[i+1]] for i in range(len(ls_f1)) if i%2 == 0];del i ## compensate for bad python readers
ls_f1=ls_f2;del ls_f2

## set parameters for calculations
dic_par={
    "N0": float(ls_f1[20][1]),
    "K": float(ls_f1[22][1]),
    "r": ,
    "tlag": ,
    "tmx": ,
    "ld": ,
    "t": 
}
minimize(func_log0, dic_par,)