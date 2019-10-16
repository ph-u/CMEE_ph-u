#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: tuple.py
# Desc: python homework
# Input: python3 tuple.py
# Output: python interpreter output five blocks with three-lined each
# Arguments: 0
# Date: Oct 2019

"""
python homework
"""

__appname__="tuple.py"
__author__="PMH"
__version__="0.0.1"
__license__="None"

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

# Birds is a tuple of tuples of length three: latin name, common name, mass.
# write a (short) script to print these on a separate line or output block by species 
# Hints: use the "print" command! You can use list comprehensions!

for i in range(len(birds)):
    for j in range(len(birds[i][:])):
        if j > 1: k="Mass: "
        elif j<1: k="Latin name: "
        else: k="Common name: "
        print(k,str(birds[i][j]))
    print("")