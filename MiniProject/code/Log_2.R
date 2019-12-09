#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Log_0.R
# Desc: Raw data handling -- `LogisticGrowthMetaData.csv` and identify unique datasets
# Input: ```Rscript Log_0.R```
# Output: 1. cleaned data (.txt); 2. unique dataset tabular list (.txt)
# Arguments: 0
# Date: Nov 2019

## settings:
## a = raw data (data subset in slave scripts)
## a.~ = data.frames decending from raw data
## f.~ = functions
## v.~ = variables
## i~ = temporary variables

## library
library(PMCMR)

## input
a<-read.table("../data/Log_t1_para.txt", stringsAsFactors = F, header = T)
ref<-data.frame("num"=c("ve","go","ba","bu","qu","cu"),"nam"=c("Verhulst (classical)","modified Gompertz","Baranyi","Buchanan","quadratic","cubic"),stringsAsFactors = F)

a.md<-a[which(a[,2]=="Model"),-1] ## extract "best model" data

a.md<-as.data.frame(table(a.md))[,-1] ## count "best model" occurrences for each model
for(i in 1:dim(a.md)[1]){a.md[i,3]<-ref[which(a.md[i,1]==ref[,1]),2]};rm(i)
barplot(a.md[,2]~a.md[,3], ylab = "best-model occurrence", xlab = "Model") ## plot best model occurrence
kruskal.test(a.md[,2]~a.md[,3]) ## non-sig result of difference
