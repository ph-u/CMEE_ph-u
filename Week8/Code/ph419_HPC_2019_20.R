#!/bin/env R

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: ph419_HPC_2019_20.R
# Desc: HPC homework Q20
# Input: Rscript ph419_HPC_2019_20.R
# Output: none
# Arguments: 0
# Date: Nov 2019

{## prep
  rm(list=ls()) # good practice 
  graphics.off()
  source("ph419_HPC_2019_main.R")
}

## construct ref df
r.0<-data.frame(seq(1,100),c(5e2,1e3,2.5e3,5e3)) ## ref df

for(i in 1:dim(r.0)[1]){
  try(load(paste0("../results/q18_",i,".rda")), silent = T)
};rm(i)
