#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: MyBars.R
# Desc: Export one annotated plot to `results` subdirectory
# Input: Rscript MyBars.R
# Output: a vector plot in `results` subdirectory
# Arguments: 0
# Date: Oct 2019

## library
library(ggplot2)

## input
a<-read.table("../Data/Results.txt", header = T)

## data handling
a$ymin<-rep(0,dim(a)[1]) ## append a column of zeros

## plot & export
pdf("../results/MyBars.pdf")
ggplot(a)+
  geom_linerange(data = a, aes(x=x, ymin=ymin,ymax=y1,size=.5),colour="#E69F00", alpha=.5, show.legend = F)+ ## Print the first linerange
  geom_linerange(data = a, aes(x=x, ymin=ymin, ymax=y2, size=.5), colour="#56B4E9", alpha=.5, show.legend = F)+ ## print the second linerange
  geom_linerange(data = a, aes(x=x, ymin=ymin, ymax=y3, size=.5), colour="#D55E00", alpha=.5, show.legend = F)+## print the third linerange
  geom_text(data = a, aes(x=x, y=-500, label=Label))+ ## annotate the plot with labels
  scale_x_continuous("My x axis", breaks = seq(3,5,by=.05))+ scale_y_continuous("My y axis")+ theme_bw()+ theme(legend.position = "none") ## not set the axis labels, remove the legend, and prepare for bw printing
dev.off()