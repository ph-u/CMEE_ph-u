#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Mini_write.sh
# Desc: Master script file reproducing the MiniProject
# Input: ./Mini_write.sh <tex> <start_line_num>
# Output: write up a `tex` document for compiling
# Arguments: 0
# Date: Oct 2019

a1=$1
a2=$2
a3=`echo ${a1}|cut -f 1 -d "_"`

## Writing
cp $1 ${a3}_r.tex
