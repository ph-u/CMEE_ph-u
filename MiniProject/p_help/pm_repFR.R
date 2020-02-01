#!/bin/env Rscript

# Author 	: PokMan Ho (pok.ho19@imperial.ac.uk)
# Script 	: pm_repFR.R
# Desc 		: replicate modelling of Functional Response data from Emma's and Viki's script
# Input 	: `Rscript pm_repFR.R`
# Output 	: none
# Argument 	: 0
# Date 		: Jan 2020

### start of py script R translation

data<-read.csv("../data/CRat.csv")
newdata<-as.data.frame(cbind(data$ID,data$ResDensity,data$N_TraitValue))
colnames(newdata)=c("ID", "ResDensity", "N_TraitValue")
newdata2<-newdata[which(!is.na(newdata$ID)),]
threshold<-as.data.frame(table(newdata2$ID))
threshold<-as.numeric(as.character(threshold[which(threshold[,2]>=5),1]))
newdata2<-newdata2[which(newdata2$ID %in% threshold),]

rm(data, newdata, threshold)
newdata2<-newdata2[which(!is.na(newdata2[,2]) & !is.na(newdata2[,3])),]

### end of py script R translation

### start of R script

## lib
library(minpack.lm)

## func
f_Holl<-function(x, a, h){
  return( a*x/(1+h*a*x) )
}

f_gnMd<-function(x, a, h, q){
  return( a*x^(q+1) / (1+h*a*x^(q+1)) )
}

uqid<-unique(newdata2$ID) # get uniq id data subsets

idNum=4
## starting values
test0<-newdata2[which(newdata2$ID==uqid[idNum]),] # get data subset
test<-as.data.frame(matrix(nrow = 100, ncol = 5)) # set trials
colnames(test)=c("a", "h", "q", "Hol_AIC", "Gen_AIC")
test$h<-abs(rnorm(nrow(test), max(test0$N_TraitValue), sd = .01)) # max value
## max slope
mxslp<-mxr2<-0
tmp0<-test0 # prep tmp0 for data elimination
for(i in 1:(nrow(test0)-2)){
  tmp<-summary(lm(tmp0$N_TraitValue~tmp0$ResDensity)) # linear model on remaining data points
  if(tmp$adj.r.squared>mxr2 & tmp$coefficients[2,2]>mxslp){ # save max slope only if it is better
    mxslp<-tmp$coefficients[2,2]
  }
};rm(i, tmp, tmp0, mxr2)
test$a<-abs(rnorm(nrow(test), mean = mxslp, sd = .1)) # sample max slope values
## q value
#test$q<-rnorm(nrow(test), mean = 0, sd = .1)
test$q<--1 # use this to replicate your script

## modelling
quaFit<-try(lm(log(test0$N_TraitValue) ~ poly(test0$ResDensity, 2)), silent=T) # quadratic linear model
if(class(quaFit)!="try-error"){quaFit<-AIC(quaFit)}
cubFit<-try(lm(log(test0$N_TraitValue) ~ poly(test0$ResDensity, 3)), silent=T) # cubic linear model
if(class(cubFit)!="try-error"){cubFit<-AIC(cubFit)}
for(i in 1:nrow(test)){
  holFit<-try(nlsLM(log(test0$N_TraitValue)~f_Holl(test0$ResDensity, a, h), data = test0, start = list(a=test$a[i], h=test$h[i])), silent = T) # Holling 2 model
  if(class(holFit)!="try-error"){test$Hol_AIC[i]<-AIC(holFit)}
  
  genFit<-try(nlsLM(log(test0$N_TraitValue)~f_gnMd(test0$ResDensity, a, h, q), data = test0, start = list(a=test$a[i], h=test$h[i], q=test$q[i])), silent = T) # generalized Holling 2 Model
  if(class(genFit)!="try-error"){test$Gen_AIC[i]<-AIC(genFit)}
};rm(i)
