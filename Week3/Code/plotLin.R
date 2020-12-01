#!/bin/env Rscript

# Author: ph-u
# Script: plotLin.R
# Desc: Export one annotated linear regression plot to `Results` subdirectory
# Input: Rscript plotLin.R
# Output: a vector plot in `Results` subdirectory
# Arguments: 0
# Date: Oct 2019

## library
library(ggplot2)

## content
x<-seq(0,100,by=.1)
y<--4.+.25*x+rnorm(length(x),mean=0., sd=2.5)

## and put them in a dataframe
my_data<-data.frame(x=x, y=y)

## perform a linear regression
my_lm<-summary(lm(y~x, data = my_data))

## plot & export
pdf("../Results/MyLinReg.pdf")
ggplot(my_data, aes(x=x, y=y, colour=abs(my_lm$residuals)))+
  geom_point()+
  scale_color_gradient(low = "black", high = "red")+
  theme(legend.position = "none")+
  scale_x_continuous(expression(alpha^2*pi/beta*sqrt(Theta)))+
  geom_abline(intercept = my_lm$coefficients[1][1], slope=my_lm$coefficients[2][1], colour="red")+
  geom_text(aes(x=60, y=0, label="sqrt(alpha) *2 *pi"), parse = T, size=6, colour="blue") ## throw some math on the plot
dev.off()
