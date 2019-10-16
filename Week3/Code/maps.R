## key ref <https://eriqande.github.io/rep-res-web/lectures/making-maps-with-R.html>

## library
library(maps);library(ggmap)
library(ggplot2)

load("../Data/GPDDFiltered.RData")

## create world map
map(database = "world")

## map data on global map
m<-map_data("world")
pdf("../Sandbox/MappedMap.pdf",width = 15)
ggplot()+xlab("longitude")+ylab("latitude")+
  geom_map(data = m,map = m,aes(map_id=m$region,x=m$long,y=m$lat),fill="brown")+
  geom_point(aes(x=gpdd$long,y=gpdd$lat))
dev.off()

## commit message: biases towards densely populated N-hemisphere European-based societies