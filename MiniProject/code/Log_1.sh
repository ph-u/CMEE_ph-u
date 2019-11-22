#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Log_1.sh
# Desc: commander script for Log_1_s*.R slaves
# Input: bash Log_1.sh <Dataset Num> <Iterations>
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
