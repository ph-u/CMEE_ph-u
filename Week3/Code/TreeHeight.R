#!/bin/env Rscript

# Author: ph-u
# Script: TreeHeight.R
# Desc: tree height calculation program with given sample data set
# Input: Rscript TreeHeight.R
# Output: `TreeHts.csv` in `Results` subdirectory
# Arguments: 0
# Date: Oct 2019

## This function calculates heights of trees given distance of each tree from its base and angle to its top, using the trigonometric formula

## height = distance * tan(radians)

## arguments
## degrees: The angle of elevation of tree
## distance: the distance from base of tree (e.g. metres)

## output
## the heights of the tree, same units as "distance"

TreeHeight <- function(degrees, distance){
  radians<-degrees*pi/180
  height<-distance*tan(radians)
  print(paste("Tree Height is:",height))
  
  return(height)
}
## TreeHeight(37,40)
# args=(commandArgs(T))
a<-read.csv("../Data/trees.csv",header = T)
a.0<-data.frame(a,TreeHeight(a$Angle.degrees,a$Distance.m))
colnames(a.0)[dim(a.0)[2]]="Tree.Height.m"
write.csv(a.0,"../Results/TreeHts.csv",quote = F,row.names = F)
