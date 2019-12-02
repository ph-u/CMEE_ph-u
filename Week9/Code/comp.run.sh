#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: comp.run.sh
# Desc: compile and run designated C-program
# Input: ./comp.run.sh <C>
# Output: output of the C program
# Arguments: 1
# Date: Dec 2019

if [ -z $1 ];then
    echo -e "No input"
    exit
else
	a=`echo $1|cut -f 1 -d "."`
fi

if [ -z $2 ];then
	echo -e "Set .c name as program name"
	a1=${a}
else
	a1=$2
fi

clang $1

if [ $((`echo $ERROR`)) -eq 0 ];then
	clang $1 -o ${a1}
	./${a1}
else
	echo -e "return value unsuccessful"
	exit
fi

exit
