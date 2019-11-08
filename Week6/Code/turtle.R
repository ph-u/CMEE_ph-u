#!/bin/env R

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: turtle.R
# Desc: classwork program based on turtle data files
# Input: Rscript turtle.R
# Output: R terminal output
# Arguments: 0
# Date: Nov 2019

## lib
library(ggplot2)

## raw data
a.0<-read.csv("../Data/turtle.csv", header = F)
b.0<-read.csv("../Data/turtle.genotypes.csv",header = F)
c.0<-read.csv("../Data/turtle_markers.csv", header = F)

# ## heterozygosity method
# a.1<-as.data.frame(matrix(nrow = 4, ncol = 3))
# a.1[,1]<-seq(1:4)
# k<-1;for(i in seq(1,dim(a.0)[1],20)){a.1[k,2]<-sum(a.0[i:(i+19),]==0)/(dim(a.0)[1]/4*dim(a.0)[2]);a.1[k,3]<-a.1[k,2]*(1-a.1[k,2]);k<-k+1};rm(i,k)
# 
# ### pairwise & total Fst
# a.2<-as.data.frame(matrix(nrow = factorial(4)/(factorial(2)*factorial(4-2)), ncol = 5))
# colnames(a.2)=c("Pop1","Pop2","Hs","Ht","Fst")
# a.2[,1]<-c(rep(1,4),2,3)
# a.2[,2]<-c(2,3,4,3,4,4)
# for(i in 1:dim(a.2)[1]){
#   a.2[i,3]<-a.1[a.2[i,1],3]+a.1[a.2[i,2],3]
#   a.2[i,4]<-a.2[i,3]+(a.1[a.2[i,1],2]-a.1[a.2[i,2],2])^2/2
#   a.2[i,5]<-(a.2[i,4]-a.2[i,3])/a.2[i,4]
# };rm(i);mean(a.2[,5])
# 
# ## isolation by spatial distance
# a.1$dist.km<-c(5,10,12,50)
# b.1<-hclust(dist(b.0))
# plot(b.1)

## fA on count 1
a.1<-matrix(nrow = 4, ncol = dim(a.0)[2])
for(i in 1:dim(a.1)[1]){for(j in 1:dim(a.1)[2]){a.1[i,j]<-sum(a.0[((i-1)*20+1):(i*20),j])/20}};rm(i,j)
a.2<-a.1*(1-a.1) ## Hs
a.3<-a.4<-matrix(nrow = factorial(4)/(factorial(2)*factorial(4-2)), ncol = dim(a.2)[2])
a.r<-data.frame("First"=c(rep(1,3),2,2,3),"Second"=c(2,3,4,3,4,4))
for(i in 1:dim(a.r)[1]){
  i.1<-a.r[i,1];i.2<-a.r[i,2] ## set pairwise comparison targets
  a.3[i,]<-a.2[i.1,]+a.2[i.2,] ## Hs pairwise
  a.4[i,]<-a.3[i,]+(a.1[i.1,]-a.1[i.2,])^2/2 ## Ht pairwise
};rm(i,i.1,i.2)
a.5<-(a.4-a.3)/a.4 ## Fst

## spatial dist
a.ref<-data.frame(seq(1,4),c(5,10,12,50))
for(i in 1:dim(a.r)[1]){
  a.r$dist[i]<-a.ref[which(a.r$First[i]==a.ref[,1]),2]+a.ref[which(a.r$Second[i]==a.ref[,1]),2]};rm(i)

for(i in 1:dim(a.r)[1]){ ## print subpop Fst result
  a.r$den[i]<-mean(as.numeric(as.character(a.5[i,])), na.rm = T) ## Fst
  print(paste0(LETTERS[a.r[i,1]]," vs ",LETTERS[a.r[i,2]]," Fst: ",round(a.r$den[i],4)))
  };rm(i)

## plot -- real phy-tree: [A,[B, [C,D]]]; D = A + ^B + C; heavy genetic exchange
ggplot(data = a.r, aes(x=a.r$dist, y=a.r$den))+xlab("Spatial Dist. (km)")+ylab("Pairwise genetic dist (Pairwise Fst)")+theme_bw()+geom_point()

## stat test Spearman correlation
cor.test(y=a.r$den, x=a.r$dist, method = "spearman")
