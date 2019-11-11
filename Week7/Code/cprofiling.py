#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: cprofiling.py
# Desc: profiling and export outputs
# Input: python3 cprofiling.py
# Output: terminal outputs
# Arguments: 0
# Date: Nov 2019


"""profiling and export outputs"""

__appname__="cprofiling.py"
__author__="PMH"
__version__="0.0.1"
__license__="None"

## profiling using bash <https://stackoverflow.com/questions/582336/how-can-you-profile-a-python-script>
## profiling using python3 <>
import cProfile

## self-recognition <https://stackoverflow.com/questions/50499/how-do-i-get-the-path-and-name-of-the-file-that-is-currently-executing>
# import inspect, os
# # a=inspect.getfile(inspect.currentframe()) # script filename (usually with path)
# a=os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe()))) # script directory
# os.chdir(a)

## profiling
import LV1
cProfile.run('LV1.LV()', sort="tottime")

import LV2
cProfile.run('LV2.LV()', sort="tottime")
