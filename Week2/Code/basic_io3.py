#!/bin/env python3

# Author: ph-u
# Script: basic_io3.py
# Desc: third of three basic_io.py sections -- save a python dictionary into binary file, then read and print in python interpreter
# Input: python3 basic_io3.py
# Output: save a binary file (`testp.p`) in `Sandbox` subdirectory & python interpreter output
# Arguments: 0
# Date: Oct 2019

"""third of three basic_io.py sections -- save a python dictionary into binary file, then read and print in python interpreter"""

__appname__="basic_io3.py"
__author__="ph-u"
__version__="0.0.1"
__license__="None"

##################################
# STORING OBJECTS
##################################
# To save an object (even complex) for later use
my_dictionary={"a key": 10, "another key": 11}

import pickle

f=open('../Sandbox/testp.p','wb') ## note the b: accept binary files
pickle.dump(my_dictionary, f)
f.close()

## Load the data again
f=open('../Sandbox/testp.p','rb')
another_dictionary=pickle.load(f)
f.close()

print(another_dictionary)
