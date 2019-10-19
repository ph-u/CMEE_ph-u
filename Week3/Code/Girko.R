#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Girko.R
# Desc: Use Girko equation to plot a Girko law simulation
# Input: Rscript Girko.R
# Output: a vector plot in `Results` subdirectory
# Arguments: 0
# Date: Oct 2019

## library
library(ggplot2)

## function
build_ellipse<-function(hradius, vradius){ ## function that returns an ellipse
  npoints=250
  a<-seq(0,2*pi, length=npoints+1)
  x<-hradius*cos(a)
  y<-vradius*sin(a)
  return(data.frame(x=x, y=y))
}

## build content
N<-250 ## assign size of the matrix
M<-matrix(rnorm(N^2), N, N) ## build the matrix
eigvals<-eigen(M)$values ## find the eigenvalues
eigDF<-data.frame("Real"=Re(eigvals), "Imaginary"=Im(eigvals)) ## Build a dataframe
my_radius<-sqrt(N) ## the radius of the circle is sqrt(N)
ellDF<-build_ellipse(my_radius, my_radius) ## dataframe to plot the ellipse
names(ellDF) <- c("Real", "Imaginary") ## rename the columns

## plot & export
pdf("../Results/Girko.pdf")
ggplot(eigDF, aes(x=Real, y=Imaginary))+
  geom_point(shape=I(3))+theme(legend.position = "none")+
  geom_hline(aes(yintercept=0))+
  geom_vline(aes(xintercept=0))+
  geom_polygon(data = ellDF, aes(x=Real, y=Imaginary, alpha=1/20, fill="red"))
dev.off()