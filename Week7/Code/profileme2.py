#!/bin/env python3

# Author: ph-u
# Script: profileme2.py
# Desc: timing code run-time
# Input: python3 profileme2.py
# Output: terminal output on timed code report
# Arguments: 0
# Date: Nov 2019


"""timing code run-time"""

__appname__="profileme2.py"
__author__="ph-u"
__version__="0.0.1"
__license__="None"

def my_squares(iters):
    """list comprehension on squaring function"""
    out=[i**2 for i in range(iters)]
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
