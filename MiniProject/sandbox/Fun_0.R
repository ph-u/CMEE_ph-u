#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Fun_0.R
# Desc: Miniproject on `CRat.csv`
# Input: ```Rscript Fun_0.R```
# Output: results
# Arguments: 0
# Date: Nov 2019

# setwd("/Volumes/HPM-000/Academic/Masters/ICL_CMEE/00_course/CMEECourseWork_pmH/MiniProject/code/")

## lib
library(ggplot2)

## data in
a.0<-read.csv("../data/CRat.csv", header = T, stringsAsFactors = F)
colnames(a.0) ## checking

## col select (release RAM)
a.0<-data.frame(a.0$ID, a.0$Citation, a.0$ConTaxa, a.0$ResTaxa, a.0$N_TraitValue, a.0$ResDensity, a.0$ResDensityUnit, stringsAsFactors = F)
colnames(a.0)=c("id", "cite", "CTaxa", "RTaxa", "N_TraitValue", "RDen", "RDenUnit")
for(i in 1:dim(a.0)[2]){print(paste(i,length(unique(a.0[,i]))))};rm(i) ## checking usefulness of each column for selection
for(i in 1:dim(a.0)[2]){ ## substitute NA for later grep rows out
  a.0[,i]<-ifelse(is.na(a.0[,i])==T,"sub",a.0[,i])
};rm(i)

## id unique dataset
a.1<-as.data.frame(matrix(nrow = 0, ncol = (dim(a.0)[2]-2)))
colnames(a.1)=colnames(a.0)[-c(5,6)]
for(i in 1:dim(a.0)[1]){
  if(i==1){
    v.1<-unique(a.1[,1])
    v.2<-unique(a.1[,2])
    v.3<-unique(a.1[,3])
    v.4<-unique(a.1[,4])
    v.5<-unique(a.1[,5])
  }
  if(!(a.0$id[i] %in% v.1 &
       a.0$cite[i] %in% v.2 &
       a.0$CTaxa[i] %in% v.3 &
       a.0$RTaxa[i] %in% v.4 &
       a.0$RDenUnit[i] %in% v.5)){
    v.1<-unique(a.1[,1])
    v.2<-unique(a.1[,2])
    v.3<-unique(a.1[,3])
    v.4<-unique(a.1[,4])
    v.5<-unique(a.1[,5])
    a.1<-rbind(a.1,a.0[i,-c(5,6)])
  }
};rm(i);rm(list=ls(pattern="v."))
write.table(a.1, "../data/Fun_Uq.txt",sep="\t", quote=F)

## plot
for(i in 1:dim(a.1)[1]){
  a.p<-a.0[which(a.0$id==a.1$id[i] &
                   a.0$cite==a.1$cite[i] &
                   a.0$CTaxa==a.1$CTaxa[i] &
                   a.0$RTaxa==a.1$RTaxa[i] &
                   a.0$RDenUnit==a.1$RDenUnit[i]),]
  if(i<10){i.1<-"00"}else if(i<100){i.1<-"0"}else{i.1<-""}
  pdf(paste0("../sandbox/Fun_PreGraph/",i.1,i,".pdf"))
  print(ggplot()+theme_bw()+
    ylab("Consumer N Traait Value")+xlab(paste0("Resource Density (",unique(a.p$RDenUnit),")"))+
    ggtitle(paste0(a.1$id[i],"_",a.1$CTaxa[i],"_\n",a.1$RTaxa[i],"_",dim(a.p)[1]))+
    geom_text(aes(label=a.1$cite[i],x=max(a.p$RDen)-min(a.p$RDen), y=max(a.p$N_TraitValue)-min(a.p$N_TraitValue)), size=2)+
    geom_point(aes(x=a.p$RDen, y=a.p$N_TraitValue), shape=4, colour="red"))
  dev.off()
};rm(i)
