#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: StatsWithSparrows2.R
# Desc: minimal R function with two in-script tests
# Input: none -- run in R console line-by-line
# Output: R terminal output
# Arguments: 0
# Date: Oct 2019

oo<-read.table("../Data/SparrowSize.txt", sep = "\t", header = T)
str(oo)
names(oo)
head(oo)
length(oo$Tarsus)
hist(oo$Tarsus)
mean(oo$Tarsus, na.rm=T)
median(oo$Tarsus, na.rm = T)
mode(oo$Tarsus)
a<-as.data.frame(table(oo$Tarsus))
a[,1]<-as.numeric(as.character(a[,1]))
a[which(a[,2]==max(a[,2])),]

mode<-function(NumericCol){
  ## input numeric column
  ## output mode of the column and frequency
  a<-as.data.frame(table(NumericCol))
  a[,1]<-as.numeric(as.character(a[,1]))
  return(a[which(a[,2]==max(a[,2])),])
}
## variance equation
## hedging for imprecision: df=n-1
## square of data --> give more weight for outliers to separate from the rest
######################

par(mfrow=c(2,2))
hist(oo$Tarsus, breaks = 3, col = "grey")
hist(oo$Tarsus, breaks = 10, col = "grey")
hist(oo$Tarsus, breaks = 30, col = "grey")
hist(oo$Tarsus, breaks = 100, col = "grey")

## lec hw
var(oo$Bill, na.rm = T)
sqrt(var(oo$Bill, na.rm = T))
mean(oo$Bill, na.rm = T)

var(oo$Mass, na.rm = T)
sqrt(var(oo$Mass, na.rm = T))
mean(oo$Mass, na.rm = T)

var(oo$Wing, na.rm = T)
sqrt(var(oo$Wing, na.rm = T))
mean(oo$Wing, na.rm = T)

## standardize data column <https://stackoverflow.com/questions/15215457/standardize-data-columns-in-r>

o.0<-subset(oo,is.na(oo$Tarsus)!=T)
length(oo$Tarsus)
library(lme4)
## mlv(o.0$Tarsus)
mean(oo$Tarsus, na.rm=T)
median(oo$Tarsus, na.rm = T)
range(oo$Tarsus, na.rm = T)
range(o.0$Tarsus)
var(oo$Tarsus, na.rm = T)
var(o.0$Tarsus)
sum((o.0$Tarsus-mean(o.0$Tarsus))^2/(length(o.0$Tarsus)-1))
sqrt(var(o.0$Tarsus))
sqrt(0.74)
sd(o.0$Tarsus)
zTarsus<-(o.0$Tarsus-mean(o.0$Tarsus))/sd(o.0$Tarsus)
var(zTarsus)
sd(zTarsus)
par(mfrow=c(1,1))
hist(zTarsus)
set.seed(123)
znormal<-rnorm(1e6)
hist(znormal, breaks = 100)
summary(znormal)
qnorm(c(.025, .975))
pnorm(.Last.value)
par(mfrow=c(1,2))
hist(znormal, breaks = 100)
abline(v=qnorm(c(.25,.5,.75)), lwd=2)
abline(v=qnorm(c(.025, .975)), lty="dotted", col="black")
plot(density(znormal))
abline(h=0, lwd=3, col="blue")
text(2,.3,"1.96",col = "red",adj = 0)
text(-2,.3,"-1.96",col = "red",adj = 1)

boxplot(oo$Tarsus~oo$Sex.1, col=c("red","blue"), ylab = "Tarsus length (mm)")
