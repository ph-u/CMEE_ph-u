#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: profileme.py
# Desc: timing code run-time
# Input: python3 profileme.py
# Output: terminal output on timed code report
# Arguments: 0
# Date: Nov 2019


"""timing code run-time"""

__appname__="profileme.py"
__author__="PMH"
__version__="0.0.1"
__license__="None"

def my_squares(iters):
    """squaring loop function"""
    out=[]
    for i in range(iters):
        out.append(i**2)
    return out

def my_join(iters, string):
    """for loop on joining textstrings"""
    out=""
    for i in range(iters):
        out+=string.join(", ")
    return out

def run_my_funcs(x,y):
    """printing results"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(int(1e7),"My string")