#!/bin/env Rscript

# Author: ph-u
# Script: apply1.R
# Desc: try out apply() built-in R function
# Input: Rscript apply1.R
# Output: three blocks of two-lined terminal output
# Arguments: 0
# Date: Oct 2019

## Build a random matrix
M<-matrix(rnorm(100),10,10)

## Take the mean of each row
RowMeans<-apply(M,1,mean)
print(RowMeans)

## Now the variance
RowVars<-apply(M, 1, var)
print(RowVars)

## By column
ColMeans<-apply(M,2,mean)
print(ColMeans)
