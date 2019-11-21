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
library(scales)
library(minpack.lm)
library(reshape2)

## background settings
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73"    , "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#e79f00", "    #9ad0f3", "#F0E442", "#999999", "#cccccc", "#6633ff", "#00    FFCC", "#0066cc")

## data in
a.0<-read.csv("../data/CRat.csv", header = T, stringsAsFactors = F)
# colnames(a.0) ## checking

## col select (release RAM)
a.0<-data.frame(a.0$ID, a.0$Citation, a.0$ConTaxa, a.0$ResTaxa, a.0$N_TraitValue, a.0$ResDensity, a.0$ResDensityUnit, stringsAsFactors = F)
colnames(a.0)=c("id", "cite", "CTaxa", "RTaxa", "N_TraitValue", "RDen", "RDenUnit")
# for(i in 1:dim(a.0)[2]){print(paste(i,length(unique(a.0[,i]))))};rm(i) ## checking usefulness of each column for selection
for(i in 1:dim(a.0)[2]){ ## substitute NA for later grep rows out
  a.0[,i]<-ifelse(is.na(a.0[,i])==T,"sub",a.0[,i])
};rm(i)

## id unique dataset
a.1<-as.data.frame(matrix(nrow = 0, ncol = (dim(a.0)[2]-2)))
colnames(a.1)=colnames(a.0)[-c(5,6)]
for(i in 1:dim(a.0)[1]){
  if(i==1){
    v.1<-unique(a.1[,1])
    # v.2<-unique(a.1[,2])
    # v.3<-unique(a.1[,3])
    # v.4<-unique(a.1[,4])
    # v.5<-unique(a.1[,5])
  }
  if(!(a.0$id[i] %in% v.1)){
    # a.0$id[i] %in% v.1 &
    # a.0$cite[i] %in% v.2 &
    # a.0$CTaxa[i] %in% v.3 &
    # a.0$RTaxa[i] %in% v.4 &
    # a.0$RDenUnit[i] %in% v.5)){
    v.1<-unique(a.1[,1])
    # v.2<-unique(a.1[,2])
    # v.3<-unique(a.1[,3])
    # v.4<-unique(a.1[,4])
    # v.5<-unique(a.1[,5])
    a.1<-rbind(a.1,a.0[i,-c(5,6)])
  }
};rm(i);rm(list=ls(pattern="v."))
write.table(a.1, "../data/Fun_Uq.txt",sep="\t", quote=F)

## plot
# for(i in 1:dim(a.1)[1]){
#   a.p<-a.0[which(a.0$id==a.1$id[i] &
#                    a.0$cite==a.1$cite[i] &
#                    a.0$CTaxa==a.1$CTaxa[i] &
#                    a.0$RTaxa==a.1$RTaxa[i] &
#                    a.0$RDenUnit==a.1$RDenUnit[i]),]
#   if(i<10){i.1<-"00"}else if(i<100){i.1<-"0"}else{i.1<-""}
#   pdf(paste0("../sandbox/Fun_PreGraph/",i.1,i,".pdf"))
#   print(ggplot()+theme_bw()+
#           ylab("Consumer N Trait Value")+xlab(paste0("Resource Density (",unique(a.p$RDenUnit),")"))+
#           ggtitle(paste0(a.1$id[i],"_",a.1$CTaxa[i],"_\n",a.1$RTaxa[i],"_",dim(a.p)[1]))+
#           geom_text(aes(label=a.1$cite[i],x=max(a.p$RDen)-min(a.p$RDen), y=max(a.p$N_TraitValue)-min(a.p$N_TraitValue)), size=2)+
#           geom_point(aes(x=a.p$RDen, y=a.p$N_TraitValue), shape=4, colour="red"))
#   dev.off()
# };rm(i)

## function
f_hog<-function(x,a,h,q){
  return(a*x^(q+1)/(1+h*a*x^(q+1)))
}
f_qu<-function(x,a){
  return(a[1]+a[2]*x+a[3]*x^2)
}
f_cu<-function(x,a){
  return(a[1]+a[2]*x+a[3]*x^2+a[4]*x^3)
}

## record function-testing result
t_red<-rep(NA,dim(a.1)[1])
t_bes<-matrix(nrow = dim(a.1)[1], ncol = 3)

