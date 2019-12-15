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

ref[,3]<-0 ## pre-allocate for plotting
for(i in 1:dim(ref)[1]){ ## run through ref table
  if(isTRUE(any(a.md[,1]==ref[i,1]))){ ## fill the table if match token
    ref[i,3]<-a.md[which(ref[i,1]==a.md[,1]),2]
  }
};rm(i)

pdf("../results/barplot_BestModel.pdf", width = 10)
barplot(ref[,3]~ref[,2], ylab = "best-model occurrence", xlab = "Model", ylim=c(0,max(ref[,3])*1.2))  ## plot best model occurrence
kt<-kruskal.test(ref[,3]~ref[,2]) ## non-sig result of difference
text(x=dim(ref)[1]/2,y=max(a.md[,2])*.8, labels = paste0("Kruskal-Wallis Test\nX^2 = ",kt$statistic,"\ndf = ",kt$parameter,"\np-val = ",round(kt$p.value,2)))
dev.off()

## calculate percents of identify as best model
perc_poly<-round((ref[which(ref[,1]=="qu"),3]+ref[which(ref[,1]=="cu"),3])/sum(ref[,3]),3)

## write table for report
write.table(c(kt$method,
              kt$statistic,
              kt$parameter,
              round(kt$p.value,2),
              perc_poly*100,
              (1-perc_poly)*100,
              sum(ref[,3])
              ),file = "../data/ttt_stat.txt", quote = F, col.names = F, row.names = F)
