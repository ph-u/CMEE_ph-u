#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Log_0.R
# Desc: Miniproject on `LogisticGrowthMetaData.csv`
# Input: ```Rscript Log_0.R```
# Output: results
# Arguments: 0
# Date: Nov 2019

# setwd("/Volumes/HPM-000/Academic/Masters/ICL_CMEE/00_course/CMEECourseWork_pmH/MiniProject/code/")

## library
library(ggplot2)
library(scales)

## raw input & data cleaning
a<-read.csv("../data/LogisticGrowthData.csv", header = T, stringsAsFactors = F)[,-1]
a<-a[,c(3,6:9,1,2,5)]
colnames(a)=c("Temp.C","clade","substrate","replicate","SourceRef","Time.hr","Popn_Change","Popn_DataUnit")
a$Time.hr<-abs(a$Time.hr) ## convert -ve times
a$clade<-gsub(".1|.2|..RDA.R.","",a$clade) ## condense spp names
a$clade<-gsub("spp.|sp.","sp",a$clade) ## condense spp names
a$clade<-gsub("[.]"," ",a$clade) ## condense spp names
a$clade<-gsub("77|88|Strain 97|StrainCYA28|subsp Carotovorum Pc","",a$clade) ## rm specific unnecessary things for better spp categorizing
a$clade<-trimws(a$clade) ## condense spp names (rm white spaces from both ends)

write.table(a, "../data/Log_Data.txt",sep="\t", quote=F)

## get unique datasets
a.0<-as.data.frame(matrix(nrow=0, ncol=(dim(a)[2]-2)))
for(i in 1:dim(a)[1]){
  if(i==1){
    v.1<-unique(a.0[,1])
    v.2<-unique(a.0[,2])
    v.3<-unique(a.0[,3])
    v.4<-unique(a.0[,4])
    v.5<-unique(a.0[,5])
    v.6<-unique(a.0[,6])
  }
  if(!(a[i,1] %in% v.1 & a[i,2] %in% v.2 & a[i,3] %in% v.3 & a[i,4] %in% v.4 & a[i,5] %in% v.5 & a[i,8] %in% v.6)){
    a.0<-rbind(a.0,a[i,-c(6:7)])
    v.1<-unique(a.0[,1])
    v.2<-unique(a.0[,2])
    v.3<-unique(a.0[,3])
    v.4<-unique(a.0[,4])
    v.5<-unique(a.0[,5])
    v.6<-unique(a.0[,6])
  }
};rm(i);rm(list=ls(pattern="v."))
write.table(a.0, "../data/Log_Uq.txt",sep="\t", quote=F)

## plot prep datasets
for(i in 1:dim(a.0)[1]){
  a.p<-a[which(a$Temp.C==a.0$Temp.C[i] &
                  a$clade==a.0$clade[i] &
                 a$substrate==a.0$substrate[i] &
                 a$replicate==a.0$replicate[i] &
                 a$SourceRef==a.0$SourceRef[i] &
                 a$Popn_DataUnit==a.0$Popn_DataUnit[i]),]
  if(i<10){i.1<-"00"}else if(i<100){i.1<-"0"}else{i.1<-""}
  pdf(paste0("../sandbox/Log_PreGraph/",i.1,i,".pdf"))
  print(ggplot()+theme_bw()+
          xlab("Time (hr)")+ylab(paste0("Population Change (",unique(a.p$Popn_DataUnit),")"))+
          ggtitle(paste0(a.0$Temp.C[i],"_",a.0$clade[i],"_",a.0$substrate[i],"_",a.0$replicate[i],"_",a.0$Popn_DataUnit[i],"_",dim(a.p)[1]))+
          geom_point(aes(x=a.p$Time.hr, y=a.p$Popn_Change), shape=4, colour="red")+
    geom_text(aes(label=a.0$SourceRef[i],x=max(a.p$Time.hr)-min(a.p$Time.hr), y=max(a.p$Popn_Change)-min(a.p$Popn_Change)), size=2)+
    scale_y_continuous(labels = scientific,
                       trans = "log10",
                       oob = rescale_none))
  dev.off()
};rm(i,a.p)
