#!/bin/bash

# Author: PokMan HO (pok.ho19@imperial.ac.uk)
# Script: lego_readme.sh
# Desc: automate README.mh formulation through template provided in the same directory
# Arguments: 0
# Input: FirstName LastName year MSc/MRes
# Date: Oct 2019

## Check input
if [ -z "$1" ];then ## if this script was run with no other input, show the following help message
	echo
	echo "This is a help message to get your README.md done."
	echo "Check whether scripts have excution permissions.  If unsure, give them by:"
	echo "chmod u+x *.sh"
	echo "within this program's directory"
	echo "Sampe input: ./lego_readme.sh <FirstName> <LastName> <year> <MSc/MRes>"
	echo
	echo "Scripted by: PokMan HO in 2019"
	echo
	exit
fi

## Set basic directory stuff
cd `dirname $0`;cd ../ ## fix working directory to main Coursework dir
dir=`pwd` ## fix base dir for all weekly README.md

## README writing
for i in `ls|grep "Week*"`;do ## Identify Weeks of consideration
	a=`ls ${i}/Code/*|wc -l` ## count num of scripts in designated Week directory Code subdirectory
	if [ ${a} -gt 0 ];then
		./ReadmeProg/write_readme.sh $1 $2 $3 $4 ${dir} ${i}
		# nohup ./write_readme.sh $1 $2 $3 $4 ${dir} ${i} & ## call README writer script, run in background
	fi
	if [ ${a} -eq 0 ];then ## if subdirectory Code/ have no script
		echo "${i} contains no scripts in Code/ subdirectory."
		echo
	fi	
done

rm nohup*

echo "Note1: This script can only distinguish and write for standard script files, e.g. .sh .py .tex .r"
echo "Note2: scripts not under these categories (e.g. .txt in Week 1) is still requiring manual input"
echo "Thank you"
