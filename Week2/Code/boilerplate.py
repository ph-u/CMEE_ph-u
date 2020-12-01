#!/bin/env python3

# Author: ph-u
# Script: boilerplate.py
# Desc: minimal python script sample
# Input: python3 boilerplate.py
# Output: two-lined python interpreter output
# Arguments: 0
# Date: Oct 2019

"""Description of this program or application.
You can use several lines"""

__appname__='[application name here]'
__author__='Your Name (your@email.address)'
__version__='0.0.1'
__license__='License for this code / program'

## imports ##
import sys ## module to interface our program with the operating system

## constants ##

## functions ##
def main(argv):
	"""Main entry point of the program"""
	print("This is a boilerplate") ## NOTE: indented using two tabs or 4 species
	return 0

if __name__ == "__main__":
	"""Makes sure the 'main' function is called from command Line"""
	status=main(sys.argv)
	sys.exit("I'm exiting right now")
	# sys.exit(status)
