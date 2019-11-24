#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Log_c.sh
# Desc: report compiler
# Input: ```./Log_c.sh```
# Output: report output in main project subdirectory
# Arguments: 0
# Date: Oct 2019

## if no input
a1=`echo -e "Log_w.tex"`
a2=63
a3=`echo ${a1}|cut -f 1 -d "_"`

## write report tex file
./Log_w.sh ${a1} ${a2}

## report compile
echo -e "Compiling Report..."
for i in `seq 1 4`;do
	nohup pdflatex ${a3}_r.tex
	if [ ${i} -eq 3 ];then
		nohup bibtex ${a3}_r
	fi
done

rm ${a3}_r.tex

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
