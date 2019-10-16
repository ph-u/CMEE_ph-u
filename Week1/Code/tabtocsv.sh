#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: tabtocsv.sh
# Desc: substitute the tabs in the files with commas
# Input: ./tabtocsv.sh <txt>
# Output: saves the output into a .csv file in `Data` subdirectory
# Arguments: 1
# Date: Oct 2019

echo "Creating a comma delimited version of $1"
a=`basename $1|cut -f 1 -d "."`
cat $1 | tr -s "\t" "," > ../Data/${a}.csv
echo "Done!"
exit
