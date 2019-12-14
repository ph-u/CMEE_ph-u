#!/bin/env R

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: xmas.R
# Desc: Plotting christmas trees
# Input: Rscript xmas.R
# Output: none
# Arguments: 0
# Date: Dec 2019

rm(list=ls())
plot.new()

## colouring
ccol<-data.frame(
				c(rgb(0,.7,.1,1),rgb(.5,.5,.2,1),rgb(1,0,0,1)), 	## green
				c(rgb(.5,1,0,1),rgb(1,0,1,1),rgb(0,0,1,1)), 	## blue
				c(rgb(0,.7,1,1),rgb(.6,0,0,1),rgb(0,0,1,1)), 	## orange
				c(rgb(.5,.5,1,1),rgb(.5,.5,.2,1),rgb(1,.3,1,1)) 	## pink
				)

p=function(x=.5,y=0,d=pi/2,l=.1,r=-1,t=3,col=1){
		limm=1*10^(-t)
		cool=as.vector(ccol[,col])
		lines(c(x,a<-x+cos(d)*l),c(y,b<-y+sin(d)*l),
			col=ifelse(l>limm*5,cool[2],ifelse(l>limm/2,cool[1],cool[3])))
		if(l>limm){
			p(a,b,d,l*.9,-r,t,col)	
			p(a,b,d-.8*r,l*.4,r,t,col)
		}}
text(x=.15,y=.9,label="Merry Christmas 2019\nAnd a Happy New Year!")
for(i in c(1,1:4,1)){p(col=i)};rm(i)
