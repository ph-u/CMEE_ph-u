#!/bin/env Rscript

# Author: ph-u
# Script: Log_5.R
# Desc: biological questions - do species correlate with model / parameter range?
# Input: ```Rscript Log_5.R```
# Output: statistical analysis report (.txt)
# Arguments: 0
# Date: Jan 2020

## settings:
## a = raw data (data subset in slave scripts)
## a.~ = data.frames decending from raw data
## f.~ = functions
## v.~ = variables
## i~ = temporary variables

## library
library(PMCMR)
source("Log_func.R")

## data in
a.u<-read.table("../data/Log_Uq.txt", sep = "\t", header = T, stringsAsFactors = F) # uniq models
a.p<-read.table("../data/Log_t1_data.txt", sep = "\t", header = F, stringsAsFactors = F) # models with min+2 AIC
colnames(a.p)=c("model", "dataset", "AIC", "N0_(pms_only)", "K_(pms_only)", "rmax_(pms_only)", "tlag_(pms_only)")

## fuse sp names & media data with model
a.0<-a.p[which(!is.na(a.p[,4])),]
a.0$media<-a.0$species<-a.0$temp<-NA # R read from right to left

for(i in 1:nrow(a.0)){
  a.0[i,((ncol(a.p)+1):ncol(a.0))]<-a.u[which(rownames(a.u)==a.0[i,2]),1:3]
};rm(i, a.p)

v.f<-kruskal.test(a.u$clade~a.u$substrate) # p-val sig = can't differentiate effect of both
v.0<-kruskal.test(a.0$model~interaction(a.0$species,a.0$media)) # p-val non-sig = model is not relating with combined effect of species and gel media

## test whether parameter range related to species
a.1<-a.0[which(a.0$model!="quadratic" & a.0$model!="cubic"),]
v.1<-c()
for(i in 4:7){
  i.0<-kruskal.test(a.1[,i]~interaction(a.1$species,a.1$media))
  v.1<-c(v.1,unname(i.0$statistic),unname(i.0$parameter),i.0$p.value)
};rm(i,i.0)

## kruskal.test number results collection
v.1<-round(c(unname(v.f$statistic),unname(v.f$parameter),v.f$p.value,unname(v.0$statistic),unname(v.0$parameter),v.0$p.value,v.1),2)

## posthoc test due to Kruskal significance on parameter factors
lL<-length(unique(paste0(a.1$species,a.1$media)))
# v.N0<-phoc.kruskal.nemenyi(a.1[,4],a.1$species,a.1$media,.05) # no sig pairs
# v.KK<-phoc.kruskal.nemenyi(a.1[,5],a.1$species,a.1$media,.05) # no sig pairs
# v.rx<-phoc.kruskal.nemenyi(a.1[,6],a.1$species,a.1$media,.05) # no sig pairs
# v.tl<-phoc.kruskal.nemenyi(a.1[,7],a.1$species,a.1$media,.05) # no sig pairs
v.1<-c(v.1,lL)

## export numbers
write.table(v.1,"../data/ttt_bio.txt", quote = F, col.names = F, row.names = F)
