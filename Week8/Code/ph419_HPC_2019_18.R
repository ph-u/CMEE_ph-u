#!/bin/env R

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: ph419_HPC_2019_18.R
# Desc: HPC homework Q18
# Input: Rscript ph419_HPC_2019_18.R
# Output: none
# Arguments: 0
# Date: Nov 2019

# CMEE 2019 HPC excercises R code HPC run code proforma

{## prep
  rm(list=ls()) # good practice 
  graphics.off()
  ## set path
  full_path<-"../"
  
  source(paste0(full_path,"code/ph419_HPC_2019_main.R"))
}

args=(commandArgs(T))
args<-as.numeric(args)
## variables
iter<-args[1]
v.1<-1 ## runtime allowed, local & test
# iter<-as.numeric(Sys.getenv("PBS_ARRAY_INDEX")) ## cluster sys argv
# v.1<-11.5 ## runtime cluster

set.seed(iter)
r.0<-data.frame(seq(1,100),c(5e2,1e3,2.5e3,5e3)) ## ref df
r.0<-r.0[which(r.0[,1]==iter),2] ## grab input pop to work on

cluster_run(speciation_rate = personal_speciation_rate,
            size = r.0,
            wall_time = v.1,
            interval_rich = 1,
            interval_oct = r.0/10,
            burn_in_generations = r.0*8,
            output_file_name = paste0("q18_",iter,".rda"),
            full_path=full_path)
