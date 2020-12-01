#!/bin/env R

# Author: ph-u
# Script: GenomeDesc.R
# Desc: classwork program based on structure same as `bear.csv`
# Input: Rscript GenomeDesc.R <csv>
# Output: 1. five analysis result `csv` outputs in `results` subdirectory; 2. two graphical plots in `result` subdirectory
# Arguments: 0 or 1
# Date: Nov 2019

## lib
library(ggplot2)
library(reshape2) ## melting df
library(scales) ## rescale ggplot without eliminate bars

## grep data from bash
args=(commandArgs(T))

## colours
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#e79f00", "#9ad0f3", "#F0E442", "#999999", "#cccccc", "#6633ff", "#00FFCC", "#0066cc")

if(length(args) !=1){
	a.nam<-"../Data/bears.csv"
}else{a.nam<-args[1]}
a<-read.csv(a.nam, header=F,stringsAsFactors = F)
colnames(a)=seq(1:dim(a)[2])

## SNP id -- rmb row 1,2 = one individual (Q1)
cat("SNP extraction\n")
a.0<-as.data.frame(matrix(nrow=dim(a)[1], ncol=0))
for(i in 1:dim(a)[2]){
	if(length(unique(a[,i]))>1){
		a.0[,(dim(a.0)[2]+1)]<-a[,i]
		colnames(a.0)[dim(a.0)[2]]=colnames(a)[i]
	}
};rm(i)

## SNP freq (Q2)
cat("counting allele freq\n")
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
cat("counting genotype freq\n")
a.2<-as.data.frame(matrix(0,nrow=17, ncol=dim(a.0)[2]))
colnames(a.2)=colnames(a.0)
row.names(a.2)=c("AA","TT","CC","GG","AT","TA","AC","CA","AG","GA","TC","CT","TG","GT","CG","GC","heterozygous")
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
cat("calculating heterozygosity\n")
a.3<-as.data.frame(matrix(nrow = 2, ncol = dim(a.0)[2]))
row.names(a.3)=c("heterozygosity","homozygosity")
colnames(a.3)=colnames(a.0)
a.3[1,]<-a.2[5,]/(dim(a)[1]/2)
a.3[2,]<-1-a.3[1,]
# a.3[3,]<-prod(a.2[which(a.2[1:4,]!=0),])*2
# a.4[4,]<-sum(a.2[which(a.2[1:4,]!=0),]^2)

## genotype counts (Q5)
cat("counting genotypes\n")
a.4<-as.data.frame(matrix(nrow = 5, ncol = dim(a.0)[2]))
row.names(a.4)=row.names(a.2)
colnames(a.4)=colnames(a.0)
for(i in 1:dim(a.4)[1]){
  a.4[i,]<-a.2[i,]/sum(a.2[(1:dim(a.2)[1]),])
};rm(i)

## Chi-sq test on HWE (Q5,6)
cat("calculating statistics\n")
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

cat("Plotting graphs\n")
## graph on Q2
p.2<-melt(t(a.1),variable.name="Seq",value.name = "freq")
p.2<-p.2[which(p.2[,3]!=0),]
pdf(paste0("../results/",bn,"_allele_freq.pdf"), width = 20)
ggplot()+theme_bw()+
  xlab("SNP position")+ylab("Number of individuals")+
  theme(axis.text.x = element_text(angle = 90))+
  scale_fill_manual(name="Allele", values = cbbPalette)+
  scale_y_continuous(breaks = seq(0,dim(a)[1],5))+
  geom_col(aes(x=as.factor(p.2[,1]),y=p.2[,3],fill=p.2[,2]))
dev.off()

## graph on Q6
p.6<-melt(t(a.5[4,]),value.name = "inb_coef")
pdf(paste0("../results/",bn,"_inbreeding_coef.pdf"), width = 20)
ggplot()+theme_bw()+
  xlab("SNP position")+ylab("Inbreeding Coefficient")+
  theme(axis.text.x = element_text(angle = 90),
        axis.text.y = element_text(size = 20))+
  scale_y_continuous(limits = c(.75,1),oob = rescale_none)+ ## <https://stackoverflow.com/questions/10365167/geom-bar-bars-not-displaying-when-specifying-ylim>
  geom_col(aes(x=as.factor(p.6[,1]), y=p.6[,3]))
dev.off()

## export results
cat("printing calculation results\n")
write.csv(a.1,paste0("../results/",bn,"_allele_freq.csv"), quote = F)
write.csv(a.2,paste0("../results/",bn,"_genotype_freq.csv"), quote = F)
write.csv(a.3,paste0("../results/",bn,"_heterozygosity.csv"), quote = F)
write.csv(a.4,paste0("../results/",bn,"_genotype_counts.csv"), quote = F)
write.csv(a.5,paste0("../results/",bn,"_Chi_InbreedCoef.csv"), quote = F)
