#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Logistic_2.R
# Desc: data analysis and results export for `LogisticGrowthMetaData.csv`
# Input: ```Rscript Logistic_2.R```
# Output: result output in `results` subdirectory
# Arguments: 0
# Date: Oct 2019

# setwd("/Volumes/HPM-000/Academic/Masters/ICL_CMEE/00_course/CMEECourseWork_pmH/MiniProject/code/")

## lib
library(ggplot2)
library(reshape2)
library(scales) ## rescale ggplot without eliminate bars

## colouring
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#e79f00", "#9ad0f3", "#F0E442", "#999999", "#cccccc", "#6633ff", "#00FFCC", "#0066cc")

## logistic equations: y=Nt x=exp(t)
func_log0<-function(N0, K, r, t){
  ## traditional Logistic equation: y~x
  Nt<-N0*K*exp(r*t)/(K+N0*(exp(r*t)-1))
  return(Nt)
}
func_Gom<-function(N0, K, r, t, ld){
  ## modified Gompertz model, initial 
  A<-log(K/N0)
  Nt<-A*exp(-exp(r*exp(1)/A*(ld-t)+1))
  return(Nt)
}
func_Bar<-function(N0, K, r, t, ld){
  ## Baranyi model
  h0=(exp(ld*r)-1)^-1
  At=t+r^-1*log((exp(-r*t)+h0)/(1+h0))
  Nt=N0+r*At-log(1+exp(r*At-1)/exp(K-N0))
  return(Nt)
}
func_Buc<-function(N0, K, r, t, tlag, tmx){
  ## Buchanan model / three-phase logistic model
  if(isTRUE(t<=tlag)){
    Nt=N0
  }else if(isTRUE(t>=tmx)){
    Nt=K
  }else{Nt=K+r*(t-tlag)}
  return(Nt)
}

## Data import
a.0<-read.csv("../data/Log_data.csv",header = T)
a.1<-read.table("../data/Log_Metadata.txt", sep = "\t", header = F, stringsAsFactors = F, blank.lines.skip = T)

## fix values for model-fitting
## assumed growth rate (r) is max during log phase (cluster 2)
dict_par<-as.data.frame(matrix(nrow = 6, ncol = 2))
dict_par[,1]<-c("N0", "K", "r", "ld", "tlag", "tmx")
## cluster 1 = lag; 2 = log; 3 = max
r.m<-(max(a.0[which(a.0$cluster==2),4])-min(a.0[which(a.0$cluster==2),4])) / (max(a.0[which(a.0$cluster==2),3])-min(a.0[which(a.0$cluster==2),3]))
r.y<-as.numeric(a.1[21,2])
r.x<-mean(a.0[which(a.0$cluster==2),3])
r.b<-r.y-r.m*r.x
dict_par[,2]<-c(a.1[20,2],a.1[22,2], ## N0, K
                r.m, ## r
                -r.b/r.m, ## ld
                max(a.0[which(a.0$cluster==1),3]), ## tlag
                min(a.0[which(a.0$cluster==3),3])) ## tmx
rm(list=ls(pattern="r."))

## model-plotting
a.0$log0<-func_log0(as.numeric(dict_par[which(dict_par[,1]=="N0"),2]),
                    as.numeric(dict_par[which(dict_par[,1]=="K"),2]),
                    as.numeric(dict_par[which(dict_par[,1]=="r"),2]),a.0$Time.hr)
a.0$gom<-func_Gom(as.numeric(dict_par[which(dict_par[,1]=="N0"),2]),
                  as.numeric(dict_par[which(dict_par[,1]=="K"),2]),
                  as.numeric(dict_par[which(dict_par[,1]=="r"),2]),a.0$Time.hr,
                  as.numeric(dict_par[which(dict_par[,1]=="ld"),2]))
a.0$bar<-func_Bar(as.numeric(dict_par[which(dict_par[,1]=="N0"),2]),
                  as.numeric(dict_par[which(dict_par[,1]=="K"),2]),
                  as.numeric(dict_par[which(dict_par[,1]=="r"),2]),a.0$Time.hr,
                  as.numeric(dict_par[which(dict_par[,1]=="ld"),2]))
for(i in 1:dim(a.0)[1]){
  a.0$buc[i]<-func_Buc(as.numeric(dict_par[which(dict_par[,1]=="N0"),2]),
                        as.numeric(dict_par[which(dict_par[,1]=="K"),2]),
                        as.numeric(dict_par[which(dict_par[,1]=="r"),2]),a.0$Time.hr[i],
                        as.numeric(dict_par[which(dict_par[,1]=="tlag"),2]),
                        as.numeric(dict_par[which(dict_par[,1]=="tmx"),2]))
};rm(i)

## reshape plotting data
a.1<-melt(a.0[,c(3,6:9)],id="Time.hr",variable.name = "p_func", value.name = "plot")

## Plot and export
pdf("../results/Log_data.pdf", width = 13)
ggplot()+theme_bw()+
  theme(axis.title = element_text(size = 20),
        axis.text = element_text(size = 20),
        legend.text = element_text(size = 15))+
  geom_point(aes(x=log(a.0$Time.hr), y=log(abs(a.0$Popn_Change)), colour=as.factor(a.0$cluster)),shape=4)+
  geom_line(aes(x=log(a.1$Time.hr), y=log(a.1$plot), linetype=a.1$p_func))+
  scale_colour_manual(name="Phase cluster",values = cbbPalette, labels=c("lag","exponential / log","stationary"))+
  scale_linetype_manual(name="Models", values = c(1,3,5,6), labels=c("classical","modified Gompertz","Baranyi","Buchanan"))+
  scale_y_continuous(limits = c(min(log(abs(a.0$Popn_Change))-.5),max(log(abs(a.0$Popn_Change))+.5)),oob = rescale_none)+ ## <https://stackoverflow.com/questions/10365167/geom-bar-bars-not-displaying-when-specifying-ylim>
  xlab("log time")+ylab("log population change")
dev.off()
