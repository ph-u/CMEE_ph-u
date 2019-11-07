#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: gis.R
# Desc: classwork for GIS session on 31-Oct to 01-Nov 2019
# Input: Rscript gis.R
# Output: R terminal output
# Arguments: 0
# Date: Oct 2019

## source url: http://rpubs.com/david_orme/GIS_in_R

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
library(rgdal)

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
st_pauls<-st_point(x=c(-.098056, 51.513611)) ## lon, lat
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

## disaggregating rasters
square_disagg<-disaggregate(square, fact=2)
square_disagg_interp<-disaggregate(square, fact=2, method="bilinear")

## reprojecting a raster
uk_pts_WGS84<-st_sfc(st_point(c(-11, 49.5)), st_point(c(2,59)), crs = 4326)
uk_pts_BNG<-st_sfc(st_point(c(-2e5, 0)), st_point(c(7e5, 1e6)), crs = 27700)
uk_grid_WGS84<-st_make_grid(uk_pts_WGS84, cellsize = .5)
uk_grid_BNG<-st_make_grid(uk_pts_BNG, cellsize = 1e5)
uk_grid_BNG_as_WGS84<-st_transform(uk_grid_BNG, 4326)
plot(uk_grid_WGS84, asp=1, border="grey", xlim=c(-13,4))
plot(st_geometry(uk_eire), add=T, border="darkgreen", lwd=2)
plot(uk_grid_BNG_as_WGS84, border="red", add=T)

uk_raster_BNG<-raster(xmn=-2e5, xmx=7e5, ymn=0, ymx=1e6, res=1e5, crs="+init=EPSG:27700")
### <https://stackoverflow.com/questions/15248815/rgdal-package-installation>
uk_raster_BNG_interp<-projectRaster(uk_raster_WGS84, uk_raster_BNG, method = "bilinear")
uk_raster_BNG_ngb<-projectRaster(uk_raster_WGS84, uk_raster_BNG, method = "ngb")
round(values(uk_raster_BNG_interp)[1:9], 2)
values(uk_raster_BNG_ngb)[1:9]
par(mfrow=c(1,3), mar=c(1,1,2,1))
plot(uk_raster_BNG_interp,main="Interpolated", axes=F, legend=F)
plot(uk_raster_BNG_ngb, main="Nearest Neighbour", axes=F, legend=F)

## vec to ras
uk_20km<-raster(xmn=-2e5, xmx=65e4, ymn=0, ymx=1e6, res=2e4, crs="+init=EPSG:27700")
uk_eire_poly_20km<-rasterize(as(uk_eire_BNG, "Spatial"), uk_20km, field="name")
uk_eire_BNG_line<-st_cast(uk_eire_BNG, "LINESTRING")

st_agr(uk_eire_BNG)<-"constant"
uk_eire_BNG_line<-st_cast(uk_eire_BNG, "LINESTRING")
uk_eire_BNG_line_20km<-rasterize(as(uk_eire_BNG_line, "Spatial"), uk_20km, field="name")
uk_eire_BNG_point<-st_cast(st_cast(uk_eire_BNG, "MULTIPOINT"), "POINT")
uk_eire_BNG_point$name<-as.numeric(uk_eire_BNG_point$name)
uk_eire_BNG_point_20km<-rasterize(as(uk_eire_BNG_point, "Spatial"), uk_20km, field="name")
par(mfrow=c(1,3), mar=c(1,1,1,1))
plot(uk_eire_poly_20km, col=viridis(6,alpha = .5), legend=F, axes=F)
plot(st_geometry(uk_eire_BNG), add=T, border="grey")
plot(uk_eire_BNG_line_20km, col=viridis(6,alpha = .5), legend=F, axes=F)
plot(st_geometry(uk_eire_BNG), add=T, border="grey")
plot(uk_eire_BNG_point_20km, col=viridis(6,alpha = .5), legend=F, axes=F)
plot(st_geometry(uk_eire_BNG), add=T, border="grey")

## ras to vec
poly_from_rast<-rasterToPolygons(uk_eire_poly_20km)
poly_from_rast<-as(poly_from_rast, "sf")
## local mac R meltdown
poly_from_rast_dissolve<-rasterToPolygons(uk_eire_poly_20km, dissolve = T)
poly_from_rast_dissolve<-as(poly_from_rast_dissolve, "sf")
points_from_rast<-rasterToPoints(uk_eire_poly_20km)
points_from_rast<-st_as_sf(data.frame(points_from_rast), coords=c("x","y"))
par(mfrow=c(1,3), mar=c(1,1,1,1))
plot(poly_from_rast["layer"], key.pos=NULL, reset=F)
plot(poly_from_rast_dissolve, key.pos=NULL, reset=F)
plot(points_from_rast, key.pos=NULL, reset=F)

## saving vec data
st_write(uk_eire, "../Data/uk_eire_WGS84.shp")
st_write(uk_eire_BNG, "../Data/uk_eire_BNG.shp")
st_write(uk_eire, "../Data/uk_eire_WGS84.geojson")
st_write(uk_eire, "../Data/uk_eire_WGS84.gpkg")
st_write(uk_eire, "../Data/uk_eire_WGS84.json", driver="GdoJSON")

## saving ras data
writeRaster(uk_raster_BNG_interp, "../Data/uk_raster_BNG_interp.tif")
writeRaster(uk_raster_BNG_ngb, "../Data/uk_raster_BNG_ngb.asc", format="ascii")

## load vec data
ne110<-st_read("../Data/ne_110m_admin_0_countries/ne_110m_admin_0_countries.shp")
life_exp<-read.csv("../Data/WHOSIS_000001.csv")
par(mfrow=c(2,1), mar=c(1,1,1,1))
plot(ne_110["GDP_MD_EST"], asp=1, main="Global GDP", logz=T, key.pos=4)
ne110<-merge(ne110, life_exp, by.x="ISO_AJ_EH", by.y="COUNTRY", all.x=T)
bks<-seq(50, 85, by=.25)
plot(ne_110["Numeric$i"], asp=1, main="Global 2016 Life Expectancy (Both sexes)", breaks=bks, pal=viridis, key.pos=4)

so_data<-read.csv("../Data/Southern_Ocean.csv", header=T)
so_data<-st_as_sf(so_data, coords=c("long","lat"), crs=4326)

## load ras data
etopo_25<-raster("../Data/etopo_25.tif")
plot(etopo_25)

bks<-seq(-10e3,6e3, by=250)
land_cols<-terrain.colors(24)
sea_pal<-colorRampPalette(c("darkslateblue","steelblue","paleturquoise"))
sea_cols<-sea_pal(40)
plot(etopo_25, axes=F, breaks=bks, col=c(sea_cols, land_cols), axis.args=list(at=seq(-1e4, 6e3, by=2e3), lab=seq(-10,6,by=2)))

## Ras stacks
tmax<-getData("worldclim", download=T, path="../Data", var="tmax", res=10)
print(tmax)
dir("../Data/wc10")

tmax<-tmax/10
tmax_jan<-tmax[[1]]
tmax_jul<-tmax[[7]]
tmax<-max(tmax)

par(mfrow=c(3,1), mar=c(2,2,1,1))
bks<-seq(-500, 500, length=101)
pal<-colorRampPalette(c("lightblue","grey","firebrick"))
cols<-pal(100)
ax.args<-list(at=seq(-500,500, by=100))
plot(tmax_jan, col=cols, breaks=bks, axis.args=ax.args, main="January maximum temperature")
plot(tmax_jul, col=cols, breaks=bks, axis.args=ax.args, main="July maximum temperature")
plot(tmax_max, col=cols, breaks=bks, axis.args=ax.args, main="Annual maximum temperature")

## crop data
so_extent<-extent(-60, -20, -65, -45)
so_topo<-crop(etopo_25, so_extent)
ne_10<-st_read("../Data/ne_10m_admin_0_countries/ne_10m_admin_0_countries.shp")
st_agr(ne_10)<-"constant"
so_ne_10<-st_crop(ne_10, so_extent)

sea_pal<-colorRampPalette(c("grey30","grey50","grey70"))
plot(so_topo, col=sea_pal(100), asp=1, legend=F)
contour(so_topo, level=c(-2e3, -4e3, -6e3), add=T, col="grey80")
plot(st_geometry(so_ne_10), add=T, col="grey90",border="grey40")
plot(so_data("chlorophyll"), add=T, logz=T, pch=20, cex=2, pal=viridis, border="white", reset=F)
.image_scale(log10(so_data$chlorophyll), col=viridis(18), key.length=.8, key.pos=4, logz=T)

## spatial joining
africa<-subset(ne_110, CONTINENT=="Africa",select=c("ADMIN","POP_EST"))
africa<-st_transform(africa, crs=54030)
mosquito_points<-st_sample(africa, 1e3)
plot(st_geometry(africa), col="khaki")
plot(mosquito_points, col="firebrick", add=T)

mosquito_points<-st_sf(mosquito_points)
mosquito_points<-st_join(mosquito_points, africa["ADMIN"])
plot(st_geometry(africa), col="khaki")
plot(mosquito_points["ADMIN"], add=T)
mosquito_points_agg<-aggregate(mostquito_points, by=list(country=mosquito_points$ADMIN), FUN=length)
names(mosquito_points_agg)[2]<-"n_outbreaks"

africa<-st_join(africa, mosquito_points_agg)
africa$area<-as.numeric(st_area(africa))
par(mfrow=c(1,2), mar=c(3,3,1,1), mgp=c(2,1,0))
plot(n_outbreaks~POP_EST, data=africa, log="xy", ylab="Number of outbreaks", xlab="Population size")
plot(n_outbreaks~area, data=africa, log="xy", ylab="Number of outbreaks", xlab="Area (m2)")

