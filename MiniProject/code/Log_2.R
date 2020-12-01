#!/bin/env Rscript

# Author: ph-u
# Script: Log_2.R
# Desc: Is one or more model(s) stand out from the rest?
# Input: ```Rscript Log_2.R```
# Output: 1. useful numbers for report (.txt); 2. barplot (.pdf)
# Arguments: 0
# Date: Nov 2019

## settings:
## a = raw data (data subset in slave scripts)
## a.~ = data.frames decending from raw data
## f.~ = functions
## v.~ = variables
## i~ = temporary variables

## library

cat("Statistical analysis on 'best' model collection\n")
## input
a<-read.table("../data/Log_t1_data.txt", stringsAsFactors = F, header = F)
a<-a[which(!is.na(a[,3])),1:2]
a[,3]<-substr(tolower(a[,1]),1,2)
for(i in 1:dim(a)[1]){if(a[i,3]=="mo"){a[i,3]<-"go"}};rm(i) ## synchronize model abbreviation
# a<-read.table("../data/Log_t1_para.txt", stringsAsFactors = F, header = T)
ref<-data.frame("num"=c("ve","go","ba","bu","qu","cu"),"nam"=c("Verhulst (classical)","modified Gompertz","Baranyi","Buchanan","quadratic","cubic"),stringsAsFactors = F)

a.md<-as.data.frame(table(a[,3]))
# a.md<-a[which(a[,2]=="Model"),-1] ## extract "best model" data
# a.md<-as.data.frame(table(a.md))[,-1] ## count "best model" occurrences for each model

ref[,3]<-0 ## pre-allocate for plotting
for(i in 1:dim(ref)[1]){ ## run through ref table
  if(isTRUE(any(a.md[,1]==ref[i,1]))){ ## fill the table if match token
    ref[i,3]<-a.md[which(ref[i,1]==a.md[,1]),2]
  }
};rm(i)
kt<-kruskal.test(ref[,3]~ref[,2]) ## non-sig result of difference

pdf("../results/barplot_BestModel.pdf", width = 10)
barplot(ref[,3]~ref[,2], ylab = paste0("best-model occurrence, each bar max at ",max(a[,2])), xlab = "Model", ylim=c(0,max(ref[,3])*1.2), cex.lab=1.5, cex.axis=1.5)  ## plot best model occurrence
#text(x=dim(ref)[1]/2,y=max(a.md[,2])*.8, labels = paste0("Kruskal-Wallis Test\nX^2 = ",kt$statistic,"\ndf = ",kt$parameter,"\np-val = ",round(kt$p.value,2)))
dev.off()

AnB<-length(unique(a[which(a[,3]=="ve"),2]))+length(unique(a[which(a[,3]=="cu"),2]))-length(unique(a[which(a[,3]=="ve"|a[,3]=="cu"),2])) ## P(AnB) =  P(A) + P(B) - P(AUB)
CnD<-length(unique(a[which(a[,3]=="ba"),2]))+length(unique(a[which(a[,3]=="qu"),2]))-length(unique(a[which(a[,3]=="ba"|a[,3]=="qu"),2])) ## same as above

## write table for report
write.table(c(kt$method, ## kruskal.test name
              kt$statistic, ## X^2 from kruskal.test
              kt$parameter, ## df from kruskal.test
              round(kt$p.value,2), ## p-val from kruskal.test
              sum(duplicated(a[,2])), ## number of datasets with >1 "best-fit"
              max(a[,2]), ## total number of datasets
              ref[which(ref[,1]=="ve"),3], ## number of datasets called ve "best"
              ref[which(ref[,1]=="cu"),3], ## number of datasets called cu "best"
              AnB,
              ref[which(ref[,1]=="ba"),3], ## number of datasets called ba "best"
              ref[which(ref[,1]=="qu"),3], ## number of datasets called qu "best"
              CnD,
              ref[which(ref[,1]=="go"),3]
              ),file = "../data/ttt_stat.txt", quote = F, col.names = F, row.names = F)
