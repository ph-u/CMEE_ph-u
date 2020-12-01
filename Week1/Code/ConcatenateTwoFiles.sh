#!/bin/bash

# Author: ph-u
# Script: ConcatenateTwoFiles.sh
# Desc: end-to-head merge two files in sequence
# Input: ./ConcatenateTwoFiles.sh <infile_1> <infile_2> <outfile>
# Output: 1. saves the output into an `outfile` in designated subdirectory; 2. terminal output of `outfile` content
# Arguments: 1
# Date: Oct 2019

if [ -z $1 ];then
    echo -e "No input"
    exit
elif [ -z $2 ];then
    echo -e "Not enough input"
    exit
elif [ -z $3 ];then
    echo -e "No designated output"
    exit
fi

cat $1 > $3
cat $2 >> $3
echo -e "Merged File is $3"
cat $3
