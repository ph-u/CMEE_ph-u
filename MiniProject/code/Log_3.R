#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Log_3.R
# Desc: Do any parameters facours any phenological model(s)?
# Input: ```Rscript Log_3.R```
# Output: 1. useful numbers for report (.txt); 2. clusterplot (.pdf)
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

## input
a<-read.table("../data/Log_t1_data.txt", stringsAsFactors = F, header = F)
a<-a[which(!is.na(a[,2])),]
a[,dim(a)[2]+1]<-substr(tolower(a[,1]),1,2)
for(i in 1:dim(a)[1]){if(a[i,dim(a)[2]]=="mo"){a[i,dim(a)[2]]<-"go"}};rm(i) ## synchronize model abbreviation

a.pm<-a[which(a[,dim(a)[2]]!="cu"&a[,dim(a)[2]]!="qu"),] ## select for phenological models only
colnames(a.pm)=c("model", "dataset", "AIC", "N0", "K", "r.max", "t.lag", "abbr") ## rename df cols to more human-friendly

## PCA analysis on parameters
a.pca<-prcomp(log(a.pm[,4:7]), scale = T) ## PCA on dataframe of parameters
a.pcS<-summary(a.pca)

## PCA biplot and associated appearance modifications
pdf("../results/Log_PCA.pdf")
## <https://www.benjaminbell.co.uk/2018/02/principal-components-analysis-pca-in-r.html>
# screeplot(a.pca,type = "l")
a.pm$symbol<-ifelse(a.pm$abbr=="ve",1,ifelse(a.pm$abbr=="go",2,ifelse(a.pm$abbr=="ba",3,4))) ## set biplot symbol type
a.pm$colour<-ifelse(a.pm$abbr=="ve",cbp[1],ifelse(a.pm$abbr=="go",cbp[2],ifelse(a.pm$abbr=="ba",cbp[3],cbp[6]))) ## set biplot colour types
plot(a.pca$x[,2]~a.pca$x[,1],
     xlab=paste0("PC1 (",round(a.pcS$importance[2],2)*100,"%)"),
     ylab=paste0("PC2 (",round(a.pcS$importance[5],2)*100,"%)"),
     pch=a.pm$symbol, col=a.pm$colour)
abline(v=0,lty=2, col="grey50") ## add vert ref
abline(h=0,lty=2, col="grey50") ## add hori ref

a.pcL<-a.pca$rotation[,1:2]*2 ## magnify arrow size

arrows(x0 = 0, x1 = a.pcL[,1], y0 = 0, y1 = a.pcL[,2], col = "grey30", length = .15)

a.pcT<-ifelse(a.pcL[,2]<0,1,3) ## label position
text(x=a.pcL[,1], y=a.pcL[,2], labels = row.names(a.pca$rotation), col = "grey30", pos = a.pcT) ## plot labels

legend("topleft", legend = c("Verhulst (classical)", "modified Gompertz", "Baranyi", "Buchanan"), title = "Phenological Models", pch = 1:4, col = cbp[c(1:3,6)], pt.cex = 1.5)

dev.off()

## data export for report
