#!/bin/env R

# Author: ph-u
# Script: gecko.R
# Desc: classwork program based on gecko data files
# Input: Rscript gecko.R
# Output: R terminal output
# Arguments: 0
# Date: Nov 2019

## lib

## raw
a.file<-list.files(path = "../Data/", pattern = "_gec")
for(i in 1:length(a.file)){
  assign(paste0("a.",substr(a.file[i],1,3)),read.csv(paste0("../Data/",a.file[i]),header = F, stringsAsFactors = F))
};rm(i)

## data handling
a<-list(a.ben, a.leo, a.wes)
rm(list=ls(pattern="a."))

## list parallel data filtering
for(i in 1:length(a)){
  print(i)
  for(j in 1:dim(a[[i]])[2]){
    a[[i]][,j]<-as.character(a[[i]][,j])
  }
  a[[i]][a[[i]] == "TRUE"] <- "T"
  
  # ## prepare data filter
  # a.0<-vector(mode = "list", length = length(a))
  # for(j in 1:length(a.0)){
  #   a.0[[j]]<-as.data.frame(matrix(nrow = (dim(a[[i]])[1]/2), ncol = 0))
  # };rm(j)
  # 
  # ## -SNP
  # for(j in 1:dim(a[[i]])[2]){
  #   cat(paste0("-SNP for ","a[[",i,"]] col ",j,"\n"))
  #   tmp<-c()
  #   for(k in seq(1,dim(a[[i]])[1],2)){
  #     if(isTRUE(a[[i]][k,j] == a[[i]][(k+1),j])){
  #       tmp<-c(tmp,a[[i]][k,j])
  #       tmp.nam<-colnames(a[[i]][j])
  #     }else{
  #       break
  #     }
  #   } ## k loop
  #   if(length(tmp)==dim(a.0[[i]])[1]){
  #     cat(paste0("Got one for ","a[[",i,"]]\n"))
  #     a.0[[i]][,(dim(a.0[[i]])[2]+1)]<-tmp
  #     colnames(a.0[[i]])[dim(a.0[[i]])[2]]=tmp.nam
  #     rm(tmp.nam)
  #   }
  # } ## j loop
};rm(i) #rm(i,j,k) ## i loop

## do it manually, 4 CPU can't handle the data in one go -- !SNP
## bent-toed gecko
a.ben<-as.data.frame(matrix(nrow = (dim(a[[1]])[1]/2), ncol = 0))
for(i in 1:dim(a[[1]])[2]){
  if(i%%1000==0){cat(paste0("doing col ",i/1e3,"K out of ",dim(a[[1]])[2]/1e3,"K\n"))}
  tmp<-c()
  tmp.n<-colnames(a[[1]][i])
  for(j in seq(1,dim(a[[1]])[1],2)){
    if(a[[1]][j,i] == a[[1]][(j+1),i]){tmp<-c(tmp,a[[1]][j,i])}else{break}
  }
  if(length(tmp)==dim(a.ben)[1]){
    a.ben[,(dim(a.ben)[2]+1)]<-tmp
    colnames(a.ben)[dim(a.ben)[2]]<-tmp.n
  }
};rm(i,j,tmp,tmp.n)
for(i in 1:dim(a.ben)[1]){
  cat(paste0("doing row ",i," out of ",dim(a.ben)[1],"\n"))
  for(j in 1:dim(a.ben)[2]){
  if(j%%1e3==0){cat(paste0("doing col ",j/1e3,"K out of ",dim(a.ben)[2]/1e3,"K\n"))}
    if(a.ben[1,j]!=a.ben[i,j]){print("no")}
  }
};rm(i,j)

## leopard gecko
a.leo<-as.data.frame(matrix(nrow = (dim(a[[2]])[1]/2), ncol = 0))
for(i in 1:dim(a[[2]])[2]){
  if(i%%1000==0){cat(paste0("doing col ",i/1e3,"K out of ",dim(a[[2]])[2]/1e3,"K\n"))}
  tmp<-c()
  tmp.n<-colnames(a[[2]][i])
  for(j in seq(1,dim(a[[2]])[1],2)){
    if(a[[2]][j,i] == a[[2]][(j+1),i]){tmp<-c(tmp,a[[2]][j,i])}else{break}
  }
  if(length(tmp)==dim(a.leo)[1]){
    a.leo[,(dim(a.leo)[2]+1)]<-tmp
    colnames(a.leo)[dim(a.leo)[2]]<-tmp.n
  }
};rm(i,j,tmp,tmp.n)
for(i in 1:dim(a.leo)[1]){
  cat(paste0("doing row ",i," out of ",dim(a.leo)[1],"\n"))
  for(j in 1:dim(a.leo)[2]){
    if(j%%1e3==0){cat(paste0("doing col ",j/1e3,"K out of ",dim(a.leo)[2]/1e3,"K\n"))}
    if(a.leo[1,j]!=a.leo[i,j]){print("no")}
  }
};rm(i,j)
tmp<-c();for(i in 1:dim(a.leo)[1]){
  tmp<-c(tmp,paste0(a.leo[i,],collapse = ""))
};rm(i);
str(as.factor(tmp))

## western-banded gecko
a.wes<-as.data.frame(matrix(nrow = (dim(a[[3]])[1]/2), ncol = 0))
for(i in 1:dim(a[[3]])[2]){
  if(i%%1000==0){cat(paste0("doing col ",i/1e3,"K out of ",dim(a[[3]])[2]/1e3,"K\n"))}
  tmp<-c()
  tmp.n<-colnames(a[[3]][i])
  for(j in seq(1,dim(a[[3]])[1],2)){
    if(a[[3]][j,i] == a[[3]][(j+1),i]){tmp<-c(tmp,a[[3]][j,i])}else{break}
  }
  if(length(tmp)==dim(a.wes)[1]){
    a.wes[,(dim(a.wes)[2]+1)]<-tmp
    colnames(a.wes)[dim(a.wes)[2]]<-tmp.n
  }
};rm(i,j,tmp,tmp.n)
for(i in 1:dim(a.wes)[1]){
  cat(paste0("doing row ",i," out of ",dim(a.wes)[1],"\n"))
  for(j in 1:dim(a.wes)[2]){
    if(j%%1e3==0){cat(paste0("doing col ",j/1e3,"K out of ",dim(a.wes)[2]/1e3,"K\n"))}
    if(a.wes[1,j]!=a.wes[i,j]){print("no")}
  }
};rm(i,j)

## grep the majority with topology [a.leo, [a.ben, a.wes]]
## use "the majority rules" assumption (a.leo only)
a.com<-merge(a.ben[1,],a.wes[1,], all = T)
d.BW<-sum(is.na(a.com))/dim(a.com)[2]
cat(paste0("divergence of bent-toed and western banded geckos is ",d.BW,"\n"))
a.com<-merge(a.com,a.leo[2,], all = T)
d.CL<-sum(is.na(a.com))/dim(a.com)[2]
cat(paste0("divergence of leopard and common ancestor of the other geckos is ",d.CL,"\n"))
## div time for later species
cat(paste0("divergence time of bent-toed and western banded geckos is ",round(d.BW/(d.CL/30),2)," Mya\n"))
