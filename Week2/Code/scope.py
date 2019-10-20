#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: scope.py
# Desc: 5 blocks testing usage of global and local variable namespaces
# Input: python3 scope.py
# Output: five blocks of python interpreter output
# Arguments: 0
# Date: Oct 2019

"""5 blocks testing usage of global and local variable namespaces"""

__appname__="scope.py"
__author__="PMH"
__version__="0.0.1"
__license__="None"

## 1st
_a_global = 10 # a global variable

if _a_global >= 5:
	_b_global = _a_global+5 # also a global variable

def a_function():
    """test trial 1"""
	_a_global = 5 # a local variable

	if _a_global >=5:
		_b_global = _a_global + 5 # also a local variable

	_a_local = 4

	print("Inside the function, the value of _a_global is ",_a_global)
	print("Inside the function, the value of _b_global is ",_b_global)
	print("Inside the function, the value of _a_local is ",_a_local)

	return None

print("1st block")
a_function()
print("Outside the function, the value of _a_global is ",_a_global)
print("Outside the function, the value of _b_global is ",_b_global)


## 2nd
_a_global = 10

def a_function():
    """test trial 2"""
	_a_local=4

	print("Inside the function, the value _a_local is ",_a_local)
	print("Inside the function, the value of _a_global is ",_a_global)
	return None

print("2nd block")
a_function()
print("Outside the function, the value of _a_global is ",_a_global)


## 3rd
_a_global = 10
print("3rd block")
print("Outside the function, the value of _a_global is ",_a_global)

def a_function():
    """test trial 3"""
	global _a_global
	_a_global = 5
	_a_local = 4

	print("Inside the function, the value of _a_global is ",_a_global)
	print("Inside the function, the value _a_local is ",_a_local)

	return None

a_function()
print("Outside the function, the value of _a_global now is ",_a_global)


## 4th
print("4th block")
def a_function():
    """test trial 4"""
	_a_global = 10
	def _a_function2():
    	"""test trial 4.1"""
		global _a_global
		_a_global = 20
	print("Before calling a_function, value of _a_global is ",_a_global)

	_a_function2()
	print("After calling _a_function2, value of _a_global is ",_a_global)

a_function()
print("The value of a_global in main workspace / namespace is ",_a_global)

## 5th
_a_global=10
print("5th block")
def a_function():
    """test trial 5"""
	def _a_function2():
    	"""test trial 5.1"""
		global _a_global
		_a_global=20
	print("Before calling a_function, value of _a_global is ",_a_global)
	_a_function2()
	print("After calling _a_function2, value of _a_global is ",_a_global)
a_function()
print("The value of a_global in main workspace / namespace is ",_a_global)
