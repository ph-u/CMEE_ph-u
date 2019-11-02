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

## Data import
a.0<-read.csv("../data//Log_data.csv",header = T)

## Plot and export
pdf("../results/Log_data.pdf")
ggplot(data = a.0,aes(y=log(a.0$Popn_Change^2), x=log(a.0$Time.hr)))+theme_bw()+
  theme(axis.title = element_text(size = 20),
        axis.text = element_text(size = 20))+
  geom_point()+
  xlab("log time")+ylab("log population change")
dev.off()
