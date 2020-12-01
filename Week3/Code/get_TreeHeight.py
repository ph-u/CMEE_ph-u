#!/bin/env python3

# Author: ph-u
# Script: get_TreeHeight.py
# Desc: R program substitution -- Tree Height calculation
# Input: python3 get_TreeHeight.py <.csv>
# Output: `<.csv>_treeheights.csv` in `Results` subdirectory
# Arguments: 1
# Date: Oct 2019

"""
R program substitution -- Tree Height calculation
"""

__appname__="get_TreeHeight.py"
__author__="ph-u"
__version__="0.0.1"
__license__="None"

## imports
import sys
import os
import math
import csv

## function
def TreeHeight(deg,dist):
    ## deg: degree, angle of elevation
    ## dist: distance between measurer and tree
    ## rad: radian, calculate from degree
    H=dist*math.tan(math.radians(deg))
    return H

## workflow

## if no sys.argv
if len(sys.argv)>1:

## working directory orientation issue
    os.chdir(os.path.dirname(sys.argv[1]))
    bn=os.path.basename(sys.argv[1]).split(".")[0]

## read csv
    f_0=list(csv.reader(open(sys.argv[1],"r")))
else:
    f_0=list(csv.reader(open("../Data/trees.csv","r")))
    bn="trees"

## calculation -- rubbish python core on data handling (https://stackoverflow.com/questions/44360162/how-to-access-a-column-in-a-list-of-lists-in-python)
for i in range(len(f_0)):
    if i==0: f_0[0].append("Tree.Height.m")
    else: f_0[i].append(TreeHeight(float(f_0[i][2]),float(f_0[i][1])))

## write result as csv
with open(str("../Results/"+bn+"_treeheights.csv"),"w") as csvfile: 
    csvW=csv.writer(csvfile)
    csvW.writerows(i for i in f_0)
