#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: chess.R
# Desc: 3rd homework for GIS session on 31-Oct to 01-Nov 2019
# Input: Rscript chess.R
# Output: R terminal output
# Arguments: 0
# Date: Nov 2019

## source url: http://rpubs.com/david_orme/GIS_in_R

## lib
library(raster)

## generate data
a<-raster(matrix(0, ncol=5, nrow = 5))
a[13]<-2 ## set initial pixel

a.rook<-adjacent(a, 13, direction=4)[,2]
a.queen<-adjacent(a, 13, direction=8)[,2]
a.knight<-adjacent(a, 13, direction=16)[,2]

## plot
par(mfrow=c(1,3), mar=c(1,1,1,1))
a[a.rook]<-1;plot(a)
a[a.queen]<-1;plot(a)
a[a.knight]<-1;plot(a)
