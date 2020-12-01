#!/bin/env Rscript

# Author: ph-u
# Script: break.R
# Desc: test in-script breakpoint in `while` loop
# Input: Rscript break.R
# Output: 20-lined terminal output
# Arguments: 0
# Date: Oct 2019

i<-0## initialize i
while(i<Inf){
  if(i==20){
    break
  }## Break out of the while loop!
  else{
    cat("i equals",i,"\n")
    i<-i+1 ## update i
  }
}
