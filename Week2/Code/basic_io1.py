#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: basic_io1.py
# Desc: first of three basic_io.py sections -- output lines from `txt` file
# Input: python3 basic_io1.py
# Output: 22-lined python interpreter output
# Arguments: 0
# Date: Oct 2019

"""
first of three basic_io.py sections -- output lines from txt file
"""

__appname__="basic_io1.py"
__author__="PMH"
__version__="0.0.1"
__license__="None"

#################################
# FILE INPUT
#################################
# Open a file for reading
f=open('../Sandbox/test.txt','r')
# use "implicit" for loop:
# if the object is a file, python will cycle over lines
for line in f:
	print(line)

# close the file
f.close()

# Same example, skip blank lines
f=open('../Sandbox/test.txt','r')
for line in f:
	if len(line.strip())>0:
		print(line)

f.close()