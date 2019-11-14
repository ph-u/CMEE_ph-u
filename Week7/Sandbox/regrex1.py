#!/bin/python3

"""some RegExercises"""
import re
import sys

i=sys.argv[1]

try:
	print(re.search(r'[1 2]\d+[0 1]\d[0 1 2 3]\d', str(i)).group())
except: print("not valid")
