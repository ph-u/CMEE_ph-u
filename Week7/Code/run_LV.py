#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: run_LV.py
# Desc: profiling and export outputs
# Input: python3 run_LV.py
# Output: terminal outputs
# Arguments: 0
# Date: Nov 2019


"""profiling and export outputs"""

__appname__="run_LV.py"
__author__="PMH"
__version__="0.0.1"
__license__="None"

## profiling using bash <https://stackoverflow.com/questions/582336/how-can-you-profile-a-python-script>
## profiling using python3 <https://stackoverflow.com/questions/582336/how-can-you-profile-a-python-script>
import cProfile
import os, glob ## clear directory <https://stackoverflow.com/questions/185936/how-to-delete-the-contents-of-a-folder-in-python>

files=glob.glob("../results/*")
for f in files:
    os.remove(f)

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

import LV3
cProfile.run('LV3.LV()', sort="tottime")

import LV4
cProfile.run('LV4.LV()', sort="tottime")
