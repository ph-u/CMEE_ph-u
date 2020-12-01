#!/bin/env Rscript

# Author: ph-u
# Script: rodents.R
# Desc: data analysis of rodent dataset
# Input: none -- run in R console line-by-line
# Output: R terminal output
# Arguments: 0
# Date: Oct 2019

## lib
library(car)
library(PMCMR)
library(dplyr)

{## data-scanning
  oo<-read.csv("../Data/rodents.csv", header = T, stringsAsFactors = F)
  oo$yr<-as.factor(oo$yr)
  oo$mo<-as.factor(oo$mo)
  oo$tag<-ifelse(oo$tag=="","No_Tag",oo$tag)
  oo$tag<-as.factor(oo$tag)
  oo$species<-as.factor(oo$species)
  oo$sex<-ifelse(oo$sex!="M", ifelse(oo$sex !="F","No_Data","F"),"M")
  oo$sex<-as.factor(oo$sex)
  colnames(oo)[6]<-"hindfootLength.mm"
  colnames(oo)[7]<-"weight.g"
  colnames(oo)[8]<-"precipitation.mm"
  # aa<-oo[which(oo$sex!="M" & oo$sex!="F" & oo$sex!=""),]
  # aa<-oo[which(oo$sex=="M"),]
}
## data description oo[,6]
## data description oo[,7]
for(i in 1:5){
  if(i!=3){
    boxplot(oo[,7]~oo[,i])
  }
};rm(i)

## data description oo[,8]
for(i in 1:5){
  if(i!=3){
      boxplot(oo[,8]~oo[,i])
  }
};rm(i)

## stat (only tell how reliable is the test, no need to put into publication)
hist(log(oo$precipitation.mm))
hist(log(oo$weight.g))
hist(oo$hindfootLength.mm)
qqPlot(log(oo$precipitation.mm), ylim = c(0,10))
qqPlot(log(oo$weight.g), ylim = c(0,10))
qqPlot(log(oo$hindfootLength.mm))

## non-parametric
cor.test(oo$weight.g,oo$precipitation.mm, method = "spearman") ## is precipitation affecting weight?
# cor.test(log(oo$weight.g),log(oo$precipitation.mm), method = "spearman")
kruskal.test(oo$weight.g~interaction(oo$species,oo$sex))
posthoc.kruskal.nemenyi.test(oo$weight.g~interaction(oo$species,oo$sex))
# a<-posthoc.kn.test(oo$weight.g,oo$species,oo$sex) ## self-function

kruskal.test(oo$weight.g~oo$sex)
posthoc.kruskal.nemenyi.test(oo$weight.g~oo$sex)
aa<-oo[which(oo$sex!="No_Data"),]
aa$sex<-as.factor(as.character(aa$sex))
boxplot(aa$weight.g~aa$sex, main="Boxplot of Rodent weight against Gender", ylab = "Weight (g)", xlab = "Gender")

cat(paste("Male weight median:",unname(summary(aa[which(aa$sex=="M"),7])[3]),"\nFemale weight median:",unname(summary(aa[which(aa$sex=="F"),7])[3]),"\nMedian Difference by rodent gender:",unname(summary(aa[which(aa$sex=="M"),7])[3])-unname(summary(aa[which(aa$sex=="F"),7])[3])))
