#!/bin/env python3

# Author: ph-u
# Script: using_name.py
# Desc: minimal python importable script sample
# Input: python3 using_name.py
# Output: one-lined python interpreter output
# Arguments: 0
# Date: Oct 2019

"""
minimal python importable script sample
"""

__appname__="using_name.py"
__author__="ph-u"
__version__="0.0.1"
__license__="None"

## Filename: using_name.py

if __name__=="__main__":
	print("This program is being run by itself")
else:
	print("I am being imported from another module")
