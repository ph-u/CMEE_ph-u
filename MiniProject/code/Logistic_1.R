#!/bin/env R

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Logistic_1.R
# Desc: model-fitting for `LogisticGrowthMetaData.csv`, preparation for python3 script
# Input: ```Rscript Logistic_1.R```
# Output: analysis result output in `result` subdirectory
# Arguments: 0
# Date: Nov 2019

## lib
library(minpack.lm)

## logistic equations
func_log0<-function(N0, K, r, t){
  ## traditional Logistic equation
  Nt<-N0*k*exp(r*t)/(K+N0*(exp(r*t)-1))
  return(Nt)
}
func_Gom<-function(N0, K, r, ld, t){
  ## modified Gompertz model
  A<-log(K/N0)
  Nt<-A*exp(-exp(r*exp(1)/A*(ld-t)+1))
  return(Nt)
}
func_Bar<-function(N0, K, r, ld, t){
  ## Baranyi model
  h0=(exp(ld*r)-1)^-1
  At=t+r^-1*log((exp(-r*t)+h0)/(1+h0))
  Nt=N0+r*At-log(1+exp(r*At-1)/exp(K-N0))
  return(Nt)
}
func_Buc<-function(N0, K, tlag, tmx, t){
  ## Buchanan model / three-phase logistic model
  if(t<=tlag){
    Nt=N0
  }else if(t>=tmx){
    Nt=K
  }else{Nt=K+r*(t-tlag)}
  return(Nt)
}

## raw data
ls_f0<-read.csv("../data/Log_data.csv", header = T)

## metadata arrangement
ls_f1<-read.table("../data/Log_Metadata.txt", sep = "\t", header = F, row.names = F, stringsAsFactors = F, blank.lines.skip = T)
