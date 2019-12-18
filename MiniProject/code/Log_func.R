#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Log_func.R
# Desc: function bin for Phenological Models
# Input: none
# Output: none
# Arguments: 0
# Date: Dec 2019

## settings:
## a = raw data (data subset in slave scripts)
## a.~ = data.frames decending from raw data
## f.~ = functions
## v.~ = variables
## i~ = temporary variables

##########
## Models

f.ve<-function(N0,K,r,t){
  ## Verhulst equation / classical
  Nt=N0*K*exp(r*t)/(K+N0*(exp(r*t)-1))
  return(Nt)}

f.go<-function(N0,K,r,t,tlag){
  ## modified Gompertz model
  A=log(K/N0)
  Nt=A*exp(-exp((r*exp(1)*(tlag-t))/A+1))
  return(Nt)}

f.ba<-function(N0,K,r,t,tlag){
  ## Baranyi model
  h0=1/(exp(tlag*r)-1)
  At=t+1/r*log((exp(-r*t)+h0)/(1+h0))
  Nt=N0+r*At-log(1+(exp(r*At)-1)/exp(K-N0))
  return(Nt)}

f.bu<-function(N0,K,r,t,tlag,cst){
  ## Buchanan model / three-phase logistic model
  a.010=(cst-1)%%2 ## make only log phase valid in growth rate
  a.001=ceiling(cst%%2.5%%1) ## make only final phase valid
  Nt=N0+a.001*(K-N0)+a.010*r*(t-tlag)
  return(Nt)}

## general useful functions
ls2Mtx<-function(Rlist){
  i.0=c()
  i.1=length(Rlist)
  for(i in 1:i.1){ ## vector out length of each entry
    i.0<-c(i.0,length(Rlist[[i]]))
  }
  i.2<-max(i.0)
  lst<-matrix(nrow = i.1, ncol = i.2)
  for(i in 1:i.1){
    lst[i,]<-c(unname(unlist(Rlist[[i]])),rep(NA,i.2-i.0[i]))
  }
  return(lst)
}