#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Log_1_s2.R
# Desc: slave script on partial dataset for model fitting
# Input: ```Rscript Log_1_s2.R <UqNum> <IterNum>```
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
v.0=as.numeric(args[1]) ## data subset num
v.1=as.numeric(args[2]) ## sampling size

## data in
a<-read.table(paste0("../data/Log_",v.0,"_data.txt"),sep="\t",header = T, stringsAsFactors = F)
a.u<-read.table(paste0("../data/Log_",v.0,"_para.txt"),sep="\t", header = T, stringsAsFactors = F)
a.u$val<-as.numeric(a.u$val)

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

f.qu<-function(para,t){return(para[1]+para[2]*t+para[3]*t^2)} ## quadratic
f.cu<-function(para,t){return(para[1]+para[2]*t+para[3]*t^2+para[4]*t^3)} ## cubic

## sample starting values
cat(paste0("start sample starting values, dataset ",v.0,"\n"))
a.0<-data.frame("N0"=abs(rnorm(v.1, mean = a.u[1,2], sd = 1)),
                "K"=abs(rnorm(v.1, mean = a.u[2,2], sd = 1)),
                "r.max"=abs(rnorm(v.1, mean = a.u[3,2], sd = 1)),
                "t.lag"=abs(rnorm(v.1, mean = a.u[4,2], sd = 1)),
                "ve"=rep(NA,v.1),"go"=rep(NA,v.1),"ba"=rep(NA,v.1),"bu"=rep(NA,v.1))
i.0<-1
repeat{ ## do trials
  ## check f.ve
  i.1<-try(nlsLM(a$Popn_Change~f.ve(N0,K,r,t=a$Time.hr), data = a, start = list(N0=a.0[i.0,1], K=a.0[i.0,2], r=a.0[i.0,3])),silent = T)
  if(class(i.1)!="try-error"){a.0[i.0,5]<-AIC(i.1)}
  
  ## check f.go
  i.1<-try(nlsLM(a$Popn_Change~f.go(N0,K,r,t=a$Time.hr,tlag), data = a, start = list(N0=a.0[i.0,1], K=a.0[i.0,2], r=a.0[i.0,3], tlag=a.0[i.0,4])),silent = T)
  if(class(i.1)!="try-error"){a.0[i.0,6]<-AIC(i.1)}
  
  ## check f.ba
  i.1<-try(nlsLM(a$Popn_Change~f.ba(N0,K,r,t=a$Time.hr,tlag), data = a, start = list(N0=a.0[i.0,1], K=a.0[i.0,2], r=a.0[i.0,3], tlag=a.0[i.0,4])),silent = T)
  if(class(i.1)!="try-error"){a.0[i.0,7]<-AIC(i.1)}
  
  ## check f.bu
  i.1<-try(nlsLM(a$Popn_Change~f.bu(N0,K,r,t=a$Time.hr,tlag,cst = a$cst), data = a, start = list(N0=a.0[i.0,1], K=a.0[i.0,2], r=a.0[i.0,3], tlag=a.0[i.0,4])),silent = T)
  if(class(i.1)!="try-error"){a.0[i.0,8]<-AIC(i.1)}
  
  ## increase row num
  if(i.0 < dim(a.0)[1]){i.0<-i.0+1}else{break}
}

## check linear models
i.qul<-try(lm(a$Popn_Change~poly(a$Time.hr,2)), silent = T) ## quadratic
i.qu<-ifelse(class(i.qul)!="try-error",AIC(i.qul),NA)

i.cul<-try(lm(a$Popn_Change~poly(a$Time.hr,3)), silent = T) ## cubic
i.cu<-ifelse(class(i.cul)!="try-error",AIC(i.cul),NA)

## extract and compare models AIC
cat(paste0("AIC calculation, dataset ",v.0,"\n"))
a.1<-data.frame("model"=c("ve","go","ba","bu","qu","cu"), ## extract minimal AIC from NLLS trials
                "AIC"=c(if(any(!is.na(a.0[,5]))){min(a.0[,5],na.rm = T)}else{NA},
                        if(any(!is.na(a.0[,6]))){min(a.0[,5],na.rm = T)}else{NA},
                        if(any(!is.na(a.0[,7]))){min(a.0[,5],na.rm = T)}else{NA},
                        if(any(!is.na(a.0[,8]))){min(a.0[,5],na.rm = T)}else{NA},i.qu,i.cu),
                "num"=c(5:8,0,1),
                stringsAsFactors = F)
a.u<-rbind(a.u, c("Model",a.1[which(a.1$AIC==min(a.1$AIC, na.rm = T)),1]))

## best parameters to data
v.2<-as.data.frame(matrix(nrow = 5, ncol = 6))
colnames(v.2)=c("Verhulst_(classical)","modified_Gompertz","Baranyi","Buchanan","quadratic","cubic")
row.names(v.2)=c("AIC",seq(1:(dim(v.2)[1]-1)))
for(i in 1:dim(v.2)[2]){
  if(i<5){
    v.2[1,i]<-ifelse(length(a.0[which(is.na(a.0[,i+4])),(i+4)])==dim(a.0)[1],NA,min(a.0[,i+4], na.rm = T)) ## select min AIC per phenological model -- a.0[,i+4]: AIC; length(): count num of successful trials
  }else if(i>5){
    v.2[1,i]<-ifelse(is.na(i.cu),NA,i.cu)
  }else{v.2[1,i]<-ifelse(is.na(i.qu),NA,i.qu)}
  
  if(!is.na(v.2[1,i])){
    if(i<5){ ## extract all deducible parameters, not all used in phenological model functions
      i.1<-as.data.frame(a.0[which(a.0[,i+4]==min(a.0[,i+4], na.rm = T)),1:4])
    v.2[,i]<-c(v.2[1,i],as.numeric(i.1[1,]))
    }else
    if(i==5){v.2[,i]<-c(v.2[1,i],as.numeric(coef(i.qul)),NA)}
    else{v.2[,i]<-c(v.2[1,i],as.numeric(coef(i.cul)))}
  }
};rm(i)

## data attributes for vertical file combine
a.u$dt<-v.2[dim(v.2)[1]+1,]<-as.character(v.0)
i.0<-which(as.numeric(v.2[1,])<min(as.numeric(v.2[1,]), na.rm = T)+2)
for(i in 1:dim(v.2)[2]){if(!(i %in% i.0)){v.2[,i]<-NA}};rm(i, i.0)

## data export
write.table(a.u[,c(3,1,2)],paste0("../data/Log_",v.0,"_para.txt"), sep = "\t", quote = F, row.names = F, col.names = F) ## model details, model numeric values
write.table(t(v.2)[,c(6,1:5)],paste0("../data/Log_",v.0,"_data.txt"), sep = "\t", quote = F, col.names = F) ## model, AIC, para 1, para 2, para 3, para 4
cat(paste0("dataset ",v.0," done\n"))
