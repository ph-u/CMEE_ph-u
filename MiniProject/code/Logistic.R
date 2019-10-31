#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Logistic.R
# Desc: model-fitting and data analysis for `LogisticGrowthMetaData.csv`
# Input: Rscript Logistic.R
# Output: analysis result and metadata file output in `result` subdirectory
# Arguments: 0
# Date: Oct 2019

# setwd("/Volumes/HPM-000/Academic/Masters/ICL_CMEE/00_course/CMEECourseWork_pmH/MiniProject/code/")

## lib
library(ggplot2)

{## data cleaning
  a<-read.csv("../data/LogisticGrowthData.csv", header = T, stringsAsFactors = F)[,-1]
  a<-a[,c(3,6:9,1,2,5)]
  colnames(a)=c("Temp.C","clade","substrate","replicate","SourceRef","Time.hr","Popn_Change","Popn_DataUnit")
  a$Time.hr<-abs(a$Time.hr) ## convert -ve times
  a$clade<-gsub(".1|.2|..RDA.R.","",a$clade) ## condense spp names
  a$clade<-gsub("spp.|sp.","sp",a$clade) ## condense spp names
  a$clade<-gsub("[.]"," ",a$clade) ## condense spp names
  a$clade<-gsub("77|88|Strain 97|StrainCYA28|subsp Carotovorum Pc","",a$clade) ## rm specific unnecessary things for better spp categorizing
  a$clade<-trimws(a$clade) ## condense spp names (rm white spaces from both ends)
  # levels(as.factor(a$clade))
}

{## data subset selection -- select the largest data subset
  a.DU.lv<-levels(as.factor(a$Popn_DataUnit))
  a.Tp.lv<-levels(as.factor(a$Temp.C))
  a.cd.lv<-levels(as.factor(a$clade))
  a.ss.lv<-levels(as.factor(a$substrate))
  a.rp.lv<-levels(as.factor(a$replicate))
  a.ct.lv<-levels(as.factor(a$SourceRef))
  
  ## hierarchical selection of available subsets
  p.rec<-as.data.frame(matrix(nrow = 0, ncol = 6))
  cat("R Filtering 1st set of columns\n")
  p.2<-p.4<-p.6<-1;repeat{
    ## check repeat loop running num seq
    if(p.2==length(a.Tp.lv)){
      if(p.4==length(a.ss.lv)){
        if(p.6==length(a.ct.lv)){
          break
        }else{
          p.2<-p.4<-1
          p.6<-p.6+1
        }
      }else{
        p.2<-1
        p.4<-p.4+1
      }
    }else{
      p.2<-p.2+1
    }
    ## scan subset dimension
    p.7<-dim(a[which(a$Temp.C==a.Tp.lv[p.2] &
                       a$substrate==a.ss.lv[p.4] &
                       a$SourceRef==a.ct.lv[p.6]),])[1]
    if(p.7 > 0){p.rec[(dim(p.rec)[1]+1),]<-c(NA,p.2,NA,p.4,NA,p.6)}
  }
  p.recL<-dim(p.rec)[1]
  cat("R Filtering 2nd set of columns\n")
  p.1<-p.3<-p.5<-1;repeat{
    ## check repeat loop running num seq
    if(p.1==length(a.DU.lv)){
      if(p.3==length(a.cd.lv)){
        if(p.5==length(a.rp.lv)){
          break
        }else{
          p.1<-p.3<-1
          p.5<-p.5+1
        }
      }else{
        p.1<-1
        p.3<-p.3+1
      }
    }else{
      p.1<-p.1+1
    }
    ## scan subset dimension
    p.7<-dim(a[which(a$Popn_DataUnit==a.DU.lv[p.1] &
                       a$clade==a.cd.lv[p.3] &
                       a$replicate==a.rp.lv[p.5]),])[1]
    if(p.7 > 0){p.rec[(dim(p.rec)[1]+1),]<-c(p.1,NA,p.3,NA,p.5,NA)}
  }
  a.0<-as.data.frame(matrix(nrow = 0,ncol = dim(a)[2]))
  cat("R Combine filtering result\n")
  for(i in 1:p.recL){ ## further select for subset with largest data points
    for(j in (p.recL):dim(p.rec)[1]){
      p.7<-a[which(a$Popn_DataUnit==a.DU.lv[p.rec[j,1]] &
                     a$Temp.C==a.Tp.lv[p.rec[i,2]] &
                     a$clade==a.cd.lv[p.rec[j,3]] &
                     a$substrate==a.ss.lv[p.rec[i,4]] &
                     a$replicate==a.rp.lv[p.rec[j,5]] &
                     a$SourceRef==a.ct.lv[p.rec[i,6]]),]
      if(dim(p.7)[1] > dim(a.0)[1]){a.0<-p.7}
    }
  };rm(i,j)
  rm(list=ls(pattern="p.|.lv"))
}

## plot & export
cat("R Plotting & writing results\n")
# pdf("../../Week5/Sandbox/hi.pdf",height = 100)
# ggplot(data = a,aes(x=log(a$Time.hr), y=log(a$Popn_Change)))+theme_bw()+
#   geom_point(aes(colour=a$clade), show.legend = F)+
#   facet_grid(a$clade ~.)
# dev.off()
# plot(x=a$Time.hr, y=a$Popn_Change, col=a$clade)
pdf("../results/Log_data.pdf");ggplot(data = a.0,aes(y=log(a.0$Popn_Change^2), x=log(a.0$Time.hr)))+theme_bw()+
  theme(axis.title = element_text(size = 20),
        axis.text = element_text(size = 20))+
  geom_point()+
  xlab("log time")+ylab("log population change");dev.off()

## plot data export
write.csv(a.0,"../results/Log_data.csv",quote = F, row.names = F)

{## data description
  a.md<-data.frame(colnames(a.0)[-c(6,7)],t(a.0[1,-c(6,7)]),stringsAsFactors = F)
  row.names(a.md)=NULL
  # colnames(a.md)=c("Metadata","Content")
  a.md<-rbind(a.md,c("Subset sample size",dim(a.0)[1]))
  a.md<-rbind(a.md,c("Normality of log Population Change",round(shapiro.test(log(a.0$Popn_Change))$p.value,2)))
  a.md<-rbind(a.md,c("Normality of log time of experiment",round(shapiro.test(log(a.0$Time.hr))$p.value,2)))
  k<-0;for(i in 1:2){j<-ifelse(i<2,"Time.hr","Population Change");k<-c(k,paste0(c("Min", "1stQt","Median","3rdQt","Max"),"_",j))};rm(i,j)
  a.md<-data.frame(c(a.md[,1],k[-1]),c(a.md[,2],round(fivenum(log(a.0$Time.hr)),2),round(fivenum(log(a.0$Popn_Change)),2)));rm(k)
  write.table(a.md,"../results/Log_Metadata.csv",quote = F, row.names = F, sep = "\t",col.names = F)
  }
