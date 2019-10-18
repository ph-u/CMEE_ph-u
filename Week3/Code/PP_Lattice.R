#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: PP_Lattice.R
# Desc: 1. use `lattice` R-pkg to plot three plots; 2. export data descriptions of mean and median as `csv`
# Input: Rscript PP_Lattice.R
# Output: 1. three separate vector graphs in `pdf` within `results` subdirectory; 2. partial data summary as `csv` in `results` subdirectory
# Arguments: 0
# Date: Oct 2019

## library
library(ggplot2)
library(lattice)

## input
oo<-read.csv("../Data/EcolArchives-E089-51-D1.csv")

## graphs & export
pdf("../results/Pred_Lattice.pdf")
densityplot(~log(oo$Predator.mass),xlab = "log(Predator mass)")
dev.off()
pdf("../results/Prey_Lattice.pdf")
densityplot(~log(oo$Prey.mass),xlab = "log(Prey mass)")
dev.off()
pdf("../results/SizeRatio_Lattice.pdf")
densityplot(~log(oo$Prey.mass/oo$Predator.mass),xlab = "log(Prey mass / Predator mass)")
dev.off()

## data description collect & export
oo.0<-data.frame("mean"=rep(NA,3),"median"=rep(NA,3))
j<-data.frame(oo$Predator.mass,oo$Prey.mass,oo$Predator.mass/oo$Prey.mass)
for(i in 1:dim(oo.0)[1]){
  oo.0[i,1]<-mean(j[,i])
  oo.0[i,2]<-median(j[,i])
};rm(i,j)
row.names(oo.0)=c("Predator.Mass.g","Prey.Mass.g","Predator.Mass/Prey.Mass")
write.csv(oo.0,"../results/PP_Results.csv", quote = F, row.names=T)
