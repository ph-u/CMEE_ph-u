#!/bin/env Rscript

# Author: ph-u
# Script: AllometricTraitsScaling.R
# Desc: classwork for Allometric Traits section
# Input: Rscript AllometricTraitsScaling.R
# Output: R terminal output
# Arguments: 0
# Date: Nov 2019

library(repr)
#options(repr.plot.width = 4, repr.plot.height = 4) ## change plot sizes (in cm) in Jupyter notebook
library(minpack.lm)
powMod<-function(x, a, b){
  return(a*x^b)
}
MyData<-read.csv("../Data/GenomeSize.csv")
head(MyData)
Data2Fit<-MyData[which(MyData$Suborder=="Anisoptera" & !is.na(MyData$TotalLength)),]
Data2Fit<-MyData[which(MyData$Suborder=="Zygoptera" & !is.na(MyData$TotalLength)),]

plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)
library(ggplot2)
ggplot(Data2Fit,aes(x=Data2Fit$TotalLength, y=Data2Fit$BodyWeight))+geom_point(size=(3), colour="red")+theme_bw()+labs(y="Body mass (mg)", x="Wing length (mm)")

PowFit<-nlsLM(Data2Fit$BodyWeight~powMod(Data2Fit$TotalLength, a, b), data = Data2Fit, start = list(a=.01, b=.01)) ## {Ani: a=.1, b=.1}, {Dy: a=.01, b=.01}
summary(PowFit)

Lengths<-seq(min(Data2Fit$TotalLength), max(Data2Fit$TotalLength), len=200)
coef(PowFit)["a"]
coef(PowFit)["b"]
Predic2PlotPow<-powMod(Lengths, coef(PowFit)["a"], coef(PowFit)["b"])
plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)
lines(Lengths, Predic2PlotPow, col="blue", lwd=2.5)
confint(PowFit)

## exercise
ggplot()+geom_point(aes(x=Data2Fit$TotalLength, y=Data2Fit$BodyWeight))+geom_smooth(aes(x=Lengths, y=Predic2PlotPow), se=F)+geom_text(aes(label="Weight = 3.94*10^-6 * Length^2.59",x=30,y=.02)) ## (a)
a<-lm(log(Data2Fit$BodyWeight)~log(Data2Fit$TotalLength))
unname(exp(coef(a)[1]))-unname(coef(PowFit)[1])
unname(coef(a)[2])-unname(coef(PowFit)[2])

## num of rows not matching, not working
QuaFit<-lm(Data2Fit$BodyWeight~poly(Data2Fit$TotalLength,degree = 2))
# Predic2PlotQua<-predict.lm(QuaFit, data.frame(TotalLength=Lengths)) ## https://stackoverflow.com/questions/27464893/getting-warning-newdata-had-1-row-but-variables-found-have-32-rows-on-pred

plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)
lines(Lengths, Predic2PlotPow, col="blue", lwd=2.5)
# lines(Lengths, Predic2PlotQua, col="red", lwd=2.5)

RSS_Pow<-sum(residuals(PowFit)^2) ## residual sum of sq
TSS_Pow<-sum((Data2Fit$BodyWeight-mean(Data2Fit$BodyWeight))^2) ## total sum of sq
RSq_Pow<-1-(RSS_Pow/TSS_Pow) ## R^2

RSS_Qua<-sum(residuals(QuaFit)^2) ## res sum of sq
TSS_Qua<-sum((Data2Fit$BodyWeight-mean(Data2Fit$BodyWeight))^2) ## total sum of sq
RSq_Qua<-1-(RSS_Qua/TSS_Qua) ## R^2
RSq_Pow;RSq_Qua

## model selection
n<-nrow(Data2Fit) ## set sample size
pPow<-length(coef(PowFit)) ## get number of parameters in power law model
pQua<-length(coef(QuaFit)) ## get number of parameters in quadratic model

AIC_Pow<-n+2 +n*log(2*pi/n) +n*log(RSS_Pow) +2*pPow
AIC_Qua<-n+2 +n*log(2*pi/n) +n*log(RSS_Qua) +2*pQua
AIC_Pow-AIC_Qua
AIC(PowFit)-AIC(QuaFit) ## lm vs lm

## exercise
BIC(PowFit)-BIC(QuaFit)
{i<--.0224;m<-.001 ## test for best abline: {Anisoptera: i<--.185;m<-.006}; {Zygoptera: i<--.0224;m<-.001}
  plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)
  lines(Lengths, Predic2PlotPow, col="blue", lwd=2.5)
  abline(i,m, col="hotpink")
  text(paste0("straight line\nintercept: ",i,"\nslope: ",m),x=35,y=.025, col="hotpink")
  
  a<-ifelse(Data2Fit$BodyWeight<m*Data2Fit$TotalLength+i,0,1)
  sum(a)
}
