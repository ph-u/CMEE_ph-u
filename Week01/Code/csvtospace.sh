#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: csvtospace.sh
# Desc: substitute the commas in the file with space
# Input: ./csvtospace.sh <csv>
# Output: saves the output into a .txt file in `Data` subdirectory
# Arguments: 1
# Date: Oct 2019

for i in `ls ../Data/*.csv`;do
	a=`basename ${i} | cut -f 1 -d "."`
	sed -e "s/,/ /g" ${i} > ../Data/${a}.txt
done

exit
