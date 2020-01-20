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
subprocess.Popen("./Log_1.sh 2> nohup.out", shell=True).wait() ## main data analysis & model-fitting
subprocess.Popen("Rscript Log_2.R 2> nohup.out", shell=True).wait() ## statistical analysis -- is one or more model(s) stand out from the rest?
subprocess.Popen("Rscript Log_3.R 2> nohup.out", shell=True).wait() ## statistical analysis -- do any parameters favours any phenological model(s)?
subprocess.Popen("Rscript Log_4.R 2> nohup.out", shell=True).wait() ## graphical plot -- shape of polynomial-restricted datasets
subprocess.Popen("Rscript Log_5.R 2> nohup.out", shell=True).wait() ## biological question -- is species identity relate to anything?
subprocess.Popen("./Log_n.sh 2> nohup.out", shell=True).wait() ## collect dispersed number for report
subprocess.Popen("./Log_c.sh 2> nohup.out", shell=True).wait() ## report writing and compile
subprocess.Popen("./run_readme.sh 2> nohup.out", shell=True).wait() ## README production
subprocess.Popen("rm nohup*", shell=True).wait() ## 
#subprocess.Popen(" 2> nohup.out", shell=True).wait() ## 
