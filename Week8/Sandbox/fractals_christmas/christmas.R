#!/bin/env R

turtle <- function(start_position=c(0,0), direction=.03, length=.1)  {
  a<-c(start_position[1]+length*cos(direction),start_position[2]+length*sin(direction))
  suppressWarnings(lines(x=c(start_position[1],a[1]), y=c(start_position[2],a[2]), add=T, cex=.01))
  return(a) # you should return your endpoint here.
}

fern <- function(start_position=c(.5,0), direction=90*2*pi/360, length=.1, LR=1, pp, pp1=0, pp2)  {
  a<-turtle(start_position,direction,ifelse(pp1==0, length*.1,length))
		  if(pp2==0){
		  if(pp==1 | pp==5){
				  colouring<-c(rgb(0,.7,.1,1),rgb(.5,.5,.2,1),rgb(1,0,0,1)) ## leaves, branches, tips
		  }else if(pp==2){
				  colouring<-c(rgb(.5,1,0,1),rgb(1,0,1,1),rgb(0,0,1,1)) ## blue-themed
		  }else if(pp==3){
				  colouring<-c(rgb(0,.7,1,1),rgb(.6,0,0,1),rgb(1,.5,0,1)) ## orange-themed
		  }else if(pp==4){
				  colouring<-c(rgb(.5,.5,1,1),rgb(.5,.5,.2,1),rgb(1,.3,1,1)) ## pink-themed
		  }}else{
		  if(pp==1 | pp==4){
				  colouring<-c(rgb(0,.7,.1,1),rgb(.5,.5,.2,1),rgb(1,0,0,1)) ## leaves, branches, tips
		  }else if(pp==2){
				  colouring<-c(rgb(0,.7,.1,1),rgb(.5,.5,.2,1),rgb(0,0,1,1)) ## leaves, branches, tips
		  }else if(pp==3){
				  colouring<-c(rgb(0,.7,.1,1),rgb(.5,.5,.2,1),rgb(1,.5,0,1)) ## leaves, branches, tips
		  }}
  # colouring<-c(rgb(.5,.5,1,1),rgb(.5,.5,.2,1),rgb(1,.3,1,.6)) ## pink variation
  ccol<-ifelse(length>5e-3,colouring[2],ifelse(length>1.2e-3,colouring[1],colouring[3]))
  suppressWarnings(lines(x=c(start_position[1],a[1]), y=c(start_position[2],a[2]), add=T, col=ccol))

  ## parameters mod
  d<-direction+ifelse(LR<1,pi/4,ifelse(LR>1,-pi/4,0))
  L<-length*ifelse(LR==1,.87,.38)

  if(L > 1e-3){for(i in 0:2){fern(a,d,L,i,pp,1)}}
}

draw_fern <- function(k)  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  plot.new()
  for(i in 1:5){
		  fern(pp=i,pp2=k)
  }
}

for(i in 0:1){
	draw_fern(i)
}
