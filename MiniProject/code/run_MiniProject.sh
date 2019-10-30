#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: run_MiniProject.sh
# Desc: Master script file reproducing the MiniProject
# Input: ./run_MiniProject.sh
# Output: 1. `pdf` output in main project subdirectory; 2. all result graphs in `results` subdirectory
# Arguments: 0
# Date: Oct 2019

## if no input
if [ -z "$1" ];then

a1=`echo -e "Log_Tmp.tex"`
a2=35
a3=`echo ${a1}|cut -f 1 -d "_"`

fi

echo -e "Running Analysis..."
Rscript Logistic.R

echo -e "Writing Report..."
## Write up report
## ${a1}: name of template; ${a2}: starting line
## output: <>_r.tex for compile
bash Mini_write.sh ${a1} ${a2}

echo -e "${a1} ${a2} ${a3}"

## Compile pdf
echo -e "Compiling Report..."
## write pdf
for i in `seq 1 5`;do
	if [ i!=3 ];then nohup pdflatex ${a3}_r.tex
	else nohup bibtex ${a3}_r
	fi
done

## Cleanup
for i in aux dvi log nav out snm toc bbl bcf blg run.xml synctex.gz;do
if [ `ls|grep -c ${i}` -gt 0 ];then
rm *.${i}
fi
done

if [ `ls|grep -c "blx.bib"` -gt 0 ];then
rm *blx.bib
fi

mv ${a3}_r.pdf ../results/${a3}_report.pdf

echo -e "Done"
exit
