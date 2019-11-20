#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Log_0.R
# Desc: Miniproject on `LogisticGrowthMetaData.csv`
# Input: ```Rscript Log_0.R```
# Output: results
# Arguments: 0
# Date: Nov 2019

# setwd("/Volumes/HPM-000/Academic/Masters/ICL_CMEE/00_course/CMEECourseWork_pmH/MiniProject/code/")

## library
library(ggplot2)
library(scales)
library(minpack.lm)
library(reshape2)

## background settings
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#e79f00", "#9ad0f3", "#F0E442", "#999999", "#cccccc", "#6633ff", "#00FFCC", "#0066cc")## initial 8 colour (color-blinded)
a.pl<-c("Verhulst (classical)","modified Gompertz","Baranyi","Buchanan")

## raw input & data cleaning
a<-read.csv("../data/LogisticGrowthData.csv", header = T, stringsAsFactors = F)[,-1]
a<-a[,c(3,6:9,1,2,5)]
colnames(a)=c("Temp.C","clade","substrate","replicate","SourceRef","Time.hr","Popn_Change","Popn_DataUnit")
a$Time.hr<-abs(a$Time.hr) ## convert -ve times
a$clade<-gsub(".1|.2|..RDA.R.","",a$clade) ## condense spp names
a$clade<-gsub("spp.|sp.","sp",a$clade) ## condense spp names
a$clade<-gsub("[.]"," ",a$clade) ## condense spp names
a$clade<-gsub("77|88|Strain 97|StrainCYA28|subsp Carotovorum Pc","",a$clade) ## rm specific unnecessary things for better spp categorizing
a$clade<-trimws(a$clade) ## condense spp names (rm white spaces from both ends)

write.table(a, "../data/Log_Data.txt",sep="\t", quote=F)

## get unique datasets
a.0<-as.data.frame(matrix(nrow=0, ncol=(dim(a)[2]-2)))
for(i in 1:dim(a)[1]){
  if(i==1){
    v.1<-unique(a.0[,1])
    v.2<-unique(a.0[,2])
    v.3<-unique(a.0[,3])
    v.4<-unique(a.0[,4])
    v.5<-unique(a.0[,5])
    v.6<-unique(a.0[,6])
  }
  if(!(a[i,1] %in% v.1 & a[i,2] %in% v.2 & a[i,3] %in% v.3 & a[i,4] %in% v.4 & a[i,5] %in% v.5 & a[i,8] %in% v.6)){
    a.0<-rbind(a.0,a[i,-c(6:7)])
    v.1<-unique(a.0[,1])
    v.2<-unique(a.0[,2])
    v.3<-unique(a.0[,3])
    v.4<-unique(a.0[,4])
    v.5<-unique(a.0[,5])
    v.6<-unique(a.0[,6])
  }
};rm(i);rm(list=ls(pattern="v."))
write.table(a.0, "../data/Log_Uq.txt",sep="\t", quote=F)

## plot prep datasets
for(i in 1:dim(a.0)[1]){
  a.p<-a[which(a$Temp.C==a.0$Temp.C[i] &
                 a$clade==a.0$clade[i] &
                 a$substrate==a.0$substrate[i] &
                 a$replicate==a.0$replicate[i] &
                 a$SourceRef==a.0$SourceRef[i] &
                 a$Popn_DataUnit==a.0$Popn_DataUnit[i]),]
  if(i<10){i.1<-"00"}else if(i<100){i.1<-"0"}else{i.1<-""}
  pdf(paste0("Log_PreGraph/",i.1,i,".pdf"))
  print(ggplot()+theme_bw()+
          xlab("Time (hr)")+ylab(paste0("Population Change (",unique(a.p$Popn_DataUnit),")"))+
          ggtitle(paste0(a.0$Temp.C[i],"_",a.0$clade[i],"_",a.0$substrate[i],"_",a.0$replicate[i],"_",a.0$Popn_DataUnit[i],"_",dim(a.p)[1]))+
          geom_point(aes(x=a.p$Time.hr, y=a.p$Popn_Change), shape=4, colour="red")+
          geom_text(aes(label=a.0$SourceRef[i],x=max(a.p$Time.hr)-min(a.p$Time.hr), y=max(a.p$Popn_Change)-min(a.p$Popn_Change)), size=2)+
          scale_y_continuous(labels = scientific,
                             trans = "log10",
                             oob = rescale_none))
  dev.off()
};rm(i,a.p,i.1)

## get starting values
# plot(log(a.p$Popn_Change)~a.p$Time.hr, xlim=c(0,350), ylim=c(0,9), pch=4)

### functions
func_log0<-function(N0,K,r,t){
  ## traditional Logistic equation: y~x
  Nt=N0*K*exp(r*t)/(K+N0*(exp(r*t)-1))
  return(Nt)}

func_gom<-function(N0,K,r,t,ld){
  ## modified Gompertz model, initial 
  A=log(K/N0)
  Nt=exp(A*exp(-exp(r*exp(1)/A*(ld-t)+1))*1.1) ## mod: exp(f(t)*1.1)
  return(Nt)}

func_bar<-function(N0,K,r, t,tlag){
  ## Baranyi model
  h0=1/(exp(tlag*r)-1)
  At=t+1/r*log((exp(-r*t)+h0)/(1+h0))
  Nt=(N0+r*At-exp(log(1+(exp(r*At)-1)/exp(K-N0))))*4 ## mod: f(exp(f(t|growth)))*4
  return(Nt)}

func_buc<-function(N0,K,r,t,tlag,cst){
  ## Buchanan model / three-phase logistic model
  a.010=(cst-1)%%2 ## make only log phase valid in growth rate
  a.001=ceiling(cst%%2.5%%1) ## make only final phase valid
  Nt=N0+a.001*(K-N0)+a.010*exp(r*(t-tlag)) ## mod: exp(f(t|growth))
  return(Nt)}

