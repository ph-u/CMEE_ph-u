#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: DataWrang.R
# Desc: test conditionals, `for` loops and `while` loops
# Input: Rscript DataWrang.R
# Output: multiple tabular terminal output
# Arguments: 0
# Date: Oct 2019

MyData<-as.matrix(read.csv("../Data/PoundHillData.csv",header = F,stringsAsFactors = F))
MyMetaData<-read.csv("../Data/PoundHillMetaData.csv",header = T,sep = ";",stringsAsFactors = F)
class(MyData)
head(MyData)
MyMetaData
MyData[MyData==""]=0
MyData<-t(MyData)
head(MyData)
colnames(MyData)
TempData<-as.data.frame(MyData[-1,],stringAsFactors=F)
head(TempData)
colnames(TempData)<-MyData[1,] ## assign column names from original data
head(TempData)
rownames(TempData)<-NULL
head(TempData)

library(reshape2)
MyWrangledData<-melt(TempData,id=c("Cultivation","Block","Plot","Quadrat"),variable.name = "Species",value.name = "Count") ## <https://stackoverflow.com/questions/25688897/reshape2-melt-warning-message>
head(MyWrangledData);tail(MyWrangledData)

for(i in 1:dim(MyWrangledData)[2]){
  if(i<dim(MyWrangledData)[2]){
    MyWrangledData[,i]<-as.factor(MyWrangledData[,i])
  }else{
    MyWrangledData[,i]<-as.integer(MyWrangledData[,i])
  }
};rm(i)
# MyWrangledData[,"Cultivation"]<-as.factor(MyWrangledData[,"Cultication"])
# MyWrangledData[,"Block"]<-as.factor(MyWrangledData[,"Block"])
# MyWrangledData[,"Plot"]<-as.factor(MyWrangledData[,"Plot"])
# MyWrangledData[,"Quadrat"]<-as.factor(MyWrangledData[,"Quadrat"])
# MyWrangledData[,"Count"]<-as.integer(MyWrangledData[,"Count"])
str(MyWrangledData)

library(dplyr)
tbl_df(MyWrangledData) ## like head(), but nicer! <https://github.com/r-lib/vctrs/issues/487>
# glimpse(MyWrangledData) ## like str(), but nicer! <Error: 'vec_dim' is not an exported object from 'namespace:vctrs'>
filter(MyWrangledData,Count>100) ## like subset(), but nicer!
slice(MyWrangledData, 10:15) ## Look at an arbitrary set of data rows
