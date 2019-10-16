#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: try.R
# Desc: test two methods of random sampling from a population
# Input: Rscript try.R
# Output: 200-lined terminal output
# Arguments: 0
# Date: Oct 2019

## run a simulation that involves sampling form a popuation
x<-rnorm(50) # Generate your population
doit<-function(x){
  x<-sample(x,replace = T)
  if(length(unique(x))>30){## only take mean if sample was sufficient
    print(paste("Mean of this sample was:",as.character(mean(x))))
  }
}
## run 100 iterations using vectorization:
result<-lapply(1:100,function(i) doit(x))

# print("that's enough")

## using a for loop:
result<-vector("list",100)## preallocate/Initialize
for(i in 1:100){
  result[[i]]<-doit(x)
}