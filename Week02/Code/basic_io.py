#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: basic_io.py
# Desc: 1. python interpretor output an input `csv` file; 2. print a list of numbers into `txt` file; 3. save a python dictionary into binary file, then read and print in python interpretor
# Input: python3 basic_io.py
# Output: 1. python interpretor output; 2. saves the output into a `txt` file (`testout.txt`) in `Sandbox` subdirectory; 3. save a binary file (`testp.p`) in `Sandbox` subdirectory & python interpretor output
# Arguments: 0
# Date: Oct 2019

#################################
# FILE INPUT
#################################
# Open a file for reading
f=open('../Sandbox/test.txt','r')
# use "implicit" for loop:
# if the object is a file, python will cycle over lines
for line in f:
	print(line)

# close the file
f.close()

# Same example, skip blank lines
f=open('../Sandbox/test.txt','r')
for line in f:
	if len(line.strip())>0:
		print(line)

f.close()

##################################
# FILE OUTPUT
##################################
# Save the elements of a list to a file
list_to_save=range(100)

f=open('../Sandbox/testout.txt','w')
for i in list_to_save:
	f.write(str(i) + '\n') ## Add a new line at the end

f.close()

##################################
# STORING OBJECTS
##################################
# To save an object (even complex) for later use
my_dictionary={"a key": 10, "another key": 11}

import pickle

f=open('../Sandbox/testp.p','wb') ## note the b: accept binary files
pickle.dump(my_dictionary, f)
f.close()

## Load the data again
f=open('../Sandbox/testp.p','rb')
another_dictionary=pickle.load(f)
f.close()

print(another_dictionary)
