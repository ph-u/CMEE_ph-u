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

plot.new()
p=c(0,0,pi/2,.5)
repeat{
  for(i in c(.38,.87)){
    t=c(p[1]+cos(p[3])*p[4],p[2]+sin(p[3])*p[4],p[3]*.1,p[4]*.85)
    lines(x=c(p[1],t[1]), y=c(p[2],t[2]), add=T)
    p=t
  }
  if(t[4]<1e-1){break}
}
