#!/bin/env Rscript

# Author: ph-u
# Script: maps.R
# Desc: test GIS mapping in `ggplot2` pkg within R
# Input: Rscript maps.R
# Output: None
# Arguments: 0
# Date: Oct 2019

## key ref <https://eriqande.github.io/rep-res-web/lectures/making-maps-with-R.html>

## library
library(maps)
library(ggplot2)

load("../Data/GPDDFiltered.RData")

## create world map
map(database = "world")

## map data on global map
m<-map_data("world")
# pdf("../Sandbox/MappedMap.pdf",width = 15)
ggplot()+xlab("longitude")+ylab("latitude")+
  xlim(c(min(m$long),max(m$long)))+ylim(c(min(m$lat),max(m$lat)))+
  geom_map(data = m,map = m,aes(map_id=m$region),fill="brown")+
  geom_point(aes(x=gpdd$long,y=gpdd$lat))
# dev.off()

## commit message: biases towards densely populated N-hemisphere European-based societies
