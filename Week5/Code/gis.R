#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: gis.R
# Desc: classwork for GIS session on 31-Oct to 01-Nov 2019
# Input: Rscript gis.R
# Output: R terminal output
# Arguments: 0
# Date: Oct 2019

## lib
## LIB UDUNITS2-DEV: unit conversion
## LIB GDAL-DEV: library for spatial database
## PROJ.4: geo-projection
## LWGEOM: light-weight geometric engine, manipulate vector data
## GEOS: geometric package
library(raster)
library(sf)
library(viridis)
library(units)

## Vec from coordinates
pop_dens<-data.frame(n_km2=c(260,67,151,4500,133),country=c("England","Scotland","Wales","London","Northern Ireland"))
scotland<-rbind(c(-5, 58.6), c(-3, 58.6), c(-4, 57.6),c(-1.5, 57.6), c(-2, 55.8), c(-3, 55),c(-5, 55), c(-6, 56), c(-5, 58.6))
england <- rbind(c(-2,55.8),c(0.5, 52.8), c(1.6, 52.8),c(0.7, 50.7), c(-5.7,50), c(-2.7, 51.5),c(-3, 53.4),c(-3, 55), c(-2,55.8))
wales <- rbind(c(-2.5, 51.3), c(-5.3,51.8), c(-4.5, 53.4),c(-2.8, 53.4),  c(-2.5, 51.3))
ireland <- rbind(c(-10,51.5), c(-10, 54.2), c(-7.5, 55.3),c(-5.9, 55.3), c(-5.9, 52.2), c(-10,51.5))
scotland<-st_polygon(list(scotland))
england <- st_polygon(list(england))
wales <- st_polygon(list(wales))
ireland <- st_polygon(list(ireland))

uk_eire<-st_sfc(wales, england, scotland, ireland, crs = 4326)
uk_eire_capitals <- data.frame(long= c(-0.1, -3.2, -3.2, -6.0, -6.25), lat=c(51.5, 51.5, 55.8, 54.6, 53.30), name=c('London', 'Cardiff', 'Edinburgh', 'Belfast', 'Dublin'))
uk_eire_capitals <- st_as_sf(uk_eire_capitals, coords=c('long','lat'), crs=4326)

## Vec geometry operations
st_pauls<-st_point(x=c(-.098056, 51.513611))
london<-st_buffer(st_pauls, .25)
england_no_london<-st_difference(england, london)

lengths(scotland)
lengths(england_no_london)

wales<-st_difference(wales, england)

ni_area<-st_polygon(list(cbind(x=c(-8.1, -6, -5, -6, -8.1), y=c(54.4, 56, 55, 54, 54.4))))
northern_ireland<-st_intersection(ireland, ni_area)
eire<-st_difference(ireland, ni_area)

uk_eire<-st_sfc(wales, england_no_london, scotland, london, northern_ireland, eire, crs = 4326)

## features & geometries
uk_country<-st_union(uk_eire[-6])

par(mfrow=c(1,2), mar=c(3,3,1,1))
plot(uk_eire, asp=1, col=rainbow(6))
plot(st_geometry(uk_eire_capitals), add=T)
plot(uk_country, asp=1, col="lightblue")

## vec data & attributes
uk_eire<-st_sf(name=c("Wales","England","Scotland","London","Northern Ireland","Eire"), geometry=uk_eire)
plot(uk_eire, asp=1)
uk_eire$capital<-c("London","Edinburgh","Cardiff",NA,"Belfast","Dublin")
uk_eire<-merge(uk_eire, pop_dens, by.x="name", by.y="country", all.x=T)

## spatial attributes
uk_eire_centroids<-st_centroid(uk_eire)
st_coordinates(uk_eire_centroids)

uk_eire$area<-st_area(uk_eire)
uk_eire$length<-st_length(uk_eire)

uk_eire$area<-set_units(uk_eire$area, "km^2")
uk_eire$length<-set_units(uk_eire$length, "km")
st_distance(uk_eire)
st_distance(uk_eire_centroids)

## plot sf objects
plot(uk_eire["n_km2"], asp=1, logz=T)

## reprojecting vector data
uk_eire_BNG<-st_transform(uk_eire, 27700)
st_bbox(uk_eire)
st_bbox(uk_eire_BNG)
uk_eire_UTM50N<-st_transform(uk_eire, 32650)
par(mfrow=c(1,3), mar=c(3,3,1,1))
plot(st_geometry(uk_eire), asp=1, axes=T, main="WGS 84")
plot(st_geometry(uk_eire_BNG), axes=TRUE, main='OSGB 1936 / BNG')
plot(st_geometry(uk_eire_UTM50N), axes=TRUE, main='UTM 50N')

## degrees not constant
st_pauls<-st_sfc(st_pauls, crs = 4326)
one_deg_west_pt<-st_sfc(st_pauls-c(1,0), crs=4326)
one_deg_north_pt<-st_sfc(st_pauls+c(0,1), crs = 4326)
st_distance(st_pauls, one_deg_west_pt)
st_distance(st_pauls, one_deg_north_pt)
st_distance(st_transform(st_pauls, 27700), st_transform(one_deg_west_pt, 27700))

## exercise
## 1. trans to BNG, buffer 25km
london_bng<-st_buffer(st_transform(st_pauls, 27700), 25e3)
england_not_london_bng<-st_difference(st_transform(st_sfc(england, crs = 4326), 27700), london_bng)
others_bng<-st_transform(st_sfc(eire, northern_ireland, scotland, wales, crs=4326), 27700)
corrected<-c(others_bng, london_bng, england_not_london_bng)
par(mar=c(3,3,1,1))
plot(corrected, main="25km radius London", axes=T)

## rasters
uk_raster_WGS84<-raster(xmn=-11, xmx=2, ymn=49.5, ymx=59, res=.5, crs="+init=EPSG:4326")
hasValues(uk_raster_WGS84)
values(uk_raster_WGS84)<-seq(length(uk_raster_WGS84))
par(mfrow=c(1,1))
plot(uk_raster_WGS84)
plot(st_geometry(uk_eire), add=T, border="black", lwd=2, col="#FFFFFF44")

## changing raster res
m<-matrix(c(1,1,3,3,1,2,4,3,5,5,7,8,6,6,7,7), ncol = 4, byrow = T)
square<-raster(m)
square_agg_mean<-aggregate(square, fact=2, fun=mean)
values(square_agg_mean)
square_agg_max<-aggregate(square, fact=2, fun=max)
values(square_agg_max)
square_agg_modal<-aggregate(square, fact=2, fun=modal)
values(square_agg_modal)
