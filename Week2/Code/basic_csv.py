#!/bin/env python3

# Author: ph-u
# Script: basic_csv.py
# Desc: 1. python interpreter read `csv` file and extract first element (species); 2. copy specific column "bodymass" from `testcsv.csv` file to a new `csv` file (`bodymass.csv`)
# Input: python3 basic_csv.py
# Output: 1. 30-lined python interpreter output; 2. saves the output into a `csv` file in `Data` subdirectory
# Arguments: 0
# Date: Oct 2019

""" uses
1. python interpretor read csv file and extract first element (species)
2. copy specific column "bodymass" from testcsv.csv file to a new csv file (bodymass.csv)"""

__appname__="basic_csv.py"
__author__="ph-u"
__version__="0.0.1"
__license__="None"

import csv

# Read a file containing:
# 'Species','Infraorder','Family','Distribution','Body mass male (kg)'
f=open('../Data/testcsv.csv','r')

csvread=csv.reader(f)
temp=[]
for row in csvread:
	temp.append(tuple(row))
	print(row)
	print("The species is", row[0])

f.close()

# write a file containing only species name and Body mass
f=open('../Data/testcsv.csv','r')
g=open('../Data/bodymass.csv','w')

csvread=csv.reader(f)
csvwrite=csv.writer(g)
for row in csvread:
	print(row)
	csvwrite.writerow([row[0], row[4]])

f.close()
g.close()
