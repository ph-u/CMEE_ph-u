#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Log_3.R
# Desc: Do any parameters favours any phenological model(s)?
# Input: ```Rscript Log_3.R```
# Output: 1. useful numbers for report (.txt); 2. cluster plot (.pdf)
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
cbp <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#0072B2", "#D55E00", "#CC79A7", "#e79f00", "#9ad0f3", "#F0E442", "#999999", "#cccccc", "#6633ff", "#00FFCC", "#0066cc")## colour-blind friendly palette

cat("PCA analysis on model parameters\n")
## input
a<-read.table("../data/Log_t1_daFa.txt", stringsAsFactors = F, header = F)
a<-a[which(!is.na(a[,2])),]
a[,dim(a)[2]+1]<-substr(tolower(a[,1]),1,2)
for(i in 1:dim(a)[1]){if(a[i,dim(a)[2]]=="mo"){a[i,dim(a)[2]]<-"go"}};rm(i) ## synchronize model abbreviation
colnames(a)=c("model","dataset","AIC","N0","K","r.max","t.lag","abbr")

a.pm<-a[which(a[,dim(a)[2]]!="cu"&a[,dim(a)[2]]!="qu"),] ## select for phenological models only
colnames(a.pm)=c("model", "dataset", "AIC", "N0", "K", "r.max", "t.lag", "abbr") ## rename df cols to more human-friendly

## PCA analysis on parameters
a.pca<-prcomp(log(a.pm[,4:7]), scale = T) ## PCA on dataframe of parameters
a.pcS<-summary(a.pca)

## PCA biplot and associated appearance modifications
pdf("../results/Log_PCA.pdf", width = 15)
par(mar=c(5.5,4.1,1,12))

## <https://www.benjaminbell.co.uk/2018/02/principal-components-analysis-pca-in-r.html>
# screeplot(a.pca,type = "l")
a.pm$symbol<-ifelse(a.pm$abbr=="ve",20,ifelse(a.pm$abbr=="go",2,ifelse(a.pm$abbr=="ba",3,4))) ## set biplot symbol type
a.pm$colour<-ifelse(a.pm$abbr=="ve",cbp[10],ifelse(a.pm$abbr=="go",cbp[2],ifelse(a.pm$abbr=="ba",cbp[3],cbp[4]))) ## set biplot colour types
plot(a.pca$x[,2]~a.pca$x[,1],
     xlab=paste0("PC1 (",round(a.pcS$importance[2],2)*100,"%)"),
     ylab=paste0("PC2 (",round(a.pcS$importance[5],2)*100,"%)"),
     pch=a.pm$symbol, col=a.pm$colour, cex.axis=2, cex.lab=2)
abline(v=0,lty=2, col="grey50") ## add vert ref
abline(h=0,lty=2, col="grey50") ## add hori ref

a.pcL<-a.pca$rotation[,1:2]*2 ## magnify arrow size (risky)

arrows(x0 = 0, x1 = a.pcL[,1], y0 = 0, y1 = a.pcL[,2], col = cbp[1], length = .15)

a.pcT<-ifelse(a.pcL[,2]<0,1,3) ## label position
text(x=a.pcL[,1], y=a.pcL[,2], labels = row.names(a.pca$rotation), col = cbp[1], pos = a.pcT, cex = 2) ## plot labels

par(xpd=NA, cex=1)
## legend pos <https://stackoverflow.com/questions/3932038/plot-a-legend-outside-of-the-plotting-area-in-base-graphics>
## legend font size <https://stackoverflow.com/questions/36842119/change-font-size-in-legend/36842578>
legend(x=4.1, y=2, legend = c("Verhulst (classical)", "modified Gompertz", "Baranyi", "Buchanan"), title = "Phenological Models", pch = c(20,2:4), col = cbp[c(10,2:4)], pt.cex = 1.5, bty = "n") ## no legend frame <https://stackoverflow.com/questions/10108073/plot-legends-without-border-and-with-white-background>

dev.off()

cat("kruskal-test per parameter\n")
## Kruskal.test on each parameter
a.ktRes<-as.data.frame(matrix(nrow = 4, ncol = 5))
a.kNRes<-as.data.frame(matrix(nrow = 0, ncol = 4))
for(i in 4:7){
  a.kt<-kruskal.test(log(a[,i])~a$abbr)
  a.ktRes[i-3,]<-c(colnames(a)[i],a.kt$method,round(unname(a.kt$statistic),2),unname(a.kt$parameter),round(a.kt$p.value,2))
  if(a.kt$p.value < 0.01){
    a.kt<-posthoc.kruskal.nemenyi.test(log(a[,i])~as.factor(a$abbr))
    i.0=i.3=c()
    i.2=dimnames(a.kt$p.value)[[1]]
    i.1=dimnames(a.kt$p.value)[[2]]
    for(j in 1:length(i.1)){
      i.0<-c(i.0,rep(i.1[j],length(i.2)))
      i.3<-c(i.3,unname(a.kt$p.value)[,j])
    };rm(j)
    tmp<-data.frame(colnames(a)[i],i.0,i.2,i.3, stringsAsFactors = F)
    a.kNRes<-rbind(a.kNRes,tmp)
    rm(i.0, i.1, tmp, i.2, i.3)
  }
};rm(i, a.kt)
a.kNRes<-a.kNRes[which(!is.na(a.kNRes[,4])),]

