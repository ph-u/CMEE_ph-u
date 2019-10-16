#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: CountLines.sh
# Desc: count number of lines within input file
# Input: ./CountLines.sh <infile>
# Output: terminal output on number of lines in `infile`
# Arguments: 1
# Date: Oct 2019

NumLines=`wc -l < $1`
echo "The file $1 has $NumLines lines"
echo
