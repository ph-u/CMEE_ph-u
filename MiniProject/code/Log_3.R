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

cat("PCA analysis on model parameters\n")
## input
a<-read.table("../data/Log_t1_daFa.txt", stringsAsFactors = F, header = F)
a<-a[which(!is.na(a[,2])),]
a[,dim(a)[2]+1]<-substr(tolower(a[,1]),1,2)
for(i in 1:dim(a)[1]){if(a[i,dim(a)[2]]=="mo"){a[i,dim(a)[2]]<-"go"}};rm(i) ## synchronize model abbreviation

a.pm<-a[which(a[,dim(a)[2]]!="cu"&a[,dim(a)[2]]!="qu"),] ## select for phenological models only
colnames(a.pm)=c("model", "dataset", "AIC", "N0", "K", "r.max", "t.lag", "abbr") ## rename df cols to more human-friendly

## PCA analysis on parameters
a.pca<-prcomp(log(a.pm[,4:7]), scale = T) ## PCA on dataframe of parameters
a.pcS<-summary(a.pca)

## PCA biplot and associated appearance modifications
pdf("../results/Log_PCA.pdf", width = 15)
par(mar=c(5.1,4.1,1,12))

## <https://www.benjaminbell.co.uk/2018/02/principal-components-analysis-pca-in-r.html>
# screeplot(a.pca,type = "l")
a.pm$symbol<-ifelse(a.pm$abbr=="ve",20,ifelse(a.pm$abbr=="go",2,ifelse(a.pm$abbr=="ba",3,4))) ## set biplot symbol type
a.pm$colour<-ifelse(a.pm$abbr=="ve",cbp[10],ifelse(a.pm$abbr=="go",cbp[2],ifelse(a.pm$abbr=="ba",cbp[3],cbp[4]))) ## set biplot colour types
plot(a.pca$x[,2]~a.pca$x[,1],
     xlab=paste0("PC1 (",round(a.pcS$importance[2],2)*100,"%)"),
     ylab=paste0("PC2 (",round(a.pcS$importance[5],2)*100,"%)"),
     pch=a.pm$symbol, col=a.pm$colour)
abline(v=0,lty=2, col="grey50") ## add vert ref
abline(h=0,lty=2, col="grey50") ## add hori ref

a.pcL<-a.pca$rotation[,1:2] ## magnify arrow size (risky)

arrows(x0 = 0, x1 = a.pcL[,1], y0 = 0, y1 = a.pcL[,2], col = cbp[1], length = .15)

a.pcT<-ifelse(a.pcL[,2]<0,1,3) ## label position
text(x=a.pcL[,1], y=a.pcL[,2], labels = row.names(a.pca$rotation), col = cbp[1], pos = a.pcT) ## plot labels

par(xpd=NA, cex=1)
## legend pos <https://stackoverflow.com/questions/3932038/plot-a-legend-outside-of-the-plotting-area-in-base-graphics>
## legend font size <https://stackoverflow.com/questions/36842119/change-font-size-in-legend/36842578>
legend(x=4.1, y=2, legend = c("Verhulst (classical)", "modified Gompertz", "Baranyi", "Buchanan"), title = "Phenological Models", pch = c(20,2:4), col = cbp[c(10,2:4)], pt.cex = 1.5, bty = "n") ## no legend frame <https://stackoverflow.com/questions/10108073/plot-legends-without-border-and-with-white-background>

dev.off()

## data export for report
a.expt<-c(round(a.pcS$importance[2],2)*100, ## % of PC1
          round(a.pca$rotation[,1],2), ## PC1 parameters [vec of 4]
          round(a.pcS$importance[5],2)*100, ## % of PC2
          round(a.pca$rotation[,2],2), ## PC2 parameters [vec of 4]
          length(unique(a[,2])), ## num of datasets included
          paste(setdiff(seq(56),unique(a[,2])), collapse = ", ") ## which datasets not applicable
          )
# a.expt<-round(c(a.pca$rotation[,1:2]),2)
write.table(a.expt, "../data/ttt_PCA.txt", quote = F, col.names = F, row.names = F)
