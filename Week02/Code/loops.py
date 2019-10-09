#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: loops.py
# Desc: loops testing
# Input: python3 loops.py
# Output: 1. python print range; 2. python print stuff; 3. python print summation results; 4. pytphon print accending numbers until 99; 5. infinite printing while-loop
# Arguments: 0
# Date: Oct 2019

## FOR loops in Python
for i in range(5):
	print(i)

my_list=[0, 2, "geronimo!", 3.0, True, False]
for k in my_list:
	print(k)

total=0
summands=[0, 1, 11, 111, 1111]
for s in summands:
	total=total+s
	print(total)

## WHILE loops in Python
z=0
while z<100:
	z=z+1
	print(z)

b=True
while b:
	print("GERONIMO! infinite loop! ctrl+c to stop!")
# ctrl+c to stop
