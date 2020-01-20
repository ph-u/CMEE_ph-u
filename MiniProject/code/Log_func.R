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

phoc.kruskal.nemenyi<-function(y, x1, x2, threshold){
  ## Extract posthoc.kruskal.nemenyi.test / pairwise.wilcox.test sig p-value
  ## construction date(s): 20180628, 20191029
  library(PMCMR)
  ppp<-posthoc.kruskal.nemenyi.test(y~interaction(x1,x2))$p.value
  ppp[ppp>threshold]<-NA
  if(sum(is.na(ppp))==dim(ppp)[1]*dim(ppp)[2]){knplist<-0;print(knplist);rm(ppp)}else{
    if(dim(ppp)[1]<=2 && dim(ppp)[2]<=2){knplist<-ppp;rm(ppp)}else{
      i<-1;repeat{
        if(sum(is.na(ppp[,i]))==dim(ppp)[1]){
          ppp<-ppp[,-i]
          if(i==(dim(ppp)[2]+1)){break}
          if(is.data.frame(ppp)==F){break}
        }else{
          i<-i+1
          if(i==(dim(ppp)[2]+1)){break}}}
      i<-1;repeat{
        if(sum(is.na(ppp[i,]))==dim(ppp)[2]){
          ppp<-ppp[-i,]
          if(i==(dim(ppp)[1]+1)){break}
          if(is.data.frame(ppp)==F){break}
        }else{
          i<-i+1
          if(i==(dim(ppp)[1]+1)){break}}}
      pppL<-row.names(ppp)
      pppC1<-colnames(ppp)
      pppC2<-0;for(i in 1:length(pppC1)){
        pppC2<-c(pppC2,rep(pppC1[i],length(pppL)))
      };pppC2<-pppC2[-1]
      pppppp<-0;for(i in 1:dim(ppp)[2]){
        pppppp<-c(pppppp,ppp[,i])
      };pppppp<-pppppp[-1]
      knplist<-data.frame(pppL,pppC2,pppppp)
      colnames(knplist)=c("f1","f2","p.val")
      knplist<-knplist[which(!is.na(knplist[,3])),]}}
}

cbp <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#0072B2", "#D55E00", "#CC79A7", "#e79f00", "#9ad0f3", "#F0E442", "#999999", "#cccccc", "#6633ff", "#00FFCC", "#0066cc")## colour-blind friendly palette