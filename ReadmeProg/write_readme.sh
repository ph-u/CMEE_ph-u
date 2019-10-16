#!/bin/bash

# Author: PokMan HO (pok.ho19@imperial.ac.uk)
# Script: write_readme.sh
# Desc: Write README.md in each Week's directory
# Arguments: 0
# Input: FirstName LastName year MSc/MRes base_dir Week_Num
# Date: Oct 2019

## check if readme_final.md exist, replace readme.md scripting if finalized
if [ `ls $5/$6/readme_final.md|wc -l` -gt 0 ];then
	cp $5/$6/readme_final.md $5/$6/readme.md
	echo "copied finalized version to true readme.md in $6"
	exit
fi

## README.md formatting & heading
echo "Start writing $5/$6/readme.md"
touch $5/$6/readme.md
head -n 2 $5/ReadmeProg/tmp_readme.md > $5/$6/readme.md
echo -e "# $3 $1 $2 $4 CMEE Coursework $6" >> $5/$6/readme.md
echo >> $5/$6/readme.md

## Grammar for week's description
list=`ls $6/Code/*|cut -f 2 -d "."|sort|uniq|grep -v "bib\|txt\|pyc\|cpy*\|^$\|log\|pdf\|synctex\|ance.tex"|wc -l`
if [ ${list} -eq 1 ];then
	gram=`echo "focus was"`
else
	gram=`echo "foci were"`
fi

## Week's description
lsout=`ls $6/Code/*|cut -f 2 -d "."|sort|uniq|grep -v "bib\|txt\|pyc\|cpy*\|^$\|log\|pdf\|synctex\|ance.tex"|tr -s "\n" " "`
echo "This week's ${gram} on: ${lsout}" >> $5/$6/readme.md
head -n 14 $5/ReadmeProg/tmp_readme.md|tail -n 9 >> $5/$6/readme.md

## Scripts description
cd $5/$6/Code/
for i in `ls *|grep -v "bib\|txt\|pyc\|cpy*\|^$\|log\|pdf\|synctex\|ance.tex"`;do
	## Script title & Function
	echo "" >> ../readme.md
	echo "### ${i}" >> ../readme.md
	echo "" >> ../readme.md
	echo "#### Features" >> ../readme.md
	echo "" >> ../readme.md
	grep "Desc:" ${i}|cut -f 2 -d ":"|sed -e "s/ //1" >> ../readme.md

	## Script Sample Input
	echo "" >> ../readme.md
	echo "#### Suggested input" >> ../readme.md
	echo "" >> ../readme.md
	head -n 24 $5/ReadmeProg/tmp_readme.md|tail -n 1 >> ../readme.md
	grep "Input" ${i}|cut -f 2 -d ":"|sed -e "s/ //1" >> ../readme.md
	head -n 26 $5/ReadmeProg/tmp_readme.md|tail -n 1 >> ../readme.md

	## Script Sample Output
	echo "" >> ../readme.md
	echo "#### Output" >> ../readme.md
	echo "" >> ../readme.md
	grep "Output" ${i}|cut -f 2 -d ":"|sed -e "s/ //1" >> ../readme.md

	echo "*****" >> ../readme.md
done

## README ending References
tail -n 8 $5/ReadmeProg/tmp_readme.md >> ../readme.md
echo "done writing $5/$6/readme.md"
exit
