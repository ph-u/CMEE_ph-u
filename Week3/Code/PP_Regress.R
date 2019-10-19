#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: PP_Regress.R
# Desc: Export one complex plot and data information (under factors "predator feeding type" and "predator life stage") to `Results` subdirectory
# Input: Rscript PP_Regress.R
# Output: 1. a vector plot in `Results` subdirectory; 2. result `csv` in `Results` subdirectory
# Arguments: 0
# Date: Oct 2019

## library
library(ggplot2)

## input
oo<-read.csv("../Data/EcolArchives-E089-51-D1.csv", header = T)

## plot & export
yscale<-1e-6;for(i in 1:3){yscale[i+1]<-yscale[1]*(1e4)^i};rm(i)
xscale<-1e-7;for(i in 1:2){xscale[i+1]<-xscale[1]*(1e4)^i};rm(i)
pdf("../Results/PP_Regress.pdf", height = 11, width = 10)
  ggplot(data = oo,aes(x=oo$Prey.mass,y=oo$Predator.mass,colour=oo$Predator.lifestage))+theme_bw()+
    geom_point(shape=3)+
    geom_smooth(method = "lm", fullrange=T)+
    theme(legend.title = element_text(face = "bold"),
          legend.position = "bottom",
          plot.margin = unit(c(1,7,1,7),"cm"), ## https://stackoverflow.com/questions/18252827/increasing-area-around-plot-area-in-ggplot2
          strip.text = element_text(face="bold", size = 10))+ ## https://stackoverflow.com/questions/3290330/facet-label-font-size
    guides(colour = guide_legend(nrow = 1))+ ## https://stackoverflow.com/questions/36087262/ggplot2-legend-items-in-a-single-horizontal-row
    scale_color_discrete(name="Predator.lifestage")+
    facet_grid(oo$Type.of.feeding.interaction ~.)+
    xlab("Prey Mass in grams")+ylab("Predator mass in grams")+
    scale_x_continuous(trans = "log10", breaks = xscale)+ ## https://www.datanovia.com/en/blog/ggplot-log-scale-transformation/
    scale_y_continuous(trans = "log10", breaks = yscale)
dev.off()

## data info collect
oo.0<-as.data.frame(matrix(nrow = length(unique(oo$Type.of.feeding.interaction))*length(unique(oo$Predator.lifestage)), ncol = 7))
colnames(oo.0)<-c("FeedingType", "LifeStageCategory", "slopeSpearman", "interceptSpearman","R2", "F-statistics", "p-val")
a.0<-levels(oo$Type.of.feeding.interaction)
a.1<-0;for(i in 1:length(a.0)){a.1<-c(a.1,rep(a.0[i],length(levels(oo$Predator.lifestage))))};a.1<-a.1[-1]
oo.0[,1]<-as.factor(a.1);oo.0[,2]<-as.factor(levels(oo$Predator.lifestage))
rm(i,a.0,a.1)
for(i in 1:dim(oo.0)[1]){
  oo.1<-length(oo$Predator.mass[which(oo$Type.of.feeding.interaction==oo.0$FeedingType[i] & oo$Predator.lifestage==oo.0$LifeStageCategory[i])])
  if(oo.1>0){
    print(paste("Usable results:",oo.0[i,1],";",oo.0[i,2]))
    oo.1<-oo[which(oo$Type.of.feeding.interaction==oo.0$FeedingType[i] & oo$Predator.lifestage==oo.0$LifeStageCategory[i]),]
    oo.2<-suppressWarnings(cor.test(log(oo.1$Predator.mass),log(oo.1$Prey.mass), method="spearman"))
    oo.3<-lm(log(oo.1$Predator.mass)~log(oo.1$Prey.mass))
    oo.0[i,3]<-unname(oo.3$coefficients[2])
    oo.0[i,4]<-unname(oo.3$coefficients[1])
    oo.0[i,5]<-unname(oo.2$estimate)^2
    oo.0[i,6]<-unname(oo.2$statistic)
    oo.0[i,7]<-unname(oo.2$p.value)
  }
};oo.0<-oo.0[which(is.na(oo.0[,3])!=T),];rm(i,oo.1,oo.2,oo.3)
write.csv(oo.0,"../Results/PP_Regress_Results.csv",row.names = F, quote = F)
