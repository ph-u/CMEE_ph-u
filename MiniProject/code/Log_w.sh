#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Log_w.sh
# Desc: Master script file reproducing the MiniProject
# Input: ```./Log_w.sh <tex> <start_line_num>```
# Output: write up a `tex` document for compiling
# Arguments: 0
# Date: Oct 2019

a1=$1
a2=$2
a3=`echo ${a1}|cut -f 1 -d "_"`

## Writing
cp $1 ${a3}_r.tex

## spacialize for *_r.tex
head -n 3 ${a3}_r.tex > tmp
echo -e '% Desc: Daughter script for corresponding final `LaTeX` report' >> tmp
tail -n +5 ${a3}_r.tex >> tmp

a4=`grep -n "%% insert approx word count" ${a1}|cut -f 1 -d ":"`
head -n ${a4} tmp > tmp1
echo -e $((`texcount tmp |grep "Words in text:"|cut -f 2 -d ":"|cut -f 2 -d " "` -`texcount tmp |grep "_top_"|cut -f 1 -d "+"` -`texcount tmp |grep "Code and Data Availability"|cut -f 1 -d "+"` -`grep -o "autocite{" ${a3}_r.tex |wc -l`)) >> tmp1
a4=`echo $((${a4}+1))`
tail -n +${a4} ${a3}_r.tex >> tmp1

mv tmp1 tmp
mv tmp ${a3}_r.tex
