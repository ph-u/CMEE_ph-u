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

## raw
a.0<-read.csv("../data/Log_data.csv",header = T)
a.1<-read.table("../data/Log_Metadata.txt", sep = "\t", header = F, stringsAsFactors = F, blank.lines.skip = T)

## variable
r.m<-(max(a.0[which(a.0$cluster==2),2])-min(a.0[which(a.0$cluster==2),2])) / (max(a.0[which(a.0$cluster==2),3])-min(a.0[which(a.0$cluster==2),3]))
r.b<-max(a.0[which(a.0$cluster==2),2])-r.m*max(a.0[which(a.0$cluster==2),3])
r.x<--r.b/r.m

## logistic equations: y=Nt x=exp(t)
func_log0<-function(N0=as.numeric(a.1[19,2]),
                    K=as.numeric(a.1[21,2]),
                    r=r.m, t){
  ## traditional Logistic equation: y~x
  Nt=N0*K*exp(r*t)/(K+N0*(exp(r*t)-1))
  return(Nt)}

func_gom<-function(N0=as.numeric(a.1[19,2]),
                   K=as.numeric(a.1[21,2]),
                   r=r.m, t,
                   ld=r.x){
  ## modified Gompertz model, initial 
  A=log(K/N0)
  Nt=exp(A*exp(-exp(r*exp(1)/A*(ld-t)+1))*1.1) ## mod: exp(f(t)*1.1)
  return(Nt)}

func_bar<-function(N0=as.numeric(a.1[19,2]),
                   K=as.numeric(a.1[21,2]),
                   r=r.m, t,
                   tlag=max(a.0[which(a.0$cluster==1),3])){
  ## Baranyi model
  h0=1/(exp(tlag*r)-1)
  At=t+1/r*log((exp(-r*t)+h0)/(1+h0))
  Nt=(N0+r*At-exp(log(1+(exp(r*At)-1)/exp(K-N0))))*4 ## mod: f(exp(f(t|growth)))*4
  return(Nt)}

func_buc<-function(N0=as.numeric(a.1[19,2]),
                   K=as.numeric(a.1[21,2]),
                   r=r.m, t,
                   tlag=max(a.0[which(a.0$cluster==1),3]),
                   cst=as.numeric(a.0$cluster)){
  ## Buchanan model / three-phase logistic model
  a.010=(cst-1)%%2 ## make only log phase valid in growth rate
  a.001=ceiling(cst%%2.5%%1) ## make only final phase valid
  Nt=N0+a.001*(K-N0)+a.010*exp(r*(t-tlag)) ## mod: exp(f(t|growth))
  return(Nt)}

## trial plots
{## tests
  # for(i in 1:length(a.0[,3])){
  #   j<-a.0[i,3]
  #   print(paste(i,j,func_bar(t=j)))};rm(i,j)
  plot(log(a.0[,4])~a.0[,3])
  points(log(func_log0(t=a.0[,3]))~a.0[,3], pch=4, col="brown", add=T)
  points(log(func_gom(t=a.0[,3]))~a.0[,3], pch=4, col="pink", add=T)
  points(log(func_bar(t=a.0[,3]))~a.0[,3], pch=4, col="red", add=T)
  points(log(func_buc(t=a.0[,3]))~a.0[,3], pch=4, col="green", add=T)
}

## can't run model because data is too good? <https://stats.stackexchange.com/questions/13053/singular-gradient-error-in-nls-with-correct-starting-values>
## can't run model because models are too board / too specific? <https://stackoverflow.com/questions/35409099/r-minpack-lmnls-lm-failed-with-good-results>
nls_log0<-nlsLM(Popn_Change ~ func_log0(N0, K, r, t=a.0$Time.hr), data = a.0, start = list(N0=as.numeric(a.1[19,2]),K=as.numeric(a.1[21,2]),r=r.m), lower = c(min(a.0[which(a.0[,5]==1),4]),min(a.0[which(a.0[,5]==3),4]),r.m-1), upper = c(max(a.0[which(a.0[,5]==1),4]),max(a.0[which(a.0[,5]==3),4]),r.m+1))

nls_gom<-nlsLM(Popn_Change ~ func_gom(N0, K, r, t=a.0$Time.hr, ld), data = a.0, start = list(N0=as.numeric(a.1[19,2]),K=as.numeric(a.1[21,2]),r=r.m,ld=r.x), lower = c(min(a.0[which(a.0[,5]==1),4]),min(a.0[which(a.0[,5]==3),4]),r.m-1,r.x-1), upper = c(max(a.0[which(a.0[,5]==1),4]),max(a.0[which(a.0[,5]==3),4]),r.m+1,r.x+1))

nls_bar<-nlsLM(Popn_Change ~ func_bar(N0, K, r, t=a.0$Time.hr, tlag), data = a.0, start = list(N0=as.numeric(a.1[20,2]),K=as.numeric(a.1[21,2]),r=r.m, tlag=max(a.0[which(a.0$cluster==1),3])), lower = c(min(a.0[which(a.0[,5]==1),4]),min(a.0[which(a.0[,5]==3),4]),r.m-1, max(a.0[which(a.0$cluster==1),3])-mean(a.0[which(a.0$cluster==1),3])), upper = c(max(a.0[which(a.0[,5]==1),4]),max(a.0[which(a.0[,5]==3),4]),r.m+1, max(a.0[which(a.0$cluster==1),3])+mean(a.0[which(a.0$cluster==1),3])))

nls_buc<-nlsLM(Popn_Change ~ func_log0(N0, K, r, t=a.0$Time.hr), data = a.0, start = list(N0=as.numeric(a.1[20,2]),K=as.numeric(a.1[21,2]),r=r.m), lower = c(min(a.0[which(a.0[,5]==1),4]),min(a.0[which(a.0[,5]==3),4]),r.m-1), upper = c(max(a.0[which(a.0[,5]==1),4]),max(a.0[which(a.0[,5]==3),4]),r.m+1))
