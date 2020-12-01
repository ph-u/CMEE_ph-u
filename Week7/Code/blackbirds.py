#!/bin/env python3

# Author: ph-u
# Script: blackbirds.py
# Desc: homework on blackbirds
# Input: python3 blackbirds.py
# Output: terminal output
# Arguments: 0
# Date: Nov 2019


"""homework on blackbirds"""

__appname__="blackbirds.py"
__author__="ph-u"
__version__="0.0.1"
__license__="None"

import re

# Read the file (using a different, more python 3 way, just for fun!)
with open('../Data/blackbirds.txt', 'r') as f: text = f.read()

# replace \t's and \n's with a spaces:
# text = text.replace('\t',' ')
# text = text.replace('\n',' ')
# You may want to make other changes to the text.
text=re.sub(r'\s+', " ", text).strip() ## <https://stackoverflow.com/questions/2077897/substitute-multiple-whitespace-with-single-whitespace-in-python>

# In particular, note that there are "strange characters" (these are accents and
# non-ascii symbols) because we don't care for them, first transform to ASCII:

text = text.encode('ascii', 'ignore') # first encode into ascii bytes
text = text.decode('ascii', 'ignore') # Now decode back to string

# Now extend this script so that it captures the Kingdom, Phylum and Species
# name for each species and prints it out to screen neatly.
kd=re.findall(r'Kingdom [A-Za-z]+|Phylum [A-Za-z]+|Species [A-Za-z]+ [a-z]+', text)
for i in range(len(kd)): print(kd[i])
# kd=re.findall(r'(Kingdom [A-Za-z]+)|(Phylum [A-Za-z]+)|(Species [A-Za-z]+ [a-z]+)', text)
# Hint: you may want to use re.findall(my_reg, text)... Keep in mind that there are multiple ways to skin this cat! Your solution could involve multiple regular expression calls (easier!), or a single one (harder!)
