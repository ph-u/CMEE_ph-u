#!/bin/env Rscript

# Author: ph-u
# Script: PP_Lattice.R
# Desc: 1. use `lattice` R-pkg to plot three density plots; 2. export data descriptions of mean and median as `csv`
# Input: Rscript PP_Lattice.R
# Output: 1. three separate vector graphs in `pdf` within `Results` subdirectory; 2. partial data summary as `csv` in `Results` subdirectory
# Arguments: 0
# Date: Oct 2019

## library
library(ggplot2)
library(lattice)

## input
oo<-read.csv("../Data/EcolArchives-E089-51-D1.csv")
for(i in 1:dim(oo)[1]){
  if(as.character(oo[i,14])=="mg"){
#    oo[i,9]<-oo[i,9]/1000
    oo[i,13]<-oo[i,13]/1000
    oo[i,14]<-"g"
  }
};rm(i)

## graphs & export
pdf("../Results/Pred_Lattice.pdf")
densityplot(~log(oo$Predator.mass)|oo$Type.of.feeding.interaction,xlab = "log(Predator mass)")
dev.off()
pdf("../Results/Prey_Lattice.pdf")
densityplot(~log(oo$Prey.mass)|oo$Type.of.feeding.interaction,xlab = "log(Prey mass)")
dev.off()
pdf("../Results/SizeRatio_Lattice.pdf")
densityplot(~log(oo$Prey.mass/oo$Predator.mass)|oo$Type.of.feeding.interaction,xlab = "log(Prey mass / Predator mass)")
dev.off()

## data description collect & export
a.0<-levels(oo$Type.of.feeding.interaction)
oo.0<-data.frame(
  "data"=c(rep("Predator.Mass.g",length(a.0)),
           rep("Prey.Mass.g",length(a.0)),
           rep("Prey/Predator.Mass",length(a.0)),
           rep("log(Predator.Mass)",length(a.0)),
           rep("log(Prey.Mass)",length(a.0)),
           rep("log(Prey/Predator.Mass)",length(a.0))),
  "FeedingType"=rep(NA,2*3*length(a.0)),
  "mean"=rep(NA,2*3*length(a.0)),
  "median"=rep(NA,2*3*length(a.0)))
oo.0[,2]<-a.0
oo$ratio<-oo$Prey.mass/oo$Predator.mass
for(i in 1:dim(oo.0)[1]){
  ## determine which input source is used
  if(length(grep("y/P",oo.0[i,1]))>0){j.0<-16
  }else if(length(grep("Prey",oo.0[i,1]))>0){j.0<-13
  }else{j.0<-9}
  
  ## calculation
  if(length(grep("log",oo.0[i,1]))>0){
    oo.0[i,3]<-mean(log(oo[which(oo$Type.of.feeding.interaction==oo.0$FeedingType[i]),j.0])) ## log-mean vs mean-log <https://stats.stackexchange.com/questions/250209/log-mean-vs-mean-log-in-statistics>
    oo.0[i,4]<-median(log(oo[which(oo$Type.of.feeding.interaction==oo.0$FeedingType[i]),j.0]))
  }else{
    oo.0[i,3]<-mean(oo[which(oo$Type.of.feeding.interaction==oo.0$FeedingType[i]),j.0])
    oo.0[i,4]<-median(oo[which(oo$Type.of.feeding.interaction==oo.0$FeedingType[i]),j.0])
  }
};rm(i)
write.csv(oo.0,"../Results/PP_Results.csv", quote = F, row.names=F)
