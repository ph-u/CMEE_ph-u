#!/bin/env R

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: pokho_HPC_2019_18.R
# Desc: HPC homework Q18
# Input: Rscript pokho_HPC_2019_18.R
# Output: none
# Arguments: 0
# Date: Nov 2019

# CMEE 2019 HPC excercises R code HPC run code proforma

{## prep
  rm(list=ls()) # good practice 
  graphics.off()
  source("pokho_HPC_2019_main.R")
}
## variables
iter<-1
# iter<-as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))

set.seed(iter)
