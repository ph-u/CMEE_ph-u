#!/bin/env Rscript

# Author: ph-u
# Script: StatsWithSparrows1.R
# Desc: minimal R function with two in-script tests
# Input: none -- run in R console line-by-line
# Output: R terminal output
# Arguments: 0
# Date: Oct 2019

2*2+1
2*(2+1)
12/2^3
(12/2)^3
x<-5
y<-2
x2<-x^2
a<-x2+x
y2<-y^2
z2<-x2+y2
z<-sqrt(z2)
3>2
3>=3
4<2
myNumericVector<-c(1.3,2.5,1.9,3.4,5.6,1.4,3.1,2.9)
myCharacterVector<-c(rep("low",4),rep("high",4))
myLogicalVector<-c(rep(c(rep(T,2),rep(F,2)),2))
myMixedVector<-c(1,T,F,3,"help",1.2,T,"notwhatIplanned")
sqrt(4);4^.5;log(0);log(1);log(10);log(Inf)

oo<-read.table("../Data/SparrowSize.txt", sep = "\t", header = T)
str(oo)
