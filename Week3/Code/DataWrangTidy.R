#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: DataWrangTidy.R
# Desc: test conditionals, `for` loops and `while` loops
# Input: Rscript DataWrangTidy.R
# Output: multiple tabular terminal output
# Arguments: 0
# Date: Oct 2019

library(dplyr)
library(tidyr)

MyData<-as.matrix(read.csv("../Data/PoundHillData.csv",header = F,stringsAsFactors = F))
MyMetaData<-read.csv("../Data/PoundHillMetaData.csv",header = T,sep = ";",stringsAsFactors = F)
class(MyData)
tbl_df(MyData)## head(MyData)
MyMetaData
MyData[MyData==""]=0
MyData<-as.data.frame(t(MyData),stringsAsFactors = F)
head(MyData)
colnames(MyData)
TempData<-as.data.frame(MyData[-1,],stringAsFactors=F)
tbl_df(TempData)## head(TempData)
colnames(TempData)<-MyData[1,] ## assign column names from original data
tbl_df(TempData)## head(TempData)
rownames(TempData)<-NULL
tbl_df(TempData)## head(TempData)

# library(reshape2)
# MyWrangledData<-melt(TempData,id=c("Cultivation","Block","Plot","Quadrat"),variable.name = "Species",value.name = "Count")
MyWrangledData<-gather(TempData,"Species","Count",5:dim(TempData)[2])
tbl_df(MyWrangledData);tbl_df(MyWrangledData[(dim(MyWrangledData)[1]-5):dim(MyWrangledData)[1],]);## head(MyWrangledData);tail(MyWrangledData)

MyWrangledData[,"Cultivation"]<-as.factor(MyWrangledData[,"Cultication"])
MyWrangledData[,"Block"]<-as.factor(MyWrangledData[,"Block"])
MyWrangledData[,"Plot"]<-as.factor(MyWrangledData[,"Plot"])
MyWrangledData[,"Quadrat"]<-as.factor(MyWrangledData[,"Quadrat"])
MyWrangledData[,"Count"]<-as.integer(MyWrangledData[,"Count"])
# glimpse(MyWrangledData) ## str(MyWrangledData)

tbl_df(MyWrangledData) ## like head(), but nicer! <https://github.com/r-lib/vctrs/issues/487>
# glimpse(MyWrangledData) ## like str(), but nicer!
filter(MyWrangledData,Count>100) ## like subset(), but nicer!
slice(MyWrangledData, 10:15) ## Look at an arbitrary set of data rows
