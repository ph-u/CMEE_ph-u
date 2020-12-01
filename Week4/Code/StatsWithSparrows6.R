#!/bin/env Rscript

# Author: ph-u
# Script: StatsWithSparrows6.R
# Desc: minimal R function with two in-script tests
# Input: none -- run in R console line-by-line
# Output: R terminal output
# Arguments: 0
# Date: Oct 2019

oo<-read.table("../Data/SparrowSize.txt", sep = "\t", header = T)

library(pwr)
pwr.t.test(d=5/sd(oo$Wing,na.rm = T),sig.level = .05,power = .8)
