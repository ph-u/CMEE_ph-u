#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: run_fmr_R.py
# Desc: call fmr.R from python3 terminal environment
# Input: python3 run_fmr_R.py
# Output: terminal output
# Arguments: 0
# Date: Nov 2019


"""call fmr.R from python3 terminal environment"""

__appname__="run_fmr_R.py"
__author__="PMH"
__version__="0.0.1"
__license__="None"

import subprocess

subprocess.Popen("Rscript fmr.R 2> ../results/fmr_err.Rout", shell=True).wait()
