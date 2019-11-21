#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Log_d.R
# Desc: R data input, second section of decending scripts
# Input: ```Rscript Log_f.R```
# Output: none
# Arguments: 0
# Date: Nov 2019

## settings:
## a = raw data
## a.~ = data.frames decending from raw data
## f.~ = functions
## v.~ = variables
## i~ = temporary variables

## data input
a<-read.table("../data/Log_Data.txt",sep="\t",header = T, stringsAsFactors = F)
a.0<-read.table("../data/Log_Uq.txt",sep="\t", header = T, stringsAsFactors = F)