## treating every data subsets
for(i in 1:dim(a.1)[1]){
  a.p<-a.0[which(a.0$id==a.1$id[i]),]
  # a.0$id==a.1$id[i] &
  #   a.0$cite==a.1$cite[i] &
  #   a.0$CTaxa==a.1$CTaxa[i] &
  #   a.0$RTaxa==a.1$RTaxa[i] &
  #   a.0$RDenUnit==a.1$RDenUnit[i]),]
  
  v.h<-max(a.p$N_TraitValue) ## h.max
  ### screen for a.max
  a.p0<-a.p1<-a.p;i.1<-i.2<-1;a.lmM<-rep(0,2);repeat{
    if((range(a.p$RDen)[2]-range(a.p$RDen)[1]) < 5 & i.2 < 2){i.2<-2;a.p<-a.p1}
    if((range(a.p$RDen)[2]-range(a.p$RDen)[1]) < 5 & i.2 == 2){a.p<-a.p0;rm(a.p0, a.p1, i.1, i.2, a.lm);break}
    a.lm<-unname(coef(lm(a.p$N_TraitValue~a.p$RDen)))
    if(a.lm[2] > a.lmM[2]){a.lmM<-a.lm;a.p1<-a.p}
    a.p<-a.p[-which(a.p$RDen > max(a.p$RDen)*(1-.05)),] ## chop off top 5% x-axis
  }
  v.q<-runif(1, min = -10, max = 10) ## sample q from uniform distribution
  iter<-1e2
  t_rec<-data.frame("a"=rnorm(iter, mean = a.lmM[2], sd=1),
                    "h"=rnorm(iter, mean = v.h, sd=1),
                    "q"=rnorm(iter, mean = 0, sd=2),
                    "Model"=rep("generalized Holling",iter),
                    "AIC"=rep(NA,iter))
  f_qua<-try(unname(coef(
    f_qq<-lm(a.p$N_TraitValue~poly(a.p$RDen,2)))),silent = T)
  if(class(f_qua)=="try-error"){
    f_qq2<-c(rep(NA,3),"quadratic",NA)
  }else{f_qq2<-c(f_qua,"quadratic",AIC(f_qq))}
  
  f_cub<-try(unname(coef(
    f_qq<-lm(a.p$N_TraitValue~poly(a.p$RDen,3)))),silent = T)
  if(class(f_cub)=="try-error"){
    f_qq3<-c(rep(NA,3),"cubic",NA)
  }else{f_qq3<-c(f_cub,"cubic",AIC(f_qq))}
  
  i.1<-1;repeat{
    t_hog<-try(nlsLM(N_TraitValue~f_hog(RDen,a,h,q), data=a.p, start = list(a=t_rec[i.1,1], h=t_rec[i.1,2], q=t_rec[i.1,3])), silent = T)
    if(class(t_hog)!="try-error"){
      t_rec[i.1,-(dim(t_rec)-1)]<-c(as.numeric(coef(t_hog)),AIC(t_hog))}
    
    if(i.1==iter){break}else{i.1<-i.1+1}
  }
  
  t_rec<-t_rec[which(unique(t_rec$a) &
                       unique(t_rec$h) &
                       unique(t_rec$q) &
                       t_rec$AIC==min(t_rec$AIC, na.rm = T)),]
  
  ## record & screen print
  f_pri<-data.frame("model"=c(as.character(t_rec[1,dim(t_rec)[2]-1]),f_qq2[length(f_qq2)-1],f_qq3[length(f_qq3)-1]),
                    "AIC"=c(round(t_rec[1,dim(t_rec)[2]],2),
                            ifelse(is.na(f_qq2[length(f_qq2)]),NA,round(as.numeric(f_qq2[length(f_qq2)]),2)),
                            ifelse(is.na(f_qq3[length(f_qq3)]),NA,round(as.numeric(f_qq3[length(f_qq3)]),2))))
  cat(paste0("Dataset ",i," Best model: ",paste(f_pri[which(f_pri$AIC==min(f_pri$AIC, na.rm = T)),1], collapse = " ; "),"\n"))
  t_bes[i,1]<-ifelse(!is.na(f_pri[1,2]),ifelse(f_pri[1,2]==min(f_pri$AIC, na.rm = T),1,0),0)
  t_bes[i,2]<-ifelse(!is.na(f_pri[1,2]),ifelse(f_pri[2,2]==min(f_pri$AIC, na.rm = T),1,0),0)
  t_bes[i,3]<-ifelse(!is.na(f_pri[1,2]),ifelse(f_pri[3,2]==min(f_pri$AIC, na.rm = T),1,0),0)
  # if(i%%50==0){cat(paste0(i,", "))}
};rm(i)
