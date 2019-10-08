#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: ConcatenateTwoFiles.sh
# Desc: end-to-head merge two files in sequence
# Input: ./ConcatenateTwoFiles.sh <infile_1> <infile_2> <outfile>
# Output: saves the output into an `outfile` in designated subdirectory  terminal output of `outfile` content
# Arguments: 1
# Date: Oct 2019

cat $1 > $3
cat $2 >> $3
echo "Merged File is"
cat $3
