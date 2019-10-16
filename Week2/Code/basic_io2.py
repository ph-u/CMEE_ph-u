#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: basic_io2.py
# Desc: second of three basic_io.py sections -- print a list of numbers into `txt` file
# Input: python3 basic_io2.py
# Output: saves the output into a `txt` file (`testout.txt`) in `Sandbox` subdirectory
# Arguments: 0
# Date: Oct 2019

"""
second of three basic_io.py sections -- print a list of numbers into txt file
"""

__appname__="basic_io2.py"
__author__="PMH"
__version__="0.0.1"
__license__="None"

##################################
# FILE OUTPUT
##################################
# Save the elements of a list to a file
list_to_save=range(100)

f=open('../Sandbox/testout.txt','w')
print("writing starts now")
for i in list_to_save:
	f.write(str(i) + '\n') ## Add a new line at the end
print("job done")
f.close()