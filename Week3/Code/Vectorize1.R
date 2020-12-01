#!/bin/env Rscript

# Author: ph-u
# Script: Vectorize1.R
# Desc: compare self-written and built-in function computational time
# Input: Rscript Vectorize1.R
# Output: two blocks of two-lined terminal output
# Arguments: 0
# Date: Oct 2019

M<-matrix(runif(1e6),1e3,1e3)

SumAllElements<-function(M){
  Dimensions<-dim(M)
  Tot<-0
  for(i in 1:Dimensions[1]){
    for(j in 1:Dimensions[2]){
      Tot<-Tot+M[i,j]
    }
  }
  return(Tot)
}

cat("Using loops, the time taken is:\n")
cat(paste0(round(unname(system.time(SumAllElements(M))[1]),3),"\n"))

cat("Using the built vectorized function, the time taken is:\n")
cat(paste0(round(unname(system.time(sum(M))[1]),3),"\n"))
