#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: oaks.py
# Desc: five data-handling minimal examples
# Input: python3 oaks.py
# Output: four-lined python interpretor output
# Arguments: 0
# Date: Oct 2019

## Finds just those taxa that are oak trees from a list of species

taxa=['Quercus robur',"Fraxinus excelsior","Pinus sylvestris","Quercus cerris","Quercus petraea"]

def is_an_oak(name):
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
