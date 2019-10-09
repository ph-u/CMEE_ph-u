#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: cfexercises1.py
# Desc: five importable and self-testable functions
# Input: python3 cfexercises1.py
# Output: 1. no output if import to python; 2. python interpretor output of self-test result
# Arguments: 0
# Date: Oct 2019

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

doctest.testmod()