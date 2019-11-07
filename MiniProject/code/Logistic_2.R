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

## raw
a.0<-read.csv("../data/Log_data.csv",header = T)
a.1<-read.table("../data/Log_Metadata.txt", sep = "\t", header = F, stringsAsFactors = F, blank.lines.skip = T)

## variable
r.m<-(max(a.0[which(a.0$cluster==2),2])-min(a.0[which(a.0$cluster==2),2])) / (max(a.0[which(a.0$cluster==2),3])-min(a.0[which(a.0$cluster==2),3]))
r.b<-max(a.0[which(a.0$cluster==2),2])-r.m*max(a.0[which(a.0$cluster==2),3])
r.x<--r.b/r.m

## functions & calculations
func_log0<-function(N0=as.numeric(a.1[19,2]),
                    K=as.numeric(a.1[21,2]),
                    r=r.m, t){
  Nt=N0*K*exp(r*t)/(K+N0*(exp(r*t)-1))
  return(Nt)}
a.0$log0<-func_log0(t=a.0$Time.hr)

func_gom<-function(N0=as.numeric(a.1[19,2]),
                   K=as.numeric(a.1[21,2]),
                   r=r.m, t,
                   ld=r.x){
  A=log(K/N0)
  Nt=exp(A*exp(-exp(r*exp(1)/A*(ld-t)+1)))
  return(Nt)}
a.0$gom<-func_gom(t=a.0$Time.hr)

func_bar<-function(N0=as.numeric(a.1[19,2]),
                   K=as.numeric(a.1[21,2]),
                   r=r.m, t,
                   tlag=max(a.0[which(a.0$cluster==1),3])){
  h0=1/(exp(tlag*r)-1)
  At=t+1/r*log((exp(-r*t)+h0)/(1+h0))
  Nt=N0+r*At-log(1+(exp(r*At)-1)/exp(K-N0))
  return(Nt)}
a.0$bar<-func_bar(t=a.0$Time.hr)

func_buc<-function(N0=as.numeric(a.1[19,2]),
                   K=as.numeric(a.1[21,2]),
                   r=r.m, t,
                   tlag=max(a.0[which(a.0$cluster==1),3]),
                   cst=as.numeric(a.0$cluster)){
  a.010=(cst-1)%%2 ## make only log phase valid in growth rate
  a.001=ceiling(cst%%2.5%%1) ## make only final phase valid
  # a.011=floor((cst%%1.5+1)%%2) ## make only non-lag phase valid
  Nt=N0+a.001*(K-N0)+a.010*r*(t-tlag)
  return(Nt)}
a.0$buc<-func_buc(t=a.0$Time.hr)

## melt for plot
a.2<-melt(a.0[,-c(1,2,4,5)],id="Time.hr",variable.name = "model",value.name = "ExpPop")

## graph
pdf("../results/Log_data.pdf", width = 13)
ggplot()+theme_bw()+
  theme(axis.title = element_text(size = 20),
        axis.text = element_text(size = 20),
        legend.text = element_text(size = 15))+
  geom_point(aes(x=a.0$Time.hr, y=abs(a.0$Popn_Change), colour=as.factor(a.0$cluster)),shape=4)+
  geom_line(aes(x=a.2$Time.hr, y=a.2$ExpPop, linetype=a.2$model))+
  scale_colour_manual(name="Phase cluster",values = cbbPalette[c(4,2,6)], labels=c("lag","exponential / log","stationary"))+
  scale_linetype_manual(name="Models", values = c(1,3,5,6), labels=c("classical","modified Gompertz","Baranyi","Buchanan"))+
  scale_y_continuous(labels = scientific,trans = "log10",limits = c(min(abs(a.0$Popn_Change)-.5),max(abs(a.0$Popn_Change))+.5),oob = rescale_none)+ ## <https://stackoverflow.com/questions/10365167/geom-bar-bars-not-displaying-when-specifying-ylim>
  xlab("Time (hr)")+ylab("log population change")
dev.off()
