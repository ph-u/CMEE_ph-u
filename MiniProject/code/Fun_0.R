#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Fun_0.R
# Desc: Miniproject on `ThermRespData.csv`
# Input: ```Rscript Fun_0.R```
# Output: results
# Arguments: 0
# Date: Nov 2019

# setwd("/Volumes/HPM-000/Academic/Masters/ICL_CMEE/00_course/CMEECourseWork_pmH/MiniProject/code/")

## lib
library(ggplot2)

## data in
a.0<-read.csv("../data/ThermRespData.csv", header = T, stringsAsFactors = F)
