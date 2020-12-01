#!/bin/env python3

# Author: ph-u
# Script: lc1.py
# Desc: python homework
# Input: python3 lc1.py
# Output: 3 sets of duplicated python interpreter output
# Arguments: 0
# Date: Oct 2019

"""python homework"""

__appname__="lc1.py"
__author__="ph-u"
__version__="0.0.1"
__license__="None"

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different lists containing the latin names, common names and mean body masses form each species in birds, respectively. 

# (2) Now do the same using conventional loops (you can choose to do this before 1 !). 


## latin name list
L=[] ## Q2
for i in range(len(birds)):
    L.append(str(birds[i][0]))
print(L)
L=[str(birds[i][0]) for i in range(len(birds))];print(L) ## Q1

## common name list
C=[] ## Q2
for i in range(len(birds)):
    C.append(str(birds[i][1]))
print(C)
C=[str(birds[i][1]) for i in range(len(birds))];print(C) ## Q1

## body mass list
B=[] ## Q3
for i in range(len(birds)):
    B.append(str(birds[i][2]))
print(B)
B=[str(birds[i][2]) for i in range(len(birds))];print(B) ## Q1
