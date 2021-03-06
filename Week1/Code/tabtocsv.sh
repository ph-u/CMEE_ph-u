#!/bin/bash

# Author: ph-u
# Script: tabtocsv.sh
# Desc: substitute the tabs in the files with commas
# Input: ./tabtocsv.sh <txt>
# Output: saves the output into a .csv file in `Data` subdirectory
# Arguments: 1
# Date: Oct 2019

if [ -z $1 ];then
    echo -e "No input"
    exit
fi
echo "Creating a comma delimited version of $1"
a=`basename $1|cut -f 1 -d "."`
cat $1 | tr -s "\t" "," > ../Data/${a}.csv
echo "Done!"
exit
