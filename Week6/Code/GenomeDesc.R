#!/bin/env R

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: GenomeDesc.R
# Desc: classwork on `bear.csv`
# Input: Rscript GenomeDesc.R
# Output: analysis result output in `result` subdirectory
# Arguments: 0
# Date: Nov 2019

## lib
library(ggplot2)

## grep data from bash
args=(commandArgs(T))

if(length(args) !=1){
	a.nam<-"../Data/bears.csv"
}else{a.nam<-args[1]}
a<-read.csv(a.nam, header=F,stringsAsFactors = F)
colnames(a)=seq(1:dim(a)[2])

## SNP id -- rmb row 1,2 = one individual (Q1)
a.0<-as.data.frame(matrix(nrow=dim(a)[1], ncol=0))
for(i in 1:dim(a)[2]){
	if(length(unique(a[,i]))>1){
		a.0[,(dim(a.0)[2]+1)]<-a[,i]
		colnames(a.0)[dim(a.0)[2]]=colnames(a)[i]
	}
};rm(i)

## SNP freq (Q2)
a.1<-as.data.frame(matrix(0,nrow=4, ncol=dim(a.0)[2]))
colnames(a.1)=colnames(a.0)
row.names(a.1)=c("A","T","C","G")
for(i in 1:dim(a.0)[2]){
	tmp<-table(a.0[,i])
	for(j in 1:length(tmp)){
		a.1[which(names(tmp[j])==row.names(a.1)),i]<-unname(tmp[j])
	}
};rm(i,j,tmp)

## genotype freq (Q3)
a.2<-as.data.frame(matrix(0,nrow=17, ncol=dim(a.0)[2]))
colnames(a.2)=colnames(a.0)
row.names(a.2)=c("AA","TT","CC","GG","AT","TA","AC","CA","AG","GA","TC","CT","TG","GT","CG","GC","htzg")
tmp<-c()
for(i in 1:dim(a.0)[2]){
	for(j in seq(1,dim(a)[1],2)){
		tmp<-c(tmp,paste(a.0[c(j:(j+1)),i],collapse=""))
	}
	tmp<-table(tmp)
	for(k in 1:length(tmp)){
		a.2[which(names(tmp[k])==row.names(a.2)),i]<-unname(tmp[k])
	}
};rm(i,j,k,tmp)
for(i in 1:dim(a.2)[2]){
  a.2[17,i]<-sum(a.2[5:16,i])
};rm(i)
a.2<-a.2[c(1:4,17),]

## homo/heterozygosity calculations (Q4)
a.3<-as.data.frame(matrix(nrow = 2, ncol = dim(a.0)[2]))
row.names(a.3)=c("heterozygosity","homozygosity")
colnames(a.3)=colnames(a.0)
a.3[1,]<-a.2[5,]/(dim(a)[1]/2)
a.3[2,]<-1-a.3[1,]
# a.3[3,]<-prod(a.2[which(a.2[1:4,]!=0),])*2
# a.4[4,]<-sum(a.2[which(a.2[1:4,]!=0),]^2)

## genotype counts (Q5)
a.4<-as.data.frame(matrix(nrow = 5, ncol = dim(a.0)[2]))
row.names(a.4)=row.names(a.2)
colnames(a.4)=colnames(a.0)
for(i in 1:dim(a.4)[1]){
  a.4[i,]<-a.2[i,]/sum(a.2[(1:dim(a.2)[1]),])
};rm(i)

## Chi-sq test on HWE (Q5,6)
a.5<-as.data.frame(matrix(nrow = 4, ncol = dim(a.0)[2]))
row.names(a.5)=c("X^2","df","p.val","inbreed.coef")
colnames(a.5)=colnames(a.0)
for(i in 1:dim(a.2)[2]){
  tmp<-data.frame("Genotype"=row.names(a.2),"freq"=a.2[,i])
  tmp<-tmp[which(tmp[,2]!=0),]
  tmp<-chisq.test(x=tmp$Genotype,y=tmp$freq)
  a.5[1,i]<-unname(tmp$statistic)
  a.5[2,i]<-unname(tmp$parameter)
  a.5[3,i]<-unname(tmp$p.value)
  a.5[4,i]<-1-a.2[5,i]/(prod(a.2[which(a.2[1:4,i]>0),i])*2)
};rm(i,tmp)

## visualizations
bn<-read.table(text = a.nam,sep = "/",stringsAsFactors = F)
bn<-read.table(text = bn[1,dim(bn)[2]],sep = ".",stringsAsFactors = F)[1,1]
pdf(paste0("../results/",bn,".pdf"), )