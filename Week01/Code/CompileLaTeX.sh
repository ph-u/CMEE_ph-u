#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: CompileLaTeX.sh
# Desc: make LaTeX script (with `bib` bibliography file) into pdf; `TeX` and `bib` files must have same filename
# Input: ./CompileLaTeX.sh <tex without extension>
# Output: saves the output into a .pdf file in `Data` subdirectory
# Arguments: 1
# Date: Oct 2019

pdflatex $1.tex
pdflatex $1.tex
bibtex $1
pdflatex $1.tex
pdflatex $1.tex
# evince $1.pdf &

## Cleanup
rm *~
rm *.aux
rm *.dvi
rm *.log
rm *.nav
rm *.out
rm *.snm
rm *.toc

rm *.bbl
rm *.blg

mv *.pdf ../Data/
