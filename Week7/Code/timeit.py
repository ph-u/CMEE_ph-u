#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: timeit.py
# Desc: timing trials
# Input: python3 timeit.py
# Output: terminal output on timing within python shells
# Arguments: 0
# Date: Nov 2019


"""timing trials"""
## loops vs list comprehensions
iters=int(1e6)

import timeit
from profileme import my_squares as my_squares_loops
from profileme2 import my_squares as my_squares_lc

# %timeit my_squares_loops(iters)
# %timeit my_squares_lc(iters)

## loops vs join method for strings
mystring = "mystring"

from profileme import my_join as my_join_join
from profileme2 import my_join as my_join

# %timeit my_join_join(iters, mystring)
# %timeit my_join(iters, mystring)

import time
start=time.time()
my_squares_loops(iters)
print("my_squares_loops tskrd %f s to run." %(time.time()-start))
print("my_squares_lc takes %f to run" %(time.time()-start))