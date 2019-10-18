#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: PP_Regress.R
# Desc: Export one complex plot to `results` subdirectory
# Input: Rscript PP_Regress.R
# Output: a vector plot in `results` subdirectory
# Arguments: 0
# Date: Oct 2019

## library
library(ggplot2)

## input
oo<-read.csv("../Data/EcolArchives-E089-51-D1.csv", header = T)

## plot & export
yscale<-1e-6;for(i in 1:3){yscale[i+1]<-yscale[i]*(1e4)^i};rm(i)
xscale<-1e-7;for(i in 1:2){xscale[i+1]<-xscale[i]*(1e4)^i};rm(i)
pdf("../results/PP_Regress.pdf")
ggplot(data = oo,aes(x=log(oo$Prey.mass),y=log(oo$Predator.mass),colour=oo$Predator.lifestage))+
  geom_point(shape=3)+geom_smooth(method = "lm", fullrange=T)+theme_bw()+
  theme(legend.title = element_text(face = "bold"), legend.position = "bottom")+
  scale_x_continuous(labels = function(x) format(x, scientific = TRUE), limits = c(1e-7,1e1), breaks = xscale)+
  scale_y_continuous(labels = function(x) format(x, scientific = TRUE), limits = c(1e-6,1e6), breaks = yscale)+
  scale_color_discrete(name="Predator.lifestage")+
  facet_grid(oo$Type.of.feeding.interaction ~.)+
  xlab("Prey Mass in grams")+ylab("Predator mass in grams")
dev.off()

## data info collect
