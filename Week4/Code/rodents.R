## lib
library(car)
library(PMCMR)
library(dplyr)

{## data-scanning
  # setwd("/Volumes/HPM-000/Academic/Masters/ICL_CMEE/00_course/CMEECourseWork_pmH/Week4/Code/")
  oo<-read.csv("../Data/rodents.csv", header = T, stringsAsFactors = F)
  oo$yr<-as.factor(oo$yr)
  oo$mo<-as.factor(oo$mo)
  oo$tag<-ifelse(oo$tag=="","No_Tag",oo$tag)
  oo$tag<-as.factor(oo$tag)
  oo$species<-as.factor(oo$species)
  oo$sex<-ifelse(oo$sex!="M", ifelse(oo$sex !="F","No_Data","F"),"M")
  oo$sex<-as.factor(oo$sex)
  colnames(oo)[6]<-"hindfootLength.mm"
  colnames(oo)[7]<-"weight.g"
  colnames(oo)[8]<-"precipitation.mm"
  # aa<-oo[which(oo$sex!="M" & oo$sex!="F" & oo$sex!=""),]
  # aa<-oo[which(oo$sex=="M"),]
}
## data description oo[,6]
## data description oo[,7]
for(i in 1:5){
  if(i!=3){
    boxplot(oo[,7]~oo[,i])
  }
};rm(i)

## data description oo[,8]
for(i in 1:5){
  if(i!=3){
      boxplot(oo[,8]~oo[,i])
  }
};rm(i)

## stat (only tell how reliable is the test, no need to put into publication)
hist(log(oo$precipitation.mm))
hist(log(oo$weight.g))
hist(oo$hindfootLength.mm)
qqPlot(log(oo$precipitation.mm), ylim = c(0,10))
qqPlot(log(oo$weight.g), ylim = c(0,10))
qqPlot(log(oo$hindfootLength.mm))

## non-parametric
cor.test(oo$weight.g,oo$precipitation.mm, method = "spearman") ## is precipitation affecting weight?
# cor.test(log(oo$weight.g),log(oo$precipitation.mm), method = "spearman")
kruskal.test(oo$weight.g~interaction(oo$species,oo$sex))
posthoc.kruskal.nemenyi.test(oo$weight.g~interaction(oo$species,oo$sex))
{ppp<-posthoc.kruskal.nemenyi.test(oo$weight.g~interaction(oo$species,oo$sex))$p.value
  ppp[ppp>.1]<-NA
  if(sum(is.na(ppp))==dim(ppp)[1]*dim(ppp)[2]){knplist<-0;print(knplist);rm(ppp)}else{
    if(dim(ppp)[1]<=2 && dim(ppp)[2]<=2){knplist<-ppp;rm(ppp)}else{
      i<-1;repeat{
        if(sum(is.na(ppp[,i]))==dim(ppp)[1]){
          ppp<-ppp[,-i]
          if(i==(dim(ppp)[2]+1)){break}
          if(is.data.frame(ppp)==F){break}
        }else{
          i<-i+1
          if(i==(dim(ppp)[2]+1)){break}}}
      i<-1;repeat{
        if(sum(is.na(ppp[i,]))==dim(ppp)[2]){
          ppp<-ppp[-i,]
          if(i==(dim(ppp)[1]+1)){break}
          if(is.data.frame(ppp)==F){break}
        }else{
          i<-i+1
          if(i==(dim(ppp)[1]+1)){break}}}
      pppL<-row.names(ppp)
      pppC1<-colnames(ppp)
      pppC2<-0;for(i in 1:length(pppC1)){
        pppC2<-c(pppC2,rep(pppC1[i],length(pppL)))
      };pppC2<-pppC2[-1]
      pppppp<-0;for(i in 1:dim(ppp)[2]){
        pppppp<-c(pppppp,ppp[,i])
      };pppppp<-pppppp[-1]
      knplist<-data.frame(pppL,pppC2,pppppp)
      colnames(knplist)=c("f1","f2","p.val")
      rm(list=ls(pattern="ppp"));rm(i)
      knplist<-knplist[which(is.na(knplist[,3])==F),]}}
  if(knplist!=0){View(knplist)}}

kruskal.test(oo$weight.g~oo$sex)
posthoc.kruskal.nemenyi.test(oo$weight.g~oo$sex)
aa<-oo[which(oo$sex!="No_Data"),]
aa$sex<-as.factor(as.character(aa$sex))
boxplot(aa$weight.g~aa$sex, main="Boxplot of Rodent weight against Gender", ylab = "Weight (g)", xlab = "Gender")

cat(paste("Male weight median:",unname(summary(aa[which(aa$sex=="M"),7])[3]),"\nFemale weight median:",unname(summary(aa[which(aa$sex=="F"),7])[3]),"\nMedian Difference by rodent gender:",unname(summary(aa[which(aa$sex=="M"),7])[3])-unname(summary(aa[which(aa$sex=="F"),7])[3])))
