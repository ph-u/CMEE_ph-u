#!/bin/bash

# Author: ph-u
# Script: Log_c.sh
# Desc: report compiler
# Input: ```./Log_c.sh```
# Output: report output in main project subdirectory
# Arguments: 0
# Date: Oct 2019

## if no input
a1=`echo -e "Log_w.tex"`
a2=`grep -n "approx word count" Log_w.tex |cut -f 1 -d ":"`
a3=`echo ${a1}|cut -f 1 -d "_"`

## write report tex file
./Log_w.sh ${a1} ${a2}

## report compile
echo -e "Compiling Report..."
for i in `seq 1 4`;do
	echo -e "pdflatex: ${i}"
	nohup pdflatex ${a3}_r.tex
	if [ ${i} -eq 3 ];then
		echo -e "running bibtex"
		nohup bibtex ${a3}_r
	fi
done

rm ${a3}_r.tex

## Cleanup
echo -e "cleaning rubbish"
for i in aux dvi log nav out snm toc bbl bcf blg run.xml synctex.gz;do
if [ `ls|grep -c ${i}` -gt 0 ];then
rm *.${i}
fi
done

if [ `ls|grep -c "blx.bib"` -gt 0 ];then
rm *blx.bib
fi

mv ${a3}_r.pdf ../results/${a3}_report.pdf

echo -e "Report Done"
exit
