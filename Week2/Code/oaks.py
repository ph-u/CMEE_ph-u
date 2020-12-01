#!/bin/env python3

# Author: ph-u
# Script: oaks.py
# Desc: test data output methods
# Input: python3 oaks.py
# Output: four-lined python interpreter output
# Arguments: 0
# Date: Oct 2019

"""test data output methods"""

__appname__="oaks.py"
__author__="ph-u"
__version__="0.0.1"
__license__="None"

## Finds just those taxa that are oak trees from a list of species

taxa=['Quercus robur',"Fraxinus excelsior","Pinus sylvestris","Quercus cerris","Quercus petraea"]

def is_an_oak(name):
    """test oak or not"""
	return name.lower().startswith('quercus ')

## Using for loops
oaks_loops = set()
for species in taxa:
	if is_an_oak(species):
		oaks_loops.add(species)
print(oaks_loops)

## Using list comprehensions
oaks_lc=set([species for species in taxa if is_an_oak(species)])
print(oaks_lc)

##Get names in UPPER CASEusing for loops
oaks_loops=set()
for species in taxa:
	if is_an_oak(species):
		oaks_loops.add(species.upper())
print(oaks_loops)

##Get names in UPPER CASE using list comprehensions
oaks_lc=set([species.upper() for species in taxa if is_an_oak(species)])
print(oaks_lc)
