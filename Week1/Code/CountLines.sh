#!/bin/bash

# Author: ph-u
# Script: CountLines.sh
# Desc: count number of lines within input file
# Input: ./CountLines.sh <infile>
# Output: terminal output on number of lines in `infile`
# Arguments: 1
# Date: Oct 2019

if [ -z $1 ];then
    echo -e "No input"
    exit
fi
NumLines=`wc -l < $1`
echo "The file $1 has $NumLines lines"
echo
