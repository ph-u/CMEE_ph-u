## This function calculates heights of trees given distance of each tree from its base and angle to its top, using the trigonometric formula

## height = distance * tan(radians)

## arguments
## degrees: The angle of elevation of tree
## distance: the distance from base of tree (e.g. metres)

## output
## the heights of the tree, same units as "distance"

TreeHeight <- function(degrees, distance){
  radians<-degrees*pi/180
  height<-distance*tan(radians)
  print(paste("Tree Height is:",height))
  
  return(height)
}
## TreeHeight(37,40)
# args=(commandArgs(T))
