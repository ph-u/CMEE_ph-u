#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: TPC_0.R
# Desc: Miniproject on `ThermRespData.csv`
# Input: ```Rscript TPC_0.R```
# Output: results
# Arguments: 0
# Date: Nov 2019

# setwd("/Volumes/HPM-000/Academic/Masters/ICL_CMEE/00_course/CMEECourseWork_pmH/MiniProject/code/")

## lib
library(ggplot2)
library(minpack.lm)

## data in
a.0<-read.csv("../data/ThermRespData.csv", header = T, stringsAsFactors = F)
colnames(a.0) ## checking

## col select (release RAM)
a.0<-data.frame(a.0$ID, a.0$Replicates, a.0$Citation, a.0$OrignalTraitName, a.0$OriginalTraitValue, a.0$OriginalTraitUnit, a.0$ConTemp)
colnames(a.0)=c("id", "rep", "cite", "OTName", "OTValue", "OTUnit", "Temp")

## id unique datasets
a.1<-as.data.frame(matrix(nrow = 0, ncol = (dim(a.0)[2]-2)))
colnames(a.1)=colnames(a.0)[-c(5,7)]
for(i in 1:dim(a.0)[1]){
  if(i==1){
    v.1<-unique(a.1[,1])
    v.2<-unique(a.1[,2])
    v.3<-unique(a.1[,3])
    v.4<-unique(a.1[,4])
    v.5<-unique(a.1[,5])
  }
  if(!(a.0$id[i] %in% v.1 &
       a.0$rep[i] %in% v.2 &
       a.0$cite[i] %in% v.3 &
       a.0$OTName[i] %in% v.4 &
       a.0$OTUnit[i] %in% v.5)){
    a.1<-rbind(a.1,a.0[i,-c(5,7)])
    v.1<-unique(a.1[,1])
    v.2<-unique(a.1[,2])
    v.3<-unique(a.1[,3])
    v.4<-unique(a.1[,4])
    v.5<-unique(a.1[,5])
  }
};rm(i);rm(list=ls(pattern="v."))
i.0<-c();for(i in 1:dim(a.1)[1]){
  a.p<-a.0[which(a.0$id==a.1$id[i] &
                   a.0$rep==a.1$rep[i] &
                   a.0$cite==a.1$cite[i] &
                   a.0$OTName==a.1$OTName[i] &
                   a.0$OTUnit==a.1$OTUnit[i]),]
  if(dim(a.p)[1]<1){i.0<-c(i.0,i)}
};a.2<-a.1[i.0,];a.1<-a.1[-i.0,];rm(i,i.0,a.p)
write.table(a.1, "../data/Log_Uq.txt",sep="\t", quote=F)

## for loop this section
v.f<-1 ### set subset criteria from summary (df a.1)
### subset according to criteria
a.2<-a.0[which(a.0$id==a.1$id[v.f] &
                 a.0$rep==a.1$rep[v.f] &
                 a.0$cite==a.1$cite[v.f] &
                 a.0$OTName==a.1$OTName[v.f] &
                 a.0$OTUnit==a.1$OTUnit[v.f]),c(1:4,6,5,7)]

### function
#### quad
a.lm2<-lm(a.2$OTValue~poly(a.2$Temp,2)) ## int, x, x^2
plot(fitted(a.lm2),residuals(a.lm2)) ## check

#### cubic
a.lm3<-lm(a.2$OTValue~poly(a.2$Temp,3)) ## int, x, x^2, x^3
plot(fitted(a.lm3),residuals(a.lm3)) ## check

#### briere
f.bri<-function(t,B0,T0,Tm){
  b<-B0*t*(t-T0)*sqrt(Tm-t)
  ## B0 = constant
  return(b)
}

#### schoolfield
f.sch<-function(t,B0,E,El,Eh,Tl,Th){
  k=8.617e-5 ## Boltzmann constant, eV.K-1
  ## B0 = value at 10 degC
  ## El = eV, vT deactivation E
  ## Tl = v temp @50% deactivation
  ## Eh = eV, ^T deactivation E
  ## Th = ^ temp @50% deactivation
  ## E = activation energy
  s=B0*exp(-E/k*(1/t-1/283.15))/(1+exp(El/k*(1/Tl-1/t))+exp(Eh/k*(1/Th-1/t)))
}

#### schoolfield sim-high temp only
f.scH<-function(t,B0,E,Eh,Th){
  k=8.617e-5 ## Boltzmann constant, eV.K-1
  s=B0*exp(-E/k*(1/t-1/283.15))/(1+exp(Eh/k*(1/Th-1/t)))
}

#### schoolfield sim-low temp only
f.scL<-function(t,B0,E,El,Tl){
  k=8.617e-5 ## Boltzmann constant, eV.K-1
  s=B0*exp(-E/k*(1/t-1/283.15))/(1+exp(El/k*(1/Tl-1/t)))
}

