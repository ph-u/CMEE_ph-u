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

## logistic equations
def func_log0(N0, K, r, t):
    """traditional Logistic equation"""
    Nt=N0*K*exp(r*t)/(K+N0*(exp(r*t)-1))
    return Nt

def func_Gom(Nmn, Nmx, rmx, ld, t):
    """modified Gompertz model"""
    A=log(Nmx/Nmn)
    Nt=A*exp(-exp(rmx*exp/A*(ld-t)+1))
    return Nt

def func_Bar(Nmn, Nmx, rmx, ld, t):
    """Baranyi model"""
    h0=(exp(ld*rmx)-1)^-1
    At=t+rmx^-1*log((exp(-rmx*t)+h0)/(1+h0))
    Nt=Nmn + rmx * At - log(1+exp(rmx * At - 1)/exp(Nmx-Nmn))
    return Nt

def func_Buc(Nmn, Nmx, tlag, t):
    """Buchanan model / three-phase logistic model"""
    if t <= tlag:
        Nt=Nmn
    elif t >= tmx:
        Nt=Nmx
    else: Nt=Nmx+rmx*(t-tlag)
    return Nt

## raw data
ls_f0=list(csv.reader(open("../data/Log_data.csv")))

## metadata arrangement
ls_f1=open("../data/Log_Metadata.txt").read().replace("\n","\t").split("\t")
if len(ls_f1)%2 != 0: ## if python read file badly
    del ls_f1[len(ls_f1)-1] ## completely empty line after indentation crucial

ls_f2=[[ls_f1[i],ls_f1[i+1]] for i in range(len(ls_f1)) if i%2 == 0];del i ## compensate for bad python readers
ls_f1=ls_f2;del ls_f2

## calculation
