#!/bin/env Rscript

# Author: ph-u
# Script: Log_1_s1.R
# Desc: slave script on partial dataset get starting values
# Input: ```Rscript Log_1_s1.R <uq num>```
# Output: 1. cleaned data (.txt); 2. unique dataset tabular list (.txt)
# Arguments: 1
# Date: Nov 2019

## settings:
## a = raw data (data subset in slave scripts)
## a.~ = data.frames decending from raw data
## f.~ = functions
## v.~ = variables
## i~ = temporary variables

## library

## take command line order
args=(commandArgs(T))
v.0=as.numeric(args[1])

## data in
a<-read.table("../data/Log_Data.txt",sep="\t",header = T, stringsAsFactors = F)
a.u<-read.table("../data/Log_Uq.txt",sep="\t", header = T, stringsAsFactors = F)

## function

## grab subset
a.0<-a<-a[which(a$Temp.C==a.u$Temp.C[v.0] &
             a$clade==a.u$clade[v.0] &
             a$substrate==a.u$substrate[v.0] &
             a$replicate==a.u$replicate[v.0] &
             a$SourceRef==a.u$SourceRef[v.0] &
             a$Popn_DataUnit==a.u$Popn_DataUnit[v.0]),]
rm(a.u) ## finish using ref dataframe

a$Popn_Change[which(a$Popn_DataUnit=="OD_595")]<-a$Popn_Change[which(a$Popn_DataUnit=="OD_595")]*100 ## change to percentages when calculating

## parameters
v.1<-range(a$Popn_Change) ## N0, K (later included inside parameter table)

### screen for r.max
cat("start screening for max growth rate\n")
i.0<-0 ## token for screening from max end
v.r<-rep(0,3) ## r.max reference comparison
repeat{
  if(v.1[2]-v.1[1] < 1){break} ## eliminate weird data with negligible range
  i.1<-range(a.0$Time.hr)
  
  i.2<-try(lm(log(a.0$Popn_Change+1)~a.0$Time.hr),silent = T)
  if(class(i.2)!="try-error"){
    i.3<-c(unname(i.2$coefficients),summary(i.2)$adj.r.squared) ## y-int, slope, R^2
    if(isTRUE(i.3[3] > v.r[3]) & isTRUE(i.3[2] > v.r[2])){ ## test R^2 & r > intial best
      v.r<-i.3 ## replace intial fit by a better fit
      a.1<-a.0 ## replace initial best fit data with new one
    }
  }
  
  ## check whether data is depleted
  if(i.1[2]-i.1[1] < 5){ ## random x-axis range estimate
    if(i.0 < 1){ ## check token
      a.0<-a.1 ## update replace best fit subset for trimming lm iterations
      i.0<-1 ## update token but not trimming this time
    }else{
      rm(list=ls(pattern="i.")) ## recycle RAM
      rm(list=ls(pattern="a.")) ## recycle RAM
      break
    }
  }
  
  ## trim data if not depleted
  if(isTRUE(i.0 < 1)){ ## confirm token
    a.0<-a.0[which(a.0$Time.hr < max(a.0$Time.hr,na.rm = T)*(1-.05)),]
  }else if(isTRUE(i.0 > 1)){ ## confirm token
    a.0<-a.0[which(a.0$Time.hr > min(a.0$Time.hr,na.rm = T)*(1+.05)),]
  }else{i.0<-2}
}

## parameters
v.1<-data.frame("para"=c("N0", "K", "r.max", "t.lag", "t.K"),
                "val"=c(v.1, v.r[2], -v.r[1]/v.r[2], (max(log(a$Popn_Change+1))-v.r[1])/v.r[2]))
rm(v.r) ## recycle RAM
a$cst<-ifelse(a$Time.hr < v.1[4,2],1,ifelse(a$Time.hr > v.1[5,2],3,2)) ## set estimated cluster of lag, log, stationary phases
v.1$val<-ifelse(!is.na(v.1$val),v.1$val,0)

a$Popn_Change[which(a$Popn_DataUnit=="OD_595")]<-a$Popn_Change[which(a$Popn_DataUnit=="OD_595")]/100 ## change back data to intial values

# if(diff(range(a$Time.hr))>60*5){a$Time.hr/60} ## unify time unit

## write intermediate data
cat("start writing intermediate data\n")
write.table(v.1,paste0("../data/Log_",v.0,"_para.txt"), sep = "\t", quote = F, row.names = F)
write.table(a,paste0("../data/Log_",v.0,"_data.txt"), sep = "\t", quote = F, row.names = F)
