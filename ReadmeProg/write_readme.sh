#!/bin/bash

# Author: PokMan HO (pok.ho19@imperial.ac.uk)
# Script: write_readme.sh
# Desc: Write README.md in each Week's directory
# Arguments: 0
# Input: FirstName LastName year MSc/MRes base_dir Week_Num
# Date: Oct 2019

## README.md formatting & heading
echo "Start writing $5/$6/README.md"
touch $5/$6/README.md
head -n 2 $5/ReadmeProg/tmp_readme.md > $5/$6/README.md
echo -e "# $3 $1 $2 $4 CMEE Coursework $6" >> $5/$6/README.md
echo >> $5/$6/README.md

## Grammar for week's description
list=`ls $6/Code/*|cut -f 2 -d "."|sort|uniq|grep -v "bib\|txt"|wc -l`
if [ ${list} -eq 1 ];then
	gram=`echo "focus was"`
else
	gram=`echo "foci were"`
fi

## Week's description
lsout=`ls $6/Code/*|cut -f 2 -d "."|sort|uniq|grep -v "bib\|txt"|tr -s "\n" " "`
echo "This week's ${gram} on: ${lsout}" >> $5/$6/README.md
head -n 14 $5/ReadmeProg/tmp_readme.md|tail -n 9 >> $5/$6/README.md

## Scripts description
cd $5/$6/Code/
for i in `ls *|grep -v "bib\|txt"`;do
	## Script title & Function
	echo "" >> ../README.md
	echo "### ${i}" >> ../README.md
	echo "" >> ../README.md
	echo "#### Features" >> ../README.md
	echo "" >> ../README.md
	grep "Desc" ${i}|cut -f 2 -d ":"|sed -e "s/ //1"|sed -e "s/; /  \n/g" >> ../README.md

	## Script Sample Input
	echo "" >> ../README.md
	echo "#### Input" >> ../README.md
	echo "" >> ../README.md
	head -n 24 $5/ReadmeProg/tmp_readme.md|tail -n 1 >> ../README.md
	grep "Input" ${i}|cut -f 2 -d ":"|sed -e "s/ //1"|sed -e "s/; /  \n/g" >> ../README.md
	head -n 26 $5/ReadmeProg/tmp_readme.md|tail -n 1 >> ../README.md

	## Script Sample Output
	echo "" >> ../README.md
	echo "#### Output" >> ../README.md
	echo "" >> ../README.md
	grep "Output" ${i}|cut -f 2 -d ":"|sed -e "s/ //1"|sed -e "s/; /  \n/g" >> ../README.md

	echo "*****" >> ../README.md
done

## README ending References
tail -n 8 $5/ReadmeProg/tmp_readme.md >> ../README.md
echo "done writing $5/$6/README.md"
exit
