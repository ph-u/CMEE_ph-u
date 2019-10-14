#!/bin/env python3

## imports
import sys
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
f_1=open("../Data/trees.csv","r")
f_2=open("../results/TreesHts.csv","w")
f_0=list(csv.reader(f_1))
f_3=[]
f_3.append("Tree.Height.m")
for i in range(len(f_0)):
    if i==1: f_3[i]=

f_1.close();f_2.cose()