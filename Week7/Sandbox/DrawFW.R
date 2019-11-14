#!/bin/env R

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: DrawFW.R
# Desc: network analysis in R
# Input: Rscript DrawFW.R
# Output: none
# Arguments: 0
# Date: Nov 2019

# library(geomnet) ## plot networks in ggplot2 (useless than base-plot <https://journal.r-project.org/archive/2017/RJ-2017-023/RJ-2017-023.pdf>)
library(network) ## network analysis
library(igraph) ## visualization

## synthetic food web
GenRdmAdjList<-function(N=2, C=.5){
  Ids<-seq(1,N)
  Alst<-matrix(nrow = 0, ncol = 2)
  for(i in 1:N){
    if(runif(1)<C){ ## rnorm(1) if normal distribution wanted
      Alst<-rbind(Alst,sample(Ids,2,replace = F))
    }
  };rm(i)
  return(Alst)
}

## ini variables
MaxN<-30
C<-.75

## adj table
AdjL<-GenRdmAdjList(MaxN, C)
Sps<-unique(as.numeric(AdjL)) ## vertices
SizRan<-c(-10,10)
Sizs<-sample(SizRan,MaxN,replace = T)
# hist(Sizs)
# hist(10^Sizs)

# NodSizs<-10*(Sizs-min(Sizs))/(max(Sizs)-min(Sizs))

Gn<-network(AdjL,Sps,vertex.attrnames = as.character(Sps)) ## links
Gi<-graph.data.frame(AdjL)
NodeSizs<-degree(Gi, mode = "all")*10
Gi.1<-layout_in_circle(Gi, order = order(membership(cluster_optimal(Gi)))) ## circular network graph <https://igraph.org/r/doc/layout_in_circle.html>

## network plotting
## <https://programminghistorian.org/en/lessons/temporal-network-analysis-with-r>
plot(Gi, layout=Gi.1, vertex.size=NodeSizs)
plot(Gn, mode="circle", displaylabels=T) ## mode options <https://www.rdocumentation.org/packages/network/versions/1.13.0/topics/network.layout>
