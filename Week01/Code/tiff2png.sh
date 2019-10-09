#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: tiff2png.sh
# Desc: transform a tiff to png format
# Input: ./tiff2png.sh <tiff>
# Output: saves the output into a .png file in `Data` subdirectory
# Arguments: 1
# Date: Oct 2019

for f in `ls ../Data/*.tif*`;do
	echo "Converting $f"
	convert "$f" "../Data/$(basename $f|cut -f 1 -d ".").png"
# 	convert "$f" "$(basename "$f" .tif).png"
done
