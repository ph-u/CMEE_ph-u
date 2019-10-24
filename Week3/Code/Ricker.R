#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Ricker.R
# Desc: try out running self-building functions and plot
# Input: Rscript Ricker.R
# Output: a Rplot.pdf in `Code` subdirectory
# Arguments: 0
# Date: Oct 2019

Ricker<-function(N0=1,r=1,K=10,generations=50){
  ## runs a simulation of the Ricker model
  ## returns a vector of length generations
  N<-rep(NA,generations) ## creates a vector of NA
  N[1]<-N0
  for(t in 2:generations){
    N[t]<-N[t-1]*exp(r*(1-(N[t-1]/K)))
  }
  return(N)
}
plot(Ricker(generations = 10),type = "l")