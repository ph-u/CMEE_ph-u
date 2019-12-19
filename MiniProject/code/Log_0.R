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

## data in
a<-read.csv("../data/LogisticGrowthData.csv", header = T, stringsAsFactors = F)[,-1] ## read raw, rm random column

## save citations for report
ctt<-paste0(unique(a$Citation),"\\\\")

## data cleaning
a$Citation<-as.numeric(as.factor(gsub(" |\t","",a$Citation))) ## remove possible mess by citation textstrings
a<-a[,c(3,6:9,1,2,5)] ## reorganize useful raw
colnames(a)=c("Temp.C","clade","substrate","replicate","SourceRef","Time.hr","Popn_Change","Popn_DataUnit") ## rename to easy-recognize colnames
a$Time.hr<-abs(a$Time.hr) ## convert -ve times
a$clade<-gsub(".1|.2|..RDA.R.","",a$clade) ## condense spp names
a$clade<-gsub("spp.|sp.","sp",a$clade) ## condense spp names
a$clade<-gsub("[.]"," ",a$clade) ## condense spp names
a$clade<-gsub("77|88|Strain 97|StrainCYA28|subsp Carotovorum Pc","",a$clade) ## rm specific unnecessary things for better spp categorizing
a$clade<-trimws(a$clade) ## condense spp names (rm white spaces from both ends)
a$Popn_Change<-ifelse(a$Popn_Change<0,0,a$Popn_Change) ## assume impossible to drop population below technical 0

## get unique datasets
a.0<-as.data.frame(matrix(nrow=0, ncol=(dim(a)[2]-2))) ## start data frame of record
cat("unique datasets scanned ")
i.0<-0;for(i in 1:dim(a)[1]){
  if(i%%1000==1){cat(paste0(round(i/dim(a)[1]*100),"%; "))}
  
  if(i.0==0){ ## check token of update criteria-set namespaces
    for(i.1 in 1:6){
      assign(paste0("v.",i.1),unique(a.0[,i.1])) ## fix / update criteria-set namespaces
    };rm(i.1)
    i.0<-1 ## take away token to rerun update namespace
  }
  
  if(!(a[i,1] %in% v.1 & a[i,2] %in% v.2 & a[i,3] %in% v.3 & a[i,4] %in% v.4 & a[i,5] %in% v.5 & a[i,8] %in% v.6)){ ## filter for unique dataset combinations by criteria-sets
    a.0<-rbind(a.0,a[i,-c(6:7)]) ## add data attributes in recording data.frame
    i.0<-0 ## give token to update criteria namespaces
  }
  
}
cat("100%\n")
rm(list=ls(pattern="v."));rm(list=ls(pattern="i"))

## cleaned data and data library export
write.table(a, "../data/Log_Data.txt",sep="\t", quote=F, row.names = F)
write.table(a.0, "../data/Log_Uq.txt",sep="\t", quote=F, row.names = F)
write.table(ctt,"../data/ttt_cite.txt", sep = "&", quote = F, col.names = F)
cat("data cleaning and export done\n")