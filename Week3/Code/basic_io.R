#!/bin/env Rscript

# Author: ph-u
# Script: basic_io.R
# Desc: test R I/O ability & grammar
# Input: Rscript basic_io.R
# Output: output `MyData.csv` in `Results` subdirectory
# Arguments: 0
# Date: Oct 2019

## a simple script to illustrate R input-output
## run line by line and check inputs outputs to understand what is happening

MyData<-read.csv("../Data/trees.csv",header = T)## import with headers
write.csv(MyData,"../Results/MyData.csv")## write it out as a new file
write.table(MyData[1,],"../Results/MyData.csv",append=T)## append to it
write.csv(MyData,"../Results/MyData.csv",row.names = T)## write row names
write.table(MyData,"../Results/MyData.csv",sep=",",col.names = F)## ignore column names