## exercise
alien_xy<-read.csv("../Data/aliens.csv")
alien_xy<-st_as_sf(alien_xy, coords=c("long", "lat"), crs=4326)
alien_xy<-st_join(alien_xy, ne_110["ADMIN"])
aliens_by_country<-aggregate(n_aliens~ADMIN, data=alien_xy, FUN=sum)
ne_110<-merge(ne_110, aliens_by_country, all.x=T)
ne_110$aliens_per_capita<-with(ne_110, n_aliens/POP_EST)

bks<-seq(-8,2,length=101)
pal<-colorRampPalette(c("darkblue", "lightblue", "salmon", "darkred"))
plot(ne_110["aliens_per_capita"], logz=T, breaks=bks, pal=pal, key.pos=4)

## extract data from rasters
uk_eire_rtopo<-raster("../Data/etopo_uk.tif")

uk_eire_detail<-subset(ne_10, ADMIN %in% c("United Kingdom", "Ireland"))
uk_eire_detail_raster<-rasterize(as(uk_eire_detail, "Spatial"), uk_eire_etopo)
uk_eire_elev<-mask(uk_eire_etopo, uk_eire_detail_raster)

par(mfrow=c(1,2), mar=c(3,3,1,1), mgp=c(2,1,0))
plot(uk_eire_etopo, axis.args=list(las=3))
plot(uk_eire_elev, axis.args=list(las=3))
plot(st_geometry(uk_eire_detail), add=T, border="grey")

## ras stat & loc
cellStat(uk_eire, max)
cellStat(uk_eire_elev, quantile)
which.max(uk_eire_elev)
which(uk_eire_elev>110, cells=T)

max_cell<-which.max(uk_eire_elev)
max_xy<-xyFromCell(uk_eire_elev, max_cell)
max_sfc<-st_sfc(st_point(max_xy), crs=4326)
bsl_cell<-which(uk_eire_elev<0, cells=T)
bsl_xy<-xyFromCell(uk_eire_elev, bsl_cell)
bsl_sfc<-st_sfc(st_multipoint(bsl_xy), crs=4326)

plot(uk_eire_elev, axis.args=list(las=3))
plot(max_sfc, add=T, pch=24, bg="red")
plot(bsl_sfc, add=T, pch=25, bg="lightblue", cex=.6)

## extract function
uk_eire_capitals$elev<-extract(uk_eire_capitals)
print(uk_eire_capitals)

uk_eire$mean_height<-extract(uk_eire_elev, uk_eire, fun=mean, na.rm=T)

st_layers("../Data/National_Trials_Pennine_Way.gpx")
pennine_way<-st_read("../Data/National_Trials_Pennine_Way.gpx", layer="routes", query="select * from routes where name='Pennine Way'")

## exercise
pennine_way_BNG<-st_transform(pennine_way, crs=27700)
bng_1km<-raster(xmn=-2e5, xmx=7e5, ymn=0, ymx=1e6, res=1e3, crs="+init=EPSG:27700")
uk_eire_elev_BNG<-projectRaster(uk_eire_elev, bng_1km)

pennine_way_BNG_simple<-st_siimplify(pennine_way_BNG, dTolerance=100)
par(mfrow=c(1,2), mar=c(1,1,1,1))
plot(uk_eire_elev_BNG, xlim=c(3e5, 5e5), ylim=c(3.8e5, 6.3e5), axes=F, legend=F)
plot(st_geometry(pennine_way_BNG), add=T, col="black")
plot(pennine_way_BNG_simple, add=T, col="darkred")
zoom<-extent(3.77e5, 3.89e5, 4.7e5, 4.85e5)
plot(zoom, add=T)
plot(uk_eire_elev_BNG, ext=zoom, axes=F, legend=F)
plot(st_geometry(pennine_way_BNG), add=T, col="black")
plot(pennine_way_BNG_simple, add=T, col="darkred")

pennine_way_trans<-extract(uk_eire_elev_BNG, pennine_way_BNG_simple, along=T, cellnumbers=T)
pennine_way_trans<-pennine_way_trans[[1]]
pennine_way_trans<-data.frame(pennine_way_trans)
pennine_way_xy<-xyFromCell(uk_eire_elev_BNG, pennine_way_trans$cell)
pennine_way_trans<-cbind(pennine_way_trans, pennine_way_xy)

penning_way_trans$dx<-c(0,diff(pennine_way_trans$x))
penning_way_trans$dy<-c(0,diff(pennine_way_trans$y))
pennine_way_trans$distance_from_last<-with(pennine_way_trans, sqrt(dx^2+dy^2))
pennine_way_trans$distance<-cumsum(pennine_way_trans$distance_from_last)
plot(etopo_uk~distance, data=pennine_way_trans, type="l", ylab="Elevation (m)", xlab="Distance (m)")

