#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: sysargv.py
# Desc: get familiarize with system arguments in python scripts
# Input: python3 sysargv.py <var_1> <var_2> <var_3> ...
# Output: three-lined python interpreter output
# Arguments: variable
# Date: Oct 2019

"""
get familiarize with system arguments in python scripts
"""

__appname__="sysargv.py"
__author__="PMH"
__version__="0.0.1"
__license__="None"

import sys
print("This is the name of the script: ",sys.argv[0])
print("Name of arguments: ",len(sys.argv))
print("The arguments are: ",str(sys.argv))
