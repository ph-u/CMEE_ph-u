#!/bin/env Rscript

# Author: ph-u
# Script: Log_1_s2.R
# Desc: slave script on partial dataset for model fitting
# Input: ```Rscript Log_1_s2.R <UqNum> <IterNum>```
# Output: model-fitting analysis result
# Arguments: 2
# Date: Nov 2019

## settings:
## a = raw data (data subset in slave scripts)
## a.~ = data.frames decending from raw data
## f.~ = functions
## v.~ = variables
## i~ = temporary variables

## library
library(minpack.lm) ## NLLS
source("Log_func.R") ## phenological models & others

## take command line order
args=(commandArgs(T))
v.0=as.numeric(args[1]) ## data subset num
v.1=as.numeric(args[2]) ## sampling size

## data in
a<-read.table(paste0("../data/Log_",v.0,"_data.txt"),sep="\t",header = T, stringsAsFactors = F)
a.u<-read.table(paste0("../data/Log_",v.0,"_para.txt"),sep="\t", header = T, stringsAsFactors = F)
a.u$val<-as.numeric(a.u$val)

a.ref<-data.frame("model"=c("Verhulst_(classical)","modified_Gompertz","Baranyi","Buchanan","quadratic","cubic"),
                  "abbr"=c("ve","go","ba","bu","qu","cu"), stringsAsFactors = F)

## sample starting values
cat(paste0("start sample starting values, dataset ",v.0,"\n"))
a.0<-matrix(nrow = v.1, ncol = nrow(a.u)-1+length(which(substr(objects(),1,2)=="f.")))
colnames(a.0)=c("N0", "K", "r.max", "t.lag", a.ref$abbr[1:4])
for(i in 1:4){
  a.0[,i]<-abs(rnorm(nrow(a.0), mean = a.u[i,2], sd = 1))
};rm(i)

i.0<-1
repeat{ ## do trials
  ## check f.ve
  i.1<-try(nlsLM(a$Popn_Change~f.ve(N0,K,r,t=a$Time.hr), data = a, start = list(N0=a.0[i.0,1], K=a.0[i.0,2], r=a.0[i.0,3])),silent = T)
  if(class(i.1)!="try-error"){a.0[i.0,5]<-AIC(i.1)}
  
  ## check f.go
  i.1<-try(nlsLM(a$Popn_Change~f.go(N0,K,r,t=a$Time.hr,tlag), data = a, start = list(N0=a.0[i.0,1], K=a.0[i.0,2], r=a.0[i.0,3], tlag=a.0[i.0,4])),silent = T)
  if(class(i.1)!="try-error"){a.0[i.0,6]<-AIC(i.1)}
  
  ## check f.ba
  i.1<-try(nlsLM(a$Popn_Change~f.ba(N0,K,r,t=a$Time.hr,tlag), data = a, start = list(N0=a.0[i.0,1], K=a.0[i.0,2], r=a.0[i.0,3], tlag=a.0[i.0,4])),silent = T)
  if(class(i.1)!="try-error"){a.0[i.0,7]<-AIC(i.1)}
  
  ## check f.bu
  i.1<-try(nlsLM(a$Popn_Change~f.bu(N0,K,r,t=a$Time.hr,tlag,cst = a$cst), data = a, start = list(N0=a.0[i.0,1], K=a.0[i.0,2], r=a.0[i.0,3], tlag=a.0[i.0,4])),silent = T)
  if(class(i.1)!="try-error"){a.0[i.0,8]<-AIC(i.1)}
  
  ## increase row num
  if(i.0 < dim(a.0)[1]){i.0<-i.0+1}else{break}
};rm(list=ls(pattern="i."))

## check linear models
i.qul<-try(lm(a$Popn_Change~poly(a$Time.hr,2)), silent = T) ## quadratic
i.qu<-ifelse(class(i.qul)!="try-error",AIC(i.qul),NA)

i.cul<-try(lm(a$Popn_Change~poly(a$Time.hr,3)), silent = T) ## cubic
i.cu<-ifelse(class(i.cul)!="try-error",AIC(i.cul),NA)

## extract and compare models AIC
cat(paste0("AIC calculation, dataset ",v.0,"\n"))
AIC<-c(rep(NA,ncol(a.0)-4),i.qu,i.cu)
for(i in 5:8){ ## extract minimal AIC from NLLS trials
  i.0<-suppressWarnings(min(a.0[,i], na.rm = T))
  AIC[i-4]<-ifelse(i.0!=Inf,i.0,NA)
};rm(i, i.0)
a.1<-data.frame("model"=a.ref$abbr,
                "AIC"=AIC,
                "num"=c(5:8,0,1),
                stringsAsFactors = F)
rm(AIC, i.cu, i.qu)

## best parameters to data
v.2<-vector(mode = "list")
for(i in 1:nrow(a.ref)){
  v.ref<-min(a.1$AIC, na.rm = T)+2
  if(is.na(a.1$AIC[i]) | a.1$AIC[i]>v.ref){v.2[[i]]<-NA;next} ## if model contributes nothing, skip
  
  if(i<5){
    i.1<-which(colnames(a.0)==a.ref$abbr[i]) ## select col for model
    i.0<-a.0[,c(1:4,i.1)] ## select parameters & model
    i.0<-i.0[which(i.0[,ncol(i.0)]==a.1$AIC[i]),-ncol(i.0)] ## extract parameters with min AIC
  }else if(i==5){
    i.0<-unname(coef(i.qul)) ## quadratic model
  }else{
    i.0<-unname(coef(i.cul)) ## quadratic model
  }
  
  if(class(i.0)!="matrix"){ ## when 1 entry at lowest AIC / polynomials
    v.2[[i]]<-c(a.1$AIC[i],unname(i.0))
  }else{
    v.2[[i]]<-c(a.1$AIC[i],unname(i.0[1,]))
  }
};rm(list=ls(pattern="i"))
v.2<-as.data.frame(ls2Mtx(v.2)) ## row: a.ref$model; col: min AIC & models [N0, K, r.max, t.lag] / poly [y-int, coef]
v.2[,ncol(v.2)+1]<-v.0  ## data attributes for vertical file combine
row.names(v.2)=a.ref$model

## collect all available data for PCA
i.0<-i.1<-c();for(i in 1:(length(a.ref$abbr)-2)){
  i.0<-c(i.0,rep(a.ref$model[i],nrow(a.0)))
  i.1<-c(i.1,a.0[,i+4])
};rm(i)
a.2<-data.frame(a.0[,1:4], "model"=i.0, "AIC"=i.1)
a.2<-a.2[which(!is.na(a.2$AIC)),]

## data export
write.table(v.2[,c(6,1:5)],paste0("../data/Log_",v.0,"_data.txt"), sep = "\t", quote = F, col.names = F) ## model, AIC, para 1, para 2, para 3, para 4; for Kruskal
if(nrow(a.2)>0){
  a.2$data<-v.0 ## mark source dataset
  write.table(a.2[,c(5,7,6,1:4)],paste0("../data/Log_",v.0,"_daFa.txt"), sep = "\t", quote = F, col.names = F, row.names = F) ## model, AIC, para 1, para 2, para 3, para 4; for PCA
}
cat(paste0("dataset ",v.0," done\n"))
