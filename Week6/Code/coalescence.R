#!/bin/env R

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: coalescence.R
# Desc: classwork program based on killer whale data files
# Input: Rscript coalescence.R
# Output: R terminal output
# Arguments: 0
# Date: Nov 2019

## Hypothesis: Population sizes of Northern and Southern Atlantic killer whales different

## lib
library(ggplot2)

## raw
a.N<-read.csv("../Data/killer_whale_North.csv", header = F)
a.S<-read.csv("../Data/killer_whale_South.csv", header = F)
sn<-dim(a.N)[2]

## get SNP
a.0<-c();for(i in 1:dim(a.N)[2]){if(length(unique(a.N[,i]))>1){a.0<-c(a.0,i)}};rm(i);a.N<-a.N[,a.0];rm(a.0)
a.0<-c();for(i in 1:dim(a.S)[2]){if(length(unique(a.S[,i]))>1){a.0<-c(a.0,i)}};rm(i);a.S<-a.S[,a.0];rm(a.0)

## result df
res<-as.data.frame(matrix(nrow = 4, ncol = 0))
res$source<-c(rep("a.N",2),rep("a.S",2))
res$func<-c("Watterson","Tajima")
## Watterson's estimator
wat<-function(df){
  S=dim(df)[2]
  n=dim(df)[1]
  a<-rep(NA,(n-1))
  for(i in 1:(n-1)){a[i]<-1/i};rm(i)
  a<-sum(a)
  return(S/a)
}

## Tajima's estimator
taj<-function(df){
  n=dim(df)[1]
  a=rep(NA,(n-1)^2)
  for(i in 1:(n-1)){
    for(j in (i+1):n){
      ij<-0
      for(p in 1:dim(df)[2]){
        if(isTRUE(df[i,p]!=df[j,p])){ij<-ij+1}
      };rm(p)
      a<-c(a,ij)
    };rm(j)
  };rm(i)
  return(sum(a, na.rm = T)*2/(n*(n-1)))
}

res$est<-c(wat(a.N), taj(a.N), wat(a.S), taj(a.S))

## total substitution
theta<-4*dim(a.N)[1]*1e-8*sn

## effective popn size
res$effective<-res$est/(4*sn*1e-8)

{## site frequency spectrum flattens (from lower freq side, exp-dist -> flat) when popultion drops
  res.p<-as.data.frame(matrix(nrow = (dim(a.N)[2]+dim(a.S)[2]), ncol = 1))[,-1]
  res.p$source<-c(rep("a.N",dim(a.N)[2]),rep("a.S",dim(a.S)[2]))
  for(i in 1:dim(a.N)[2]){res.p[i,2]<-sum(a.N[,i])};rm(i)
  for(i in 1:dim(a.S)[2]){res.p[(i+dim(a.N)[2]),2]<-sum(a.S[,i])};rm(i)
  a.N.count<-table(res.p[which(res.p$source=="a.N"),2])
  a.N.count<-data.frame("s"=names(a.N.count),"d"=unname(a.N.count)/sum(unname(a.N.count)))[,-2]
  a.N.count$t<-"a.N"
  a.S.count<-table(res.p[which(res.p$source=="a.S"),2])
  a.S.count<-data.frame("s"=names(a.S.count),"d"=unname(a.S.count)/sum(unname(a.S.count)))[,-2]
  a.S.count$t<-"a.S"
  
  a.NS<-rbind(a.N.count, a.S.count);rm(a.N.count, a.S.count)
  a.tot<-table(res.p[,2])
  a.tot<-data.frame("s"=names(a.tot),"d"=unname(a.tot)/sum(unname(a.tot)))[,-2]
}

pdf("../results/coalescence_01.pdf")
ggplot()+theme_bw()+
  xlab("Site Frequency Spectrum")+ylab("SFS density")+
  scale_fill_discrete(name="Source", label=c("North", "South"))+
  geom_col(aes(x=as.numeric(as.character(a.NS$s)), y=as.numeric(a.NS$d.Freq), fill=a.NS$t), position="dodge") ## <https://stackoverflow.com/questions/38101512/the-same-width-of-the-bars-in-geom-barposition-dodge>
dev.off()

pdf("../results/coalescence_02.pdf")
ggplot()+theme_bw()+
  xlab("Site Frequency Spectrum")+ylab("SFS density")+
  geom_col(aes(x=as.numeric(as.character(a.tot$s)), y=as.numeric(a.tot$d.Freq)))
dev.off()
