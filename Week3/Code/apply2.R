#!/bin/env Rscript

# Author: ph-u
# Script: apply2.R
# Desc: try out apply() built-in R function with self-designed function
# Input: Rscript apply2.R
# Output: a matrix of R interpreter terminal output
# Arguments: 0
# Date: Oct 2019

SomeOperation<-function(v){
  if(sum(v)>0){
    return(v*100)
  }
  return(v)
}

M<-matrix(rnorm(100),10,10)
print(apply(M,1,SomeOperation))
