#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: PP_Regress_loc.R
# Desc: Export data information (under factors "predator feeding type", "predator life stage" and "location") to `Results` subdirectory
# Input: Rscript PP_Regress_loc.R
# Output: result `csv` in `Results` subdirectory
# Arguments: 0
# Date: Oct 2019

## library

## input
oo<-read.csv("../Data/EcolArchives-E089-51-D1.csv", header = T)

## data info collect
oo.0<-as.data.frame(matrix(nrow = length(unique(oo$Type.of.feeding.interaction))*length(unique(oo$Predator.lifestage))*length(unique(oo$Location)), ncol = 10))

colnames(oo.0)<-c("FeedingType", "LifeStageCategory", "Location", "slopeSpearman", "interceptSpearman","R2", "F-statistics", "p-val", "PredatorMassUniqueness", "PreyMassUniqueness")

  ## det factors
a.0<-levels(oo$Type.of.feeding.interaction)
a.1<-levels(oo$Predator.lifestage)
a.2<-levels(oo$Location)

  ## factors column in oo.0
a.0.r<-0;for(i in 1:length(a.0)){
  a.0.r<-c(a.0.r,rep(a.0[i],length(a.1)*length(a.2)))
};oo.0[,1]<-as.factor(a.0.r[-1]);rm(a.0.r,i)

a.1.r<-0;for(i in 1:length(a.1)){
  a.1.r<-c(a.1.r,rep(a.1[i],length(a.2)))
};oo.0[,2]<-as.factor(a.1.r[-1]);rm(a.1.r,i)

oo.0[,3]<-as.factor(a.2)
rm(list=ls(pattern="a."))

  ## cal & mark stat
for(i in 1:dim(oo.0)[1]){
  a.1<-length(oo$Predator.mass[which(oo$Type.of.feeding.interaction==oo.0$FeedingType[i] & oo$Predator.lifestage==oo.0$LifeStageCategory[i] & oo$Location==oo.0$Location[i])])
  if(a.1>0){
    print(paste("Usable results:",oo.0[i,1],";",oo.0[i,2],";",oo.0[i,3]))
    a.1<-oo[which(oo$Type.of.feeding.interaction==oo.0$FeedingType[i] & oo$Predator.lifestage==oo.0$LifeStageCategory[i] & oo$Location==oo.0$Location[i]),]
    a.2<-suppressWarnings(cor.test(log(a.1$Predator.mass),log(a.1$Prey.mass), method="spearman"))
    a.3<-lm(log(a.1$Predator.mass)~log(a.1$Prey.mass))
    oo.0[i,4]<-unname(a.3$coefficients[2])
    oo.0[i,5]<-unname(a.3$coefficients[1])
    oo.0[i,6]<-unname(a.2$estimate)^2
    oo.0[i,7]<-unname(a.2$statistic)
    oo.0[i,8]<-unname(a.2$p.value)
    oo.0[i,9]<-length(unique(a.1$Predator.mass))
    oo.0[i,10]<-length(unique(a.1$Prey.mass))
  }
};oo.0<-oo.0[which(is.na(oo.0[,4])!=T),];rm(i);rm(list=ls(pattern="a."))
oo.0$Location<-gsub(",",";",oo.0$Location)
write.csv(oo.0,"../Results/PP_Regress_loc_Results.csv",row.names = F, quote = F)
