#!/bin/env python3

# Author: ph-u
# Script: cfexercises2.py
# Desc: loop testing with different "hello" versions
# Input: python3 cfexercises2.py
# Output: python interpreter output 22-lined hello with minor variations
# Arguments: 0
# Date: Oct 2019

"""loop testing with different "hello" versions"""

__appname__="cfexercises2.py"
__author__="ph-u"
__version__="0.0.1"
__license__="None"

for j in range(12):
	if j % 3 == 0:
		print(j,'j0_hello')

for j in range(15):
	if j % 5 == 3:
		print(j,'j1_hello')
	elif j % 4 == 3:
		print(j,'j2_hello')

z=0
while z != 15:
	print(z,'z1_hello')
	z=z+3

z=12
while z<100:
	if z==31:
		for k in range(7):
			print(k,'zk_hello')
	elif z==18:
		print(z,'z2_hello')
	z=z+1
