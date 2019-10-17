#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: TAutoCorr.R
# Desc: Main code dump for `TAutoCorr.Rnw` for statistical analysis and a graphical chart
# Input: Rscript TAutoCorr.R
# Output: 1. R interpreter output approximated p-value; 2. Rplot.pdf in `Code` subdirectory
# Arguments: 0
# Date: Oct 2019

## data load
load("../Data/KeyWestAnnualMeanTemperature.RData")

## libraries
library(ggplot2)

## ini plot
ggplot()+
  geom_smooth(aes(x=ats[,1],y=ats[,2]),method="lm")+
  geom_point(aes(x=ats[,1],y=ats[,2]))+
  xlab("year")+ylab("temperature.C")

## cor coef
# b<-unlist(cor(ats,method = "spearman"))[1,2]
# 
# ## cor coef (rand sample)
# dm<-1e4
# a<-rep(NA,dm);i<-1
# for(x in y<-sample((2:dim(ats)[1]),dm,replace = T)){
#   a[i]<-unlist(cor(ats[(1:x),],method = "spearman"))[1,2]
#   i<-i+1
#   };rm(x,i,dm)
# 
# ## approx p-val
# length(a[which(a>b)])/length(a)

######################################
#### follow Samraat's instruction ####
######################################

## ini T[y-1] vs T[y]
ats.0<-data.frame(ats[,2][1:dim(ats)[1]-1],ats[,2][2:dim(ats)[1]])
# colnames(ats.0)=c("T|y-1","T|y")
ggplot()+
  geom_smooth(aes(x=ats[,2][1:dim(ats)[1]-1],y=ats[,2][2:dim(ats)[1]]),method="lm")+
  geom_point(aes(x=ats[,2][1:dim(ats)[1]-1],y=ats[,2][2:dim(ats)[1]]))+
  xlab("temperature.C | t-1")+ylab("temperature.C | t")

## cor coef
b<-unlist(cor(ats.0,method = "spearman"))[1,2]

## cor coef (rand sample)
dm<-1e4
a<-rep(NA,dm)
i<-1;for(x in 1:dm){
  ats.0<-sample(ats[,2],dim(ats)[1],replace = F)
  ats.0<-data.frame(ats.0[1:length(ats.0)-1],ats.0[2:length(ats.0)])
  a[i]<-unlist(cor(ats.0,method = "spearman"))[1,2]
  i<-i+1
}
rm(x,i,dm)

## approx p-val
length(a[which(a>b)])/length(a)
