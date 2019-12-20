#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Log_4.R
# Desc: How do polynomial-restricted datasets look like
# Input: ```Rscript Log_4.R```
# Output: plot of polynomial-restricted raw data (.pdf)
# Arguments: 0
# Date: Nov 2019

## settings:
## a = raw data (data subset in slave scripts)
## a.~ = data.frames decending from raw data
## f.~ = functions
## v.~ = variables
## i~ = temporary variables

## library
cbp <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#0072B2", "#D55E00", "#CC79A7", "#e79f00", "#9ad0f3", "#F0E442", "#999999", "#cccccc", "#6633ff", "#00FFCC", "#0066cc")## colour-blind friendly palette

cat("plotting polynomial-restricted data\n")
## input
a<-read.table("../data/Log_Data.txt", header = T, sep = "\t", stringsAsFactors = F) ## raw data

a.u<-read.table("../data/Log_Uq.txt",sep="\t", header = T, stringsAsFactors = F) ## data identifier

a.ref<-read.table("../data/ttt_PCA.txt", sep = "\n", header = F, stringsAsFactors = F) ## data selector
a.ref<-as.character(a.ref[nrow(a.ref),])
a.ref<-gsub(",","",a.ref)
a.ref<-as.integer(read.table(text = a.ref, sep = " "))

## plot data selection
a.u<-a.u[a.ref,]
a.0<-as.data.frame(matrix(nrow = 0, ncol = ncol(a)+2))
for(i in 1:nrow(a.u)){
  i.0<-a[which(a$Temp.C==a.u$Temp.C[i] &
                 a$clade==a.u$clade[i] &
                 a$substrate==a.u$substrate[i] &
                 a$replicate==a.u$replicate[i] &
                 a$SourceRef==a.u$SourceRef[i] &
                 a$Popn_DataUnit==a.u$Popn_DataUnit[i]),]
  i.0$id<-as.numeric(rownames(a.u)[i])
  i.0$SymCol<-i
  a.0<-rbind(a.0,i.0)
};rm(i, i.0)

## plot data
pdf("../results/Log_outstanding.pdf", width = 15)
par(mar=c(5.1,4.1,1,12))
plot(log(a.0$Popn_Change)~a.0$Time.hr, xlab="Time (hr or mins)", ylab = "log Population Change", pch=20, col=cbp[a.0$SymCol], cex.axis=2, cex.lab=2)
for(i in 1:nrow(a.u)){
  i.0<-a.0[which(a.0$id==rownames(a.u)[i]),]
  lines(log(i.0$Popn_Change)~i.0$Time.hr, col=cbp[i.0$SymCol])
};rm(i, i.0)
par(xpd=NA, cex=1)
legend(x=max(a.0$Time.hr)*1.05, y = log(max(a.0$Popn_Change))*.9,
       legend = rownames(a.u), title = "Outstanding\nDatasets", fill = cbp[1:nrow(a.u)], bty = "n")
dev.off()

## table export as appendix vector string
v.0=c()
for(i in 1:nrow(a.u)){
  i.0<-paste(unname(a.u[i,]),collapse = "&")
  v.0<-paste0(v.0,row.names(a.u)[i],"&",i.0,"\\\\")
};rm(i, i.0)
write.table(v.0, "../data/ttt_appdx.txt", quote = F, col.names = F, row.names = F)
