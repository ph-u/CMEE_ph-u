#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: dictionary.py
# Desc: python homework -- create and print dictionary line-by-line
# Input: python3 dictionary.py
# Output: print the dictionary keys and content line-by-line
# Arguments: 0
# Date: Oct 2019

"""
python homework -- create and print dictionary line-by-line
"""

__appname__="dictionary.py"
__author__="PMH"
__version__="0.0.1"
__license__="None"

taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a short python script to populate a dictionary called taxa_dic derived from taxa so that it maps order names to sets of taxa.
# E.g. 'Chiroptera' : set(['Myotis lucifugus']) etc.

Chiroptera=set(str(taxa[i][0]) for i in range(len(taxa)) if taxa[i][1] == "Chiroptera")
Rodentia=set(str(taxa[i][0]) for i in range(len(taxa)) if taxa[i][1] == "Rodentia")
Afrosoricida=set(str(taxa[i][0]) for i in range(len(taxa)) if taxa[i][1] == "Afrosoricida")
Carnivora=set(str(taxa[i][0]) for i in range(len(taxa)) if taxa[i][1] == "Carnivora")
taxa_dic={'Chiroptera': Chiroptera,'Rodentia': Rodentia,'Afrosoricida': Afrosoricida,'Carnivora': Carnivora}

print("Start dictionary printing:\n")
for i,v in taxa_dic.items():
        print("Content in",i,":",v,"\n")
print("Finish printing dictionary")