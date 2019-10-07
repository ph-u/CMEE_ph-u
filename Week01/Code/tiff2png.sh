#!/bin/bash

for f in `ls ../Data/*.tif*`;do
	echo "Converting $f"
	convert "$f" "../Data/$(basename $f|cut -f 1 -d ".").png"
# 	convert "$f" "$(basename "$f" .tif).png"
done
