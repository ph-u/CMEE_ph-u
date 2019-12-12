#!/bin/env R

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: ph419_HPC_2019_challengeG.R
# Desc: Q30 code optimization / minimization
# Input: Rscript ph419_HPC_2019_challengeG.R
# Output: none
# Arguments: 0
# Date: Dec 2019

# CMEE 2019 HPC excercises R code challenge G proforma

rm(list=ls()) # nothing written elsewhere should be needed to make this work

name <- "Pok Man Ho"
preferred_name <- "PokMan"
email <- "pok.ho19@imperial.ac.uk"
username <- "ph419"

# don't worry about comments for this challenge - the number of characters used will be counted starting from here
plot.new();p=function(x=.5,y=0,d=pi/2,l=.1,r=-1){lines(c(x,a<-x+cos(d)*l),c(y,b<-y+sin(d)*l));if(l>2e-3){p(a,b,d,l*.9,-r);p(a,b,d-.8*r,l*.4,r)}};p()
