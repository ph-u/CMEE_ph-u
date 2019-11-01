#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: fish_Fiji.R
# Desc: 2nd homework for GIS session on 31-Oct to 01-Nov 2019
# Input: Rscript fish_Fiji.R
# Output: R terminal output
# Arguments: 0
# Date: Nov 2019

## source url: http://rpubs.com/david_orme/GIS_in_R

## lib
library(raster)
library(sf)
library(viridis)
library(units)
library(rgdal)
library(gdistance)
library(openxlsx)

## raw
a<-getData("GADM", country="FJI", level=2, path = "../Data/")
a.vill<-readWorkbook("../Data/FishingPressure.xlsx", "Villages")
a.site<-readWorkbook("../Data/FishingPressure.xlsx", "Field sites", startRow = 3)

## tech transformation
a<-st_as_sf(a)
a.0<-a[which(a$NAME_2=="Kadavu"),] ## subset necessary data
a.vill<-st_as_sf(a.vill, coords = c("long","lat"), crs=4326)
a.site<-st_as_sf(a.site, coords = c("Long","Lat"), crs=4326)

## UTM60S grid projection
a.0<-st_transform(a.0, 32760)
a.vill<-st_transform(a.vill, 32760)
a.site<-st_transform(a.site, 32760)

## plot raw
par(mfrow=c(1,1))
plot(st_geometry(a.site), axes=T, col="blue")
plot(st_geometry(a.vill), add=T, col="red")
plot(st_geometry(a.0), add=T) ## also save x- & y-lims for cost surface

a.1<-unname(st_bbox(st_geometry(a.0)))

{res<-100 ## cost surface creation
  a.1<-raster(xmn=a.1[1], xmx=a.1[3], ymn=a.1[2], ymx=a.1[4], crs=32760, res=res)
  a.0.poly<-rasterize(as(a.0, "Spatial"), a.1, field=1, background=0)
  a.0.line<-rasterize(as(st_cast(a.0, "MULTILINESTRING"), "Spatial"), a.1, field=1, background=0)
  a.1.sea<-(!a.0.poly)|a.0.line
  a.1.sea[a.1.sea==0]<-NA
  a.1.sea[!is.na(a.1.sea)]<-1
  par(mfrow=c(1,1))
  plot(a.1.sea)
}

## nearest coastline
a.cst<-st_nearest_points(a.vill, st_cast(a.0, "MULTILINESTRING"))
a.lpt<-st_cast(st_line_sample(a.cst, sample = 1), "POINT")
par(mfrow=c(1,1))
plot(st_geometry(a.0), xlim=c(616e3, 618e3), ylim=c(7889e3, 7891e3), col="khaki")
plot(st_geometry(a.vill), add=T, col="firebrick")
plot(a.cst, add=T, col="grey")
plot(a.lpt, add=T, col="darkgreen")

## add a.lpt to a.vill
a.vill$launch_points<-a.lpt
st_geometry(a.vill)<-"launch_points"

## distances
a.tst<-transition(a.1.sea, transitionFunction = mean, directions = 8)
a.tst<-geoCorrection(a.tst)
cost<-costDistance(a.tst, as(a.vill, "Spatial"), as(a.site, "Spatial"))

## assign villages to sites
a.vill$nearest_site_index<-apply(cost, 1, which.min)
a.vill$nearest_site_name<-a.site$Name[a.vill$nearest_site_index]
site.load<-aggregate(a.vill$building_count ~ a.vill$nearest_site_name, data=a.vill, FUN=sum)
colnames(site.load)=c(colnames(a.site)[2], "nearest_site_name")
a.site<-merge(a.site, site.load, by.x="Name", all.x=T)

## plot all
plot(st_geometry(a.0))
plot(a.vill['nearest_site_name'], add=T, cex=log10(a.vill$building_count))
plot(st_geometry(a.site), add=T, col="red")
labels<-with(a.vill, paste0(a.vill$village,": ", a.vill$building_count))
text(st_coordinates(a.site), label=labels, cex=.7, pos=c(3,3,3,3,3,3,1))
for(i in seq(nrow(a.vill))){
  v<-as(a.vill[i,], "Spatial")
  v.site<-as(a.site[v$nearest_site_index,], "Spatial")
  # v.jony<-shortestPath(a.tst, v, v.site, output="SpatislLines") ## pkg error
  # plot(st_as_sfc(v.jony), add=T, col="grey")
};rm(i)
