#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: CompileLaTeX.sh
# Desc: 1. make LaTeX script (with `bib` bibliography file) into pdf; 2. `TeX` and `bib` files must have same filename
# Input: ./CompileLaTeX.sh <tex without extension>
# Output: saves the output into a .pdf file in `Data` subdirectory
# Arguments: 1
# Date: Oct 2019

if [ -z $1 ];then
    echo -e "No input"
    exit
fi
pdflatex $1.tex
pdflatex $1.tex
bibtex $1
pdflatex $1.tex
pdflatex $1.tex
# evince $1.pdf &

## Cleanup
for i in aux dvi log nav out snm toc bbl bcf blg run.xml synctex.gz;do
if [ `ls|grep -c ${i}` -gt 0 ];then
rm *.${i}
fi
done

if [ `ls|grep -c "blx.bib"` -gt 0 ];then
rm *blx.bib
fi

mv *.pdf ../Data/
