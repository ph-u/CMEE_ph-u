#!/bin/env python3

# Author: ph-u
# Script: cfexercises1.py
# Desc: six importable and self-testable functions with logic bug at foo_3
# Input: python3 cfexercises1.py
# Output: python interpreter output -- each module a line
# Arguments: 0
# Date: Oct 2019

"""six importable and self-testable functions with logic bug at foo_3"""

__appname__="cfexercises1.py"
__author__="ph-u"
__version__="0.0.1"
__license__="None"

import sys
import doctest

# What does each of foo_x do?
def foo_1(x):
	""" test
	>>> foo_1(4)
	2.0
	"""
	return x ** .5

def foo_2(x, y):
	""" test
	>>> foo_2(5,4)
	5
	>>> foo_2(4,10)
	10
	"""
	if x > y:
		return x
	return y

## foo_3 breaks when z is the smallest number in the array
def foo_3(x, y, z):
	""" test
	>>> foo_3(1,2,3)
	[1, 2, 3]
	>>> foo_3(2,1,3)
	[1, 2, 3]
	>>> foo_3(3,1,2)
	[1, 2, 3]
	>>> foo_3(3,2,1)
	[1, 2, 3]
	"""
	if x > y:
		tmp=y
		y=x
		x=tmp
	if y > z:
		tmp=z
		z=y
		y=tmp
	return [x, y, z]

def foo_4(x):
	""" test
	>>> foo_4(1)
	1
	>>> foo_4(5)
	120
	"""
	result=1
	for i in range(1, x+1):
		result=result * i
	return result

def foo_5(x): ## a recursive function that calculates the factorial of x
	""" test
	foo_5(1)
	1
	foo_5(5)
	120
	"""
	if x == 1:
		return 1
	return x * foo_5(x-1)

def foo_6(x): ## calculate the factorial of x in a different way
	""" test
	foo_6(1)
	1
	foo_6(5)
	120
	"""
	facto=1
	while x>=1:
		facto=facto*x
		x=x-1
	return facto

def main(argv):
	print(foo_1(4))
	print(foo_2(5,4))
	print(foo_3(2,1,3))
	print(foo_4(5))
	print(foo_5(5))
	print(foo_6(5))
	return 0

if(__name__=="__main__"):
	status=main(sys.argv)
	sys.exit(status)

doctest.testmod()