### parameters
for(i in 1:dim(a.0)[1]){
  a.p0<-a.p<-a[which(a$Temp.C==a.0$Temp.C[i] &
                       a$clade==a.0$clade[i] &
                       a$substrate==a.0$substrate[i] &
                       a$replicate==a.0$replicate[i] &
                       a$SourceRef==a.0$SourceRef[i] &
                       a$Popn_DataUnit==a.0$Popn_DataUnit[i]),]
  
  a.p$Popn_Change<-ifelse(a.p$Popn_Change<0,0,a.p$Popn_Change)
  
  p.N0<-min(a.p$Popn_Change) ## N0
  p.KK<-max(a.p$Popn_Change) ## K
  
  # a.p<-a.p0
  r.0<-r.1<-0;i.1<-1;repeat{ ## loop screening for r.max
    r.t<-ifelse(max(a.p$Popn_Change)-min(a.p$Popn_Change) < 1,0,1)
    if(isTRUE(r.t==0)){break}
    
    a.lm<-lm(log(a.p$Popn_Change+1)~a.p$Time.hr)
    a.lmf<-summary(a.lm)$adj.r.squared
    a.lmc<-summary(a.lm)$coefficients[2,1]
    if(isTRUE(a.lmf > r.0) & isTRUE(a.lmc > r.1)){
      a.p1<-a.p
      r.0<-a.lmf
    }
    if((max(a.p$Time.hr)-min(a.p$Time.hr)) < 5 & i.1 < 2){a.p<-a.p1;i.1<-2}
    if((max(a.p$Time.hr)-min(a.p$Time.hr)) < 5 & i.1 == 2){a.p<-a.p1;rm(i.1,a.p1,a.lm,a.lmc,a.lmf,r.0,r.1);break}
    if(isTRUE(i.1==1)){
      a.p<-a.p[-which(a.p$Time.hr > (max(a.p$Time.hr)*(1-.05))),]
    }else{
      a.p<-a.p[-which(a.p$Time.hr < (min(a.p$Time.hr)*(1+.05))),]
    }
  }
  # plot(log(a.p0$Popn_Change+1)~a.p0$Time.hr, xlim=c(0,600), ylim=c(0,9), pch=4, xlab="Time (hr)", ylab="log Population Change +1")
  if(r.t>0){
    a.lm<-lm(log(a.p$Popn_Change+1)~a.p$Time.hr)
    p.cf<-summary(a.lm)$coefficients
    p.rm<-p.cf[2,1] ## r.max
    p.tl<--p.cf[1,1]/p.rm ## t-lag
    # lines(unname(a.lm$coefficients[1])+a.p0$Time.hr*unname(a.lm$coefficients[2])~a.p0$Time.hr, col="red", add=T)
  }else{ ## if population is not changing
    p.rm<-p.tl<-0
    # lines(y=rep(0,dim(a.p0)[1]), x=a.p0$Time.hr, col="red", add=T)
  }
  p.Kl<-max(a.p$Time.hr) ## t achieving K
  
  ## setting real clusters
  a.p0$cst<-ifelse(a.p0$Time.hr < p.tl,1,ifelse(a.p0$Time.hr > p.Kl,3,2))
  a.p<-a.p0
  
  {### NLLS fitting
    ii<-0
    th.1df<-as.data.frame(matrix(nrow = 0, ncol = 7))
    th.2df<-th.3df<-th.4df<-as.data.frame(matrix(nrow = 0, ncol = 8))
  };repeat{
    v.N0<-rnorm(1,mean = p.N0, sd=1)
    v.KK<-rnorm(1,mean = p.KK, sd=1)
    v.rm<-rnorm(1,mean = p.rm, sd=1)
    v.tl<-rnorm(1,mean = p.tl, sd=1)
    
    th.1<-try(nlsLM(a.p$Popn_Change~func_log0(N0, K, r, t=a.p$Time.hr), data = a.p, start = list(N0=v.N0, K=v.KK, r=v.rm)),silent = T)
    if(class(th.1)!="try-error"){
      th.1df<-rbind(th.1df,c(unname(coef(th.1)),deviance(th.1),th.1$convInfo$finIter,th.1$convInfo$finTol,AIC(th.1)))
    }
    
    th.2<-try(nlsLM(a.p$Popn_Change~func_gom(N0, K, r, t=a.p$Time.hr, ld), data = a.p, start = list(N0=v.N0, K=v.KK, r=v.rm, ld=v.tl)),silent = T)
    if(class(th.2)!="try-error"){
      th.2df<-rbind(th.2df,c(unname(coef(th.2)),deviance(th.2),th.2$convInfo$finIter,th.2$convInfo$finTol,AIC(th.2)))
    }
    
    th.3<-try(nlsLM(a.p$Popn_Change~func_bar(N0, K, r, t=a.p$Time.hr, tlag), data = a.p, start = list(N0=v.N0, K=v.KK, r=v.rm, tlag=v.tl)),silent = T)
    if(class(th.3)!="try-error"){
      th.3df<-rbind(th.3df,c(unname(coef(th.3)),deviance(th.3),th.3$convInfo$finIter,th.3$convInfo$finTol,AIC(th.3)))
    }
    
    th.4<-try(nlsLM(a.p$Popn_Change~func_buc(N0, K, r, t=a.p$Time.hr, tlag, cst = a.p$cst), data = a.p, start = list(N0=v.N0, K=v.KK, r=v.rm, tlag=v.tl)),silent = T)
    if(class(th.4)!="try-error"){
      th.4df<-rbind(th.4df,c(unname(coef(th.4)),deviance(th.4),th.4$convInfo$finIter,th.4$convInfo$finTol,AIC(th.4)))
    }
    
    if(ii>1e1){break}
    if(ii%%1e3==0){cat(paste0(ii/1e3,"K trials\n"))}
    ii<-ii+1
  };rm(ii);colnames(th.1df)=c("N0","K","r","SS","iter","tol","AIC");colnames(th.2df)=colnames(th.3df)=colnames(th.4df)=c("N0","K","r","tlag","SS","iter","tol","AIC")
  
  ### calculating
  th.1<-try(as.numeric(th.1df[which(th.1df$AIC==min(th.1df$AIC)),]),silent = T)
  th.2<-try(as.numeric(th.2df[which(th.2df$AIC==min(th.2df$AIC)),]),silent = T)
  th.3<-try(as.numeric(th.3df[which(th.3df$AIC==min(th.3df$AIC)),]),silent = T)
  th.4<-try(as.numeric(th.4df[which(th.4df$AIC==min(th.4df$AIC)),]),silent = T)
  a.p<-data.frame("Time.hr"=a.p$Time.hr,"Popn_Change"=a.p$Popn_Change,"cst"=a.p$cst)
  
  ### input calculated values if they exist
  a.pp<-try(func_log0(N0=th.1[1], K=th.1[2], r=th.1[3], t=a.p$Time.hr), silent = T)
  if(isTRUE(class(a.pp))=="try-error"){a.p$log0<-NA}else{a.p$log0<-try(func_log0(N0=th.1[1], K=th.1[2], r=th.1[3], t=a.p$Time.hr), silent = T)}
  a.pp<-try(func_gom(N0=th.2[1], K=th.2[2], r=th.2[3], t=a.p$Time.hr, ld=th.2[4]), silent = T)
  if(isTRUE(class(a.pp))=="try-error"){a.p$gom<-NA}else{a.p$gom<-try(func_gom(N0=th.2[1], K=th.2[2], r=th.2[3], t=a.p$Time.hr, ld=th.2[4]), silent = T)}
  a.pp<-try(func_bar(N0=th.3[1], K=th.3[2], r=th.3[3], t=a.p$Time.hr, tlag=th.3[4]), silent = T)
  if(isTRUE(class(a.pp))=="try-error"){a.p$bar<-NA}else{a.p$bar<-try(func_bar(N0=th.3[1], K=th.3[2], r=th.3[3], t=a.p$Time.hr, tlag=th.3[4]), silent = T)}
  a.pp<-try(func_buc(N0=th.4[1], K=th.4[2], r=th.4[3], t=a.p$Time.hr, tlag=th.4[4], cst = a.p$cst), silent = T)
  if(isTRUE(class(a.pp))=="try-error"){a.p$buc<-NA}else{a.p$buc<-try(func_buc(N0=th.4[1], K=th.4[2], r=th.4[3], t=a.p$Time.hr, tlag=th.4[4], cst = a.p$cst), silent = T)}

  ### mod for plotting
  a.p<-melt(a.p, id=c("Time.hr","Popn_Change","cst"), variable.name = "Model", value.name = "value")
  
  ### plotting
  a.pla<-c(th.1[7],th.2[8],th.3[8],th.4[8])
  
    if(i<10){i.1<-"00"}else if(i<100){i.1<-"0"}else{i.1<-""}
  pdf(paste0("Log_PlotGraph/",i.1,i,".pdf"))
  print(ggplot()+theme_bw()+
    xlab("Time (hr)")+ylab("log Population Change")+
    scale_color_manual(name="Model", labels=a.pl, values = cbbPalette[-c(1,4,5)])+
    scale_linetype_discrete(name="Model", labels=a.pl)+
    geom_point(aes(x=a.p$Time.hr, y=a.p$Popn_Change), shape=4)+
    geom_line(aes(x=a.p$Time.hr, y=a.p$value, linetype=a.p$Model, colour=a.p$Model))+
    geom_label(aes(label=paste0("lowest AIC model:\n",a.pl[which(a.pla==min(a.pla, na.rm = T))]), x=mean(a.p$Time.hr)*1.4, y=abs(mean(log(a.p$Popn_Change))*.3)))+
    scale_y_continuous(labels = scientific,trans = "log10",oob = rescale_none))
  dev.off()
};rm(i)
