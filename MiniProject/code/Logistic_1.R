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

## logistic equations: y=Nt x=exp(t)
func_log0<-function(N0, K, r, t){
  ## traditional Logistic equation: y~x
  Nt<-N0*K*exp(r*t)/(K+N0*(exp(r*t)-1))
  return(Nt)
}
func_Gom<-function(N0, K, r, ld, t){
  ## modified Gompertz model, initial 
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
ls_f1<-read.table("../data/Log_Metadata.txt", sep = "\t", header = F, stringsAsFactors = F, blank.lines.skip = T)

## fix values for model-fitting
## assumed growth rate (r) is max during log phase (cluster 2)
dict_par<-as.data.frame(matrix(nrow = 6, ncol = 2))
dict_par[,1]<-c("N0", "K", "r", "ld", "tlag", "tmx")
## cluster 1 = lag; 2 = log; 3 = max
r.m<-(max(ls_f0[which(ls_f0$cluster==2),4])-min(ls_f0[which(ls_f0$cluster==2),4])) / (max(ls_f0[which(ls_f0$cluster==2),3])-min(ls_f0[which(ls_f0$cluster==2),3]))
r.y<-as.numeric(ls_f1[21,2])
r.x<-mean(ls_f0[which(ls_f0$cluster==2),3])
r.b<-r.y-r.m*r.x
dict_par[,2]<-c(ls_f1[20,2],ls_f1[22,2], ## N0, K
                r.m, ## r
                -r.b/r.m, ## ld
                max(ls_f0[which(ls_f0$cluster==2),3])-min(ls_f0[which(ls_f0$cluster==1),3]), ## tlag
                min(ls_f0[which(ls_f0$cluster==3),3])) ## tmx
rm(list=ls(pattern="r."))

## model-fitting (use log data)
{ppt<-ppp<-c()
  for(i in log(ls_f0[,3])){
    ppt<-c(ppt,i)
    ppp<-c(ppp,func_Gom(
      as.numeric(dict_par[which(dict_par[,1]=="N0"),2]),
      as.numeric(dict_par[which(dict_par[,1]=="K"),2]),
      as.numeric(dict_par[which(dict_par[,1]=="r"),2]),
      as.numeric(dict_par[which(dict_par[,1]=="ld"),2]), i))
  };plot(ppp~ppt)
  View(data.frame(ppt,ppp))
  rm(i,ppp,ppt)}

nlls_log0<-nlsLM(logPop ~ func_log0(N0, K, r, ls_f0[,1]), data = ls_f0,
                 ## y place must be a colname only
                 start = list(N0=as.numeric(dict_par[which(dict_par[,1]=="N0"),2]),
                              K=as.numeric(dict_par[which(dict_par[,1]=="K"),2]),
                              r=as.numeric(dict_par[which(dict_par[,1]=="r"),2])))

nlls_Gom<-nlsLM(logPop ~ func_Gom(N0, K, r, ld, ls_f0[,1]), data = ls_f0,
                start = list(N0=as.numeric(dict_par[which(dict_par[,1]=="N0"),2]),
                             K=as.numeric(dict_par[which(dict_par[,1]=="K"),2]),
                             r=as.numeric(dict_par[which(dict_par[,1]=="r"),2]),
                             ld=as.numeric(dict_par[which(dict_par[,1]=="ld"),2])))
