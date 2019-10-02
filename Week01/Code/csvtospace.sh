#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: csvtospace.sh
# Desc: substitute the commas in the file with space
# saves the output into a .txt file
# Arguments: 0
# Date: Oct 2019

for i in `ls ../Data/*.csv`;do
	a=`basename ${i} | cut -f 1 -d "."`
	sed -e "s/,/ /g" ${i} > ${a}.txt
done

exit
