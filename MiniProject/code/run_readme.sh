#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: run_readme.sh
# Desc: README production
# Input: ```./run_readme.sh```
# Output: `README.md` for MiniProject
# Arguments: 0
# Date: Nov 2019

## start
head -n 21 ../data/readme_tmp.md > ../readme.md ## "All scripts are in..."

## General scripts
for j in 16 14 12 10;do
	tail -n ${j} ../data/readme_tmp.md | head -n 2 >> ../readme.md
	if [ ${j} -eq 16 ];then
		jj="housekeeping"
		ii="run"
	elif [ ${j} -eq 14 ];then
		jj="TPC"
		ii="TPC"
	elif [ ${j} -eq 12 ];then
		jj="Fun-Res"
		ii="Fun"
	else
		jj="Log-Growth"
		ii="Log"
	fi
	if [ `ls|grep -o "${ii}"|wc -l` -gt 0 ];then
		echo -e "writing scripts for ${jj}"
		for i in `ls ${ii}*|grep -v .swp`;do
			echo >> ../readme.md
			echo -e "### ${i}" >> ../readme.md
			echo >> ../readme.md
			echo "#### Features" >> ../readme.md
			echo >> ../readme.md
			grep "Desc:" ${i}|cut -f 2 -d ":"|sed -e "s/ //1"|head -n 1 >> ../readme.md
			echo >> ../readme.md
			echo "#### Suggested input" >> ../readme.md
			echo "" >> ../readme.md
			grep "Input" ${i}|cut -f 2 -d ":"|sed -e "s/ //1"|head -n 1 >> ../readme.md
			echo >> ../readme.md
			echo "#### Output" >> ../readme.md
			echo "" >> ../readme.md
			grep "Output" ${i}|cut -f 2 -d ":"|sed -e "s/ //1"|head -n 1 >> ../readme.md
			echo >> ../readme.md
			echo "*****" >> ../readme.md
		done
	fi
done

## end
tail -n 8 ../data/readme_tmp.md >> ../readme.md

echo -e "README Done"
exit
