#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: browse.R
# Desc: generate a break point for debugging
# Input: Rscript browse.R
# Output: variable-lined (around 150) terminal output
# Arguments: 0
# Date: Oct 2019

Exponential<-function(N0=1,r=1,generations=10){
  ## runs a simulation of exponential growth
  ## returns a vector of length generations
  
  N<-rep(NA,generations) ## creates a vector of NA
  
  N[1]<-N0
  for(t in 2:generations){
    N[t]<-N[t-1]*exp(r)
    browser()
  }
  return(N)
}
plot(Exponential(),type="1",main="Exponential growth")