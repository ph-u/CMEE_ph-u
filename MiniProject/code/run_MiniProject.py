#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: run_MiniProject.py
# Desc: complete the miniproject from scratch
# Input: python3 run_MiniProject.py
# Output: none -- see child scripts
# Arguments: 0
# Date: Dec 2019

"""
complete the miniproject from scripts
"""

__appname__="run_MiniProject.py"
__author__="PMH"
__version__="0.0.1"
__license__="None"

## imports
import subprocess

## workflow
subprocess.Popen("Rscript Log_0.R 2> nohup.out", shell=True).wait() ## Raw data handling
#subprocess.Popen("./Log_1.sh 2> nohup.out", shell=True).wait() ## main data analysis & model-fitting
subprocess.Popen("./Log_c.sh 2> nohup.out", shell=True).wait() ## report writing and compile
subprocess.Popen("./hk_readme.sh 2> nohup.out", shell=True).wait() ## README production
subprocess.Popen("rm nohup*", shell=True).wait() ## 
#subprocess.Popen(" 2> nohup.out", shell=True).wait() ## 
