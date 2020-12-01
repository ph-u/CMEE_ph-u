#!/bin/env Rscript

# Author: ph-u
# Script: StatsWithSparrows15.R
# Desc: minimal R function with two in-script tests
# Input: none -- run in R console line-by-line
# Output: R terminal output
# Arguments: 0
# Date: Oct 2019

a<-read.delim("../Data/daphnia.txt")
summary(a)

par(mfrow=c(1,2))
plot(a$Growth.rate~a$Detergent)
plot(a$Growth.rate~a$Daphnia)

library(dplyr)
a%>%group_by(Detergent)%>%summarise(variance=var(Growth.rate))
a%>%group_by(Daphnia)%>%summarise(variance=var(Growth.rate))
par(mfrow=c(1,1));hist(a$Growth.rate)

seFun<-function(x){
  sqrt(var(x)/length(x))
}

detMean<-with(a,tapply(a$Growth.rate,INDEX = a$Detergent,FUN = mean))
detSEM<-with(a,tapply(a$Growth.rate,INDEX = a$Detergent,FUN = seFun))
cloneMean<-with(a,tapply(a$Growth.rate,INDEX = a$Daphnia,FUN = mean))
cloneSEM<-with(a,tapply(a$Growth.rate,INDEX = a$Daphnia,FUN = seFun))

par(mfrow=c(2,1),mar=c(4,4,1,1))
barMids<-barplot(detMean, xlab = "Detergent type", ylab = "Population growth rate", ylim = c(0,5));arrows(barMids,detMean-detSEM, barMids, detMean + detSEM, code = 3, angle = 90)
barMids<-barplot(cloneMean, xlab = "Daphnia clone", ylab = "Population growth rate", ylim = c(0,5));arrows(barMids,cloneMean-cloneSEM, barMids, cloneMean + cloneSEM, code = 3, angle = 90)

dapLM<-lm(a$Growth.rate~a$Daphnia+a$Detergent)
anova(dapLM)
summary(dapLM)
detMean-detMean[1]
cloneMean-cloneMean[1]
dapAOV<-aov(a$Growth.rate~a$Daphnia+a$Daphnia)
summary(dapAOV)
dapHSD<-TukeyHSD(dapAOV);dapHSD
par(mfrow=c(2,2));plot(dapLM)
t<-read.delim("../Data/timber.txt");summary(t)
par(mfrow=c(2,2));boxplot(t$volume);boxplot(t$girth);boxplot(t$height)
for(i in 1:dim(t)[2]){
  print(paste(colnames(t)[i],":",var(t[,i])))
}

t2<-as.data.frame(subset(t,!is.na(t$volume)))
t2$z.girth<-scale(t$girth)
t2$z.height<-scale(t$height)
var(t2$z.girth)
var(t2$z.height)
plot(t2)
par(mfrow=c(2,2));hist(t2$volume);hist(t2$girth);hist(t2$height)

pairs(t)
cor(t)
summary(lm(t$girth~t$height))
VIF<-1/(1-.27);VIF
sqrt(VIF)
pairs(t)
cor(t)
pairs(t2)

tMod<-lm(t$volume~t$girth+t$height)
anova(tMod)
summary(tMod)
plot(tMod)

pGrowth<-read.delim("../Data/ipomopsis.txt")
summary(pGrowth)
