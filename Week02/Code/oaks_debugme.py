#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: oaks_debugme.py
# Desc: python homework -- identify oaks from list of species names with typo flexibilities
# Input: python3 oaks_debugme.py
# Output: python interpreter output from id genus "Quercus" with typo flexibilities
# Arguments: 0
# Date: Oct 2019

"""
python homework -- identify oaks from list of species names with typo flexibilities
"""

__appname__="oaks_debugme.py"
__author__="PMH"
__version__="0.0.1"
__license__="None"

import csv
import sys
import ipdb
import doctest

#Define function
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus' or with one mistake
    >>> is_an_oak('Fagus sylvatica')
    False
    >>> is_an_oak("Quercus robur")
    True
    >>> is_an_oak("Quercuss robur")
    True
    >>> is_an_oak("Quaercus robur")
    True
    >>> is_an_oak("Qurcus robur")
    True
    >>> is_an_oak("alaufsadfrasdfuafdefddasfrasdfufdascdfasdq")
    False
    >>> is_an_oak("qalauf")
    False
    >>> is_an_oak("qreusci albati")
    False
    """
    if all( [len(set(list(name)) & set(list("quercus"))) >=4,
    name.lower().startswith('qu'),
    len(name.split( )[0]) <=9] ): return True
    return False #name.lower().startswith('quercus')

    # Find first word using split
    # if word in set:
    #   ... do things

def main(argv): 
    f = open('../data/TestOaksData.csv','r')
    g = open('../data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    # oaks = set() ## useless thing
    for row in taxa:
#        ipdb.set_trace()
        if row[0] != 'Genus':
            # print(row)
            print ("The genus is: " + row[0]) 
            # print(row[0] + '\n')
            if is_an_oak(row[0]):
                print('FOUND AN OAK!\n')
                csvwrite.writerow([row[0], row[1]])    
    csvwrite.writerow([row[0], row[1]])
    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)