## drawing p.values between models
pdf("../results/Log_PCA_kt.pdf", width = 15)
leg.col<-"white"
plot.new()
par(mar=c(1,1,1,1))
## draw frame
polygon(x = c(.1,.9,.9,.1),y = c(.9,.1,.9,.1))
lines(x = c(.1,.9), y = c(.1,.1))
lines(x = c(.1,.9), y = c(.9,.9))
## attach model names
a.ptNam<-unique(a$model)
i.0=1;for(i in c(-.05,.8)){
  for(j in c(.16,.95)){
    legend(a.ptNam[i.0],x = i,y = j,bty = "o", bg = leg.col,box.col = leg.col, cex = 2)
    i.0<-i.0+1
  }
};rm(i,j,i.0)
## attach p-values
a.refpt<-data.frame("v1"=c(rep("ve",3),rep("go",2),"ba"),
                    "v2"=c("go",rep(c("ba","bu"),2),"bu"),
                    "x"=c(0,.4,.2,.6,.4,.8),
                    "y"=c(.7,.25,.55,.55,1.1,.7),
                    stringsAsFactors = F)
for(p in 1:nrow(a.refpt)){
  i=a.refpt$v1[p]
  j=a.refpt$v2[p]
  i.0<-a.kNRes[which(a.kNRes[,2]==i & a.kNRes[,3]==j | a.kNRes[,2]==j & a.kNRes[,3]==i),c(1,4)]
  i.0[,2]<-round(i.0[,2],3)
  i.1=c()
  for(k in 1:nrow(i.0)){
    i.1<-c(i.1,paste(i.0[k,],collapse = ": "))
  }
  legend(legend = i.1,x = a.refpt$x[p],y = a.refpt$y[p],box.col = leg.col, bg = leg.col,bty = "o", cex = 2)
};rm(i,j,k,i.0,i.1,p)
dev.off()

## boxplot on distribution per factor
a.bxpt<-as.data.frame(matrix(nrow = 0, ncol = 3))
for(i in 4:7){
  i.0<-a[,c(1,i)]
  i.0[,3]<-colnames(a)[i]
colnames(i.0)=c("model","data")
    a.bxpt<-rbind(a.bxpt,i.0)
};rm(i,i.0)
colnames(a.bxpt)=c("model","data","parameters")

pdf("../results/Log_boxPerFac.pdf", width = 15)
par(mar=c(5.1,4.1,1,12))
boxplot(log(a.bxpt$data)~a.bxpt$model+a.bxpt$parameters, col=cbp[2:5], at=c(1:4,6:9,11:14,16:19), xaxt="n", xlab = "parameters", ylab = "log parameter estimates", cex.axis=2, cex.lab=2) ## <https://stackoverflow.com/questions/47479522/how-to-create-a-grouped-boxplot-in-r>
axis(side = 1, at=c(1:4,6:9,11:14,16:19), labels = c("","","N0","","","","K","","","","r.max","","","","t.lag",""), lwd.ticks=F) ## <https://stackoverflow.com/questions/50545141/r-boxplot-x-axis-without-ticks-and-complete>
par(xpd=NA, cex=1)
legend(x=21, y=max(log(a.bxpt$data))*.9, legend = c("Verhulst (classical)", "modified Gompertz", "Baranyi", "Buchanan"), title = "Phenological Models", fill = cbp[2:5], bty = "n") ## no legend frame <https://stackoverflow.com/questions/10108073/plot-legends-without-border-and-with-white-background>
dev.off()

## data export for report
a.ktext=c()
for(i in 1:nrow(a.ktRes)){ ## extracting kruskal test summary
  a.ktext<-c(a.ktext,as.character(a.ktRes[i,-2]))
};rm(i)
a.expt<-c(a.ktext, ## kruskal test summary
          round(a.pcS$importance[2],2)*100, ## % of PC1
          round(a.pca$rotation[,1],2), ## PC1 parameters [vec of 4]
          round(a.pcS$importance[5],2)*100, ## % of PC2
          round(a.pca$rotation[,2],2), ## PC2 parameters [vec of 4]
          length(unique(a[,2])), ## num of datasets included
          paste(setdiff(seq(56),unique(a[,2])), collapse = ", ") ## which datasets not applicable
)
# a.expt<-round(c(a.pca$rotation[,1:2]),2)
write.table(a.expt, "../data/ttt_PCA.txt", quote = F, col.names = F, row.names = F)
