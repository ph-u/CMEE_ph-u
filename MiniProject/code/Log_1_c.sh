#!/bin/bash

# Author: ph-u
# Script: Log_1_c.sh
# Desc: commander script for Log_1_s*.R slaves; get starting values (s1) + model fitting (s2)
# Input: bash Log_1_c.sh <Dataset Num> <Iterations>
# Output: none
# Arguments: 2
# Date: Nov 2019

if [ -z $1 ];then
    echo -e "No input"
    exit
fi

Rscript Log_1_s1.R $1
Rscript Log_1_s2.R $1 $2
exit
