#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: run_Mini_write.sh
# Desc: Master script file reproducing the MiniProject
# Input: ```./run_Mini_write.sh <tex> <start_line_num>```
# Output: write up a `tex` document for compiling
# Arguments: 0
# Date: Oct 2019

a1=$1
a2=$2
a3=`echo ${a1}|cut -f 1 -d "_"`

## Writing
#cp $1 ${a3}_r.tex
head -n ${a2} $1 > ${a3}_r.tex
head -n 4 ../data/Log_Metadata.txt | tail -n 1 | cut -f 2 >> ${a3}_r.tex ## <https://unix.stackexchange.com/questions/35369/how-to-define-tab-delimiter-with-cut-in-bash>
a2=`echo $((${a2}+1))`
head -n ${a2} $1 | tail -n 1 >> ${a3}_r.tex
head -n 2 ../data/Log_Metadata.txt | tail -n 1 | cut -f 2 >> ${a3}_r.tex
a2=`echo $((${a2}+1))`
head -n ${a2} $1 | tail -n 1 >> ${a3}_r.tex
head -n 3 ../data/Log_Metadata.txt | tail -n 1 | cut -f 2 >> ${a3}_r.tex
a2=`echo $((${a2}+1))`
head -n ${a2} $1 | tail -n 1 >> ${a3}_r.tex
head -n 1 ../data/Log_Metadata.txt | cut -f 2 >> ${a3}_r.tex
a2=`echo $((${a2}+1))`
head -n ${a2} $1 | tail -n 1 >> ${a3}_r.tex
head -n 6 ../data/Log_Metadata.txt | tail -n 1 | cut -f 2 >> ${a3}_r.tex
a2=`echo $((${a2}+1))`
head -n ${a2} $1 | tail -n 1 >> ${a3}_r.tex
head -n 5 ../data/Log_Metadata.txt | tail -n 1 | cut -f 2 >> ${a3}_r.tex
a2=`echo $((${a2}+2))`
head -n ${a2} $1 | tail -n 2 >> ${a3}_r.tex
head -n 7 ../data/Log_Metadata.txt | tail -n 1 | cut -f 2 >> ${a3}_r.tex

a2=`echo $((${a2}+1))`
head -n ${a2} $1 | tail -n 1 >> ${a3}_r.tex
head -n 14 ../data/Log_Metadata.txt | tail -n 1 | cut -f 2 >> ${a3}_r.tex
a2=`echo $((${a2}+1))`
head -n ${a2} $1 | tail -n 1 >> ${a3}_r.tex
head -n 15 ../data/Log_Metadata.txt | tail -n 1 | cut -f 2 >> ${a3}_r.tex
a2=`echo $((${a2}+1))`
head -n ${a2} $1 | tail -n 1 >> ${a3}_r.tex
head -n 16 ../data/Log_Metadata.txt | tail -n 1 | cut -f 2 >> ${a3}_r.tex
a2=`echo $((${a2}+1))`
head -n ${a2} $1 | tail -n 1 >> ${a3}_r.tex
head -n 17 ../data/Log_Metadata.txt | tail -n 1 | cut -f 2 >> ${a3}_r.tex
a2=`echo $((${a2}+1))`
head -n ${a2} $1 | tail -n 1 >> ${a3}_r.tex
head -n 18 ../data/Log_Metadata.txt | tail -n 1 | cut -f 2 >> ${a3}_r.tex
a2=`echo $((${a2}+1))`
head -n ${a2} $1 | tail -n 1 >> ${a3}_r.tex
head -n 8 ../data/Log_Metadata.txt | tail -n 1 | cut -f 2 >> ${a3}_r.tex
a2=`echo $((${a2}+1))`
head -n ${a2} $1 | tail -n 1 >> ${a3}_r.tex
head -n 9 ../data/Log_Metadata.txt | tail -n 1 | cut -f 2 >> ${a3}_r.tex
a2=`echo $((${a2}+1))`
head -n ${a2} $1 | tail -n 1 >> ${a3}_r.tex
head -n 10 ../data/Log_Metadata.txt | tail -n 1 | cut -f 2 >> ${a3}_r.tex
a2=`echo $((${a2}+1))`
head -n ${a2} $1 | tail -n 1 >> ${a3}_r.tex
head -n 11 ../data/Log_Metadata.txt | tail -n 1 | cut -f 2 >> ${a3}_r.tex
a2=`echo $((${a2}+1))`
head -n ${a2} $1 | tail -n 1 >> ${a3}_r.tex
head -n 12 ../data/Log_Metadata.txt | tail -n 1 | cut -f 2 >> ${a3}_r.tex
a2=`echo $((${a2}+1))`
head -n ${a2} $1 | tail -n 1 >> ${a3}_r.tex
head -n 13 ../data/Log_Metadata.txt | tail -n 1 | cut -f 2 >> ${a3}_r.tex

a2=`echo $((${a2}+1))`
tail -n +${a2} $1 >> ${a3}_r.tex

## spacialize for *_r.tex
head -n 3 ${a3}_r.tex > tmp
echo -e '% Desc: Daughter script for corresponding final `LaTeX` report' >> tmp
tail -n +5 ${a3}_r.tex >> tmp

a4=51
head -n ${a4} tmp > tmp1
echo -e $((`texcount tmp |tail -n 19|head -n 1|cut -f 2 -d ":"|cut -f 2 -d " "` -3 -13 -`grep -o "autocite{" ${a3}_r.tex |wc -l`)) >> tmp1
a4=`echo $((${a4}+1))`
tail -n +${a4} ${a3}_r.tex >> tmp1

mv tmp1 tmp
mv tmp ${a3}_r.tex
