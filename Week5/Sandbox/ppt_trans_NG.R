#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: ppt_trans_NG.R
# Desc: 1st homework for GIS session on 31-Oct to 01-Nov 2019
# Input: Rscript ppt_trans_NG.R
# Output: a graphical `pdf` in `results` subdirectory
# Arguments: 0
# Date: Nov 2019

## source url: http://rpubs.com/david_orme/GIS_in_R

## lib
library(raster)
library(sf)
library(viridis)
library(units)
library(rgdal)

## data handling
a<-getData('worldclim', download=T, path='../Data', var='prec', res=.5, lon=140, lat=-1) ## raw Data
a<-crop(a,a.ext<-extent(130,150,-10.5,0)) ## lon0, lon1,lat0, lat1
a<-sum(a) ## take annual mean of data

## set graphical limits
a.lim<-st_transform(a.cst<-st_as_sfc(st_bbox(a.ext, crs = 4326)), 32754) ## get x- & y-lims for reprojection
a.lim<-unname(st_bbox(st_geometry(a.lim)))
a.lim<-extent(a.lim[1],a.lim[3],a.lim[2],a.lim[4]) ## set grid limits for ras projection (x-min, x-max, y-min, y-max)
a.fme<-raster(a.lim, res=1e3, crs="+init=EPSG:32754") ## create ras for projection
a<-projectRaster(a, a.fme) ## fuse ras data with frame

## extract coastline
ne_10 <- st_read('../Data/data/ne_10m_admin_0_countries/ne_10m_admin_0_countries.shp')
a.cst<-st_transform(st_crop(ne_10,a.cst), crs = 32754) ## create coastline

## transect -- profiling target
tst<-st_linestring(cbind("lon"=c(132.3, 135.2, 146.4, 149.3), "lat"=c(-1, -3.9, -7.7, -9.8))) ## create transect line
tst<-st_transform(st_sfc(tst, crs=4326), crs = 32754) ## translate class LINESTRING into sfc object & fit projection grids
tst<-st_segmentize(tst, dfMaxLength = 1e3) ## make the line plottable on maps

## extract data for graph-plotting
a.tst<-extract(a, as(tst, "Spatial"), along=T, cellnumber=T)
## export plot
pdf("../results/ppt_trans_NG.pdf")
par(mfrow=c(2,1), mar=c(3,3,1,1), mgp=c(2,1,0))
plot(a) ## annual rainfall data
plot(a.cst, add=T, col=NA, border="grey50") ## coastline
plot(tst, add=T) ## transect
par(mar=c(3,3,1,1)) ## reallocate second plot space for axis to show up
plot(y=a.tst[[1]][,2],x=a.tst[[1]][,1]-min(a.tst[[1]][,1]), type="l", xlab="Distance (m)", ylab="Annual precipitation (mm)")
dev.off()