### model-fitting
# {i.1<-i.2<-0
#   i.3<-i.4<-a.2$Temp[which(a.2$OTValue==max(a.2$OTValue))]
#   i.6<-0
# };repeat{
#   if(i.6%%1e3==0 & i.6>0){cat(paste0(i.6/1e3,"K trial\n"))}
#   a<-try(
#     nlsLM(a.2$OTValue~f.sch(t=a.2$Temp, B0, E, El, Eh, Tl, Th),
#           data = a.2,
#           start = list(B0=i.1, E=i.2, El=i.3, Eh=i.4, Tl=min(a.2$Temp), Th=max(a.2$Temp)),
#           lower = c(rep(-Inf,4),0,a.2$Temp[which(a.2$OTValue==max(a.2$OTValue))]),
#           upper = c(rep(Inf,4),a.2$Temp[which(a.2$OTValue==max(a.2$OTValue))],Inf))
#     , silent = T)
#   i.6<-i.6+1
#   if(class(a)!="try-error"){
#     cat("success\n")
#     cat(paste("B0:",i.1,"; E:",i.2,"; El:",i.3,"Eh:",i.4,"\n"))
#     a<-nlsLM(a.2$OTValue~f.sch(t=a.2$Temp, B0, E, El, Eh, Tl, Th),
#              data = a.2,
#              start = list(B0=i.1, E=i.2, El=i.3, Eh=i.4, Tl=min(a.2$Temp), Th=max(a.2$Temp)),
#              lower = c(rep(-Inf,4),0,a.2$Temp[which(a.2$OTValue==max(a.2$OTValue))]),
#              upper = c(rep(Inf,4),a.2$Temp[which(a.2$OTValue==max(a.2$OTValue))],Inf))
#     break}
#   i.1<-i.1+1
#   if(i.6%%1e3 == 0){
#     i.5<-runif(1)
#     if(i.5 < .1){i.3<-i.3-1}else if(i.5 > .8){i.4<-i.4+1}else{i.2<-i.2+1}
#   }
#   if(i.1>1e6 | i.2>1e3 | i.3<0 | i.4>130){break}
# };rm(list=ls(pattern="i."))
# 
# nlsLM(a.2$OTValue~f.sch(t=a.2$Temp, B0, E, El, Eh, Tl, Th),
#       data = a.2,
#       start = list(B0=100, E=300, El=100, Eh=500, Tl=min(a.2$Temp), Th=max(a.2$Temp)),
#       lower = c(rep(-Inf,4),0,a.2$Temp[which(a.2$OTValue==max(a.2$OTValue))]),
#       upper = c(rep(Inf,4),a.2$Temp[which(a.2$OTValue==max(a.2$OTValue))],Inf))

### calculations
# a.p<-data.frame(a.2,
#                 "Model"=c(rep("quadratic",dim(a.2)[1]),rep("cubic",dim(a.2)[1])),
#                 "Value"=c(predict(a.lm2),predict(a.lm3)))

### plot result
for(i in 1:dim(a.1)[1]){
  a.p<-a.0[which(a.0$id==a.1$id[i] &
                   a.0$rep==a.1$rep[i] &
                   a.0$cite==a.1$cite[i] &
                   a.0$OTName==a.1$OTName[i] &
                   a.0$OTUnit==a.1$OTUnit[i]),]
  if(i<10){i.1<-"00"}else if(i<100){i.1<-"0"}else{i.1<-""}
  pdf(paste0("../sandbox/TPC_PreGraph/",i.1,i,".pdf"))
  print(ggplot()+theme_bw()+
    xlab("Temperature (Celsius)")+ylab(paste0("Original Trait Value (",unique(a.p$OTUnit),")"))+
      ggtitle(paste0(a.1$id[i],"_",a.1$rep[i],"_",a.1$OTName[i],"_",a.1$OTUnit[i],"_",dim(a.p)[1]))+
      geom_text(aes(label=a.1$cite[i],x=max(a.p$Temp)-min(a.p$Temp), y=max(a.p$OTValue)-min(a.p$OTValue)), size=2)+
      geom_point(aes(x=a.p$Temp, y=a.p$OTValue), shape=4, colour="red"))
  dev.off()
};rm(i,i.1,a.p)

# ggplot()+theme_bw()+
#   xlab("Temperature (Celsius)")+ylab(paste0("Original Trait Value (",unique(a.p$OTUnit),")"))+
#   geom_point(aes(x=a.p$Temp, y=a.p$OTValue), shape=4, colour="red")+
#   geom_line(aes(x=a.p$Temp, y=a.p$Value, linetype=a.p$Model))+
#   scale_linetype_discrete(name="Model")
