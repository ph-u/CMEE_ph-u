#!/bin/env python3

# Author: ph-u
# Script: TestR.py
# Desc: test call on TestR.R
# Input: python3 TestR.py
# Output: none
# Arguments: 0
# Date: Nov 2019


"""test call on TestR.R"""

__appname__="TestR.py"
__author__="ph-u"
__version__="0.0.1"
__license__="None"

import subprocess
subprocess.Popen("Rscript --verbose TestR.R > ../results/TestR.Rout 2> ../results/TestR_errFile.Rout", shell=True).wait()

