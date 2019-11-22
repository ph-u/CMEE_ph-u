#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Log_2.R
# Desc: slave script on partial dataset for model fitting
# Input: ```Rscript Log_2.R <UqNum> <IterNum>```
# Output: model-fitting analysis result
# Arguments: 2
# Date: Nov 2019

## settings:
## a = raw data (data subset in slave scripts)
## a.~ = data.frames decending from raw data
## f.~ = functions
## v.~ = variables
## i~ = temporary variables

## library
library(minpack.lm)

## take command line order
args=(commandArgs(T))
v.0=as.numeric(args[1])
v.1=as.numeric(args[2])

## data in
a<-read.table(paste0("../data/Log_",v.0,"_data.txt"),sep="\t",header = T, stringsAsFactors = F)
a.u<-read.table(paste0("../data/Log_",v.0,"_para.txt"),sep="\t", header = T, stringsAsFactors = F)

## functions

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

## sample starting values
a.0<-as.matrix(data.frame("N0"=abs(rnorm(v.1, mean = a.u[1,2], sd = 1)),
                          "K"=abs(rnorm(v.1, mean = a.u[2,2], sd = 1)),
                          "r.max"=abs(rnorm(v.1, mean = a.u[3,2], sd = 1)),
                          "t.lag"=abs(rnorm(v.1, mean = a.u[4,2], sd = 1)),
                          "ve"=rep(NA,v.1),"go"=rep(NA,v.1),"ba"=rep(NA,v.1),"bu"=rep(NA,v.1)))
i.0<-1
repeat{
  i.ve<-try(nlsLM(a$Popn_Change~f.ve(N0,K,r,t=a$Time.hr), data = a, start = list(N0=a.0[i.0,1], K=a.0[i.0,2], r=a.0[i.0,3])),silent = T)
  if(class(i.ve)!="try_error"){a.0[i.0,5]<-AIC(i.ve)}
}