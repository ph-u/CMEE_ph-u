#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: ppt_trans_NG.R
# Desc: 1st homework for GIS session on 31-Oct to 01-Nov 2019
# Input: Rscript ppt_trans_NG.R
# Output: R terminal output
# Arguments: 0
# Date: Oct 2019

## source url: http://rpubs.com/david_orme/GIS_in_R

## lib
library(raster)
library(sf)
library(viridis)
library(units)
library(rgdal)
library(ggplot2)

## raw Data

## transect -- profiling target
tst<-data.frame("lon"=c(132.3, 135.2, 146.4, 149.3), "lat"=c(-1, -3.9, -7.7, -9.8))
