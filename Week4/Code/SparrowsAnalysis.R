#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: SparrowsAnalysis.R
# Desc: statistical analysis of sparrow tarsus data
# Input: Rscript SparrowsAnalysis.R
# Output: R terminal output
# Arguments: 0
# Date: Oct 2019

oo<-read.table("../Data/SparrowTarsus.txt", sep="\t", header = T)
for(i in 1:dim(oo)[2]){
  if(class(oo[,i])=="numeric"){
    print(colnames(oo)[i])
    if(shapiro.test(oo[,i])$p.value > .05){
      print(shapiro.test(oo[,i]))
    }
  }
};rm(i)
