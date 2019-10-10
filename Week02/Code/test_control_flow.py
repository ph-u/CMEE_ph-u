#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: test_control_flow.py
# Desc: five importable functions
# Input: python3 test_control_flow.py
# Output: 109-lined python interpretor output
# Arguments: 0
# Date: Oct 2019

"""Some functions exemplifying the use of control statements"""
## docstrings are considered part of the running code (normal comments are stripped).  Hence, you can access your docstrings at runtime.
__author__="Samraat Pawar (s.pawar@imperial.ac.uk)"
__version__="0.0.1"

import sys
import doctest # Import the doctest module

def even_or_odd(x=0): ## if not specified, x should take value 0
	"""Find whether a number x is even or odd
	>>> even_or_odd(10)
	'10 is Even!'

	>>> even_or_odd(5)
	'5 is Odd!'

	whenever a float is provided, then the closest integer

	>>> even_or_odd(3.2)
	'3 is Odd!'

	in case of negative numbers, the positive is taken:
	>>> even_or_odd(-2)
	'-2 is Even!'
	"""
	if x%2==0: ## the conditional if
		return "%d is Even!" %x
	return "%d is Odd!" %x

# def main(argv):
#     	print(even_or_odd(22))
# 	print(even_or_odd(33))
# 	return 0

# if(__name__=="__main__"):
# 	status=main(sys.argv)
# 	sys.exit(status)
# doctest.testmod() ## To run with embedded tests