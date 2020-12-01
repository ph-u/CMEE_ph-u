#!/bin/env Rscript

# Author: ph-u
# Script: AedesAdgyptiFecundity.R
# Desc: classwork for Fecundity section
# Input: Rscript AedesAdgyptiFecundity.R
# Output: R terminal output
# Arguments: 0
# Date: Nov 2019

library(ggplot2)
library(minpack.lm)

aedes<-read.csv("../Data/aedes_fecund.csv")
par(mfrow=c(1,1))
plot(aedes$T, aedes$EFD, xlab = "temperature (C)", ylab = "Eggs/day")
quad1<-function(T, T0, Tm, c){
  c*(T-T0)*(T-Tm)*as.numeric(T<Tm)*as.numeric(T>T0)
}
briere<-function(T, T0, Tm, c){
  c*T*(T-T0)*(abs(Tm-T)^.5)*as.numeric(T<Tm)*as.numeric(T>T0)
}

scale<-20
aed.lin<-lm(aedes$EFD/scale~aedes$T)
aed.quad<-nlsLM(aedes$EFD/scale~quad1(T, T0, Tm, c), start = list(T0=10, Tm=40, c=.01), data = aedes)
aed.br<-nlsLM(aedes$EFD/scale~briere(T, T0, Tm, c), start = list(T0=10, Tm=40, c=.01), data = aedes)

j<-list(aed.lin, aed.quad, aed.br);for(i in 1:3){
  k<-(i+1)%%3
  if(k==0){k<-3}
  print(paste(i,"vs",k))
  p<-round(AIC(j[[i]])-AIC(j[[k]]),2)
  if(p<0){o<-paste(k,"better")}else if(p==0){o<-"equal"}else{o<-paste(i,"better")}
  print(paste("AIC:",p,";",o))
  p<-round(BIC(j[[i]])-BIC(j[[k]]),2)
  if(p<0){o<-paste(k,"better")}else if(p==0){o<-"equal"}else{o<-paste(i,"better")}
  print(paste("BIC:",p,";",o))
};rm(i,j,k,p)
AIC(aed.br)/AIC(aed.lin)
AIC(aed.br)/AIC(aed.quad)

## ggplot
ggplot()+theme_bw()+geom_point(aes(y=aedes$EFD, x=aedes$T))
