#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: TPC_0.R
# Desc: Miniproject on `ThermRespData.csv`
# Input: ```Rscript TPC_0.R```
# Output: results
# Arguments: 0
# Date: Nov 2019

# setwd("/Volumes/HPM-000/Academic/Masters/ICL_CMEE/00_course/CMEECourseWork_pmH/MiniProject/code/")

## lib

## data in
a.0<-read.csv("../data/ThermRespData.csv", header = T, stringsAsFactors = F)
colnames(a.0) ## checking

## col select (release RAM)
a.0<-data.frame(a.0$ID, a.0$Replicates, a.0$Citation, a.0$OrignalTraitName, a.0$OriginalTraitValue, a.0$OriginalTraitUnit, a.0$ConTemp, a.0$ConTempUnit)
colnames(a.0)=c("id", "rep", "cite", "OTName", "OTValue", "OTUnit", "Temp", "TUnit")

## 