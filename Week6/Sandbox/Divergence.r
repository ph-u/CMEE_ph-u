leo<-read.csv("leopard_gecko.csv", stringsAsFactors = FALSE, header= FALSE, na.strings = 'NULL',  colClasses = rep("character", 20000))
ban<-read.csv("western_banded_gecko.csv", stringsAsFactors = FALSE, header= FALSE, na.strings = 'NULL',  colClasses = rep("character", 20000))
toe<-read.csv("bent-toed_gecko.csv", stringsAsFactors = FALSE, header= FALSE, na.strings = 'NULL',  colClasses = rep("character", 20000))
library("dplyr")
library(readr)
leo_ban<-rbind(leo,ban)
leo_toe<-rbind(leo,toe)
ban_toe<-rbind(ban,toe)


#LEO BAN COMPARISON
#SNPSLEOBAN<-c()

#for(i in 1:(ncol(leo_ban))){
 # allelesleoban<-unique(leo_ban[,i])
 # if(length(allelesleoban)>=2) {SNPSLEOBAN<-c(SNPSLEOBAN,i)}
 # if(leo_ban[,i]>=leo_ban[,20]){break}
}
#SNPSLEO
#length(SNPS)

#snps leo
noSNPSLEO<-c()
for(i in 1:(ncol(leo))){
  allelesleo<-unique(leo[,i])
  if(length(allelesleo)<2) {noSNPSLEO<-c(noSNPSLEO,i)}
}
noSNPSLEO
length(noSNPSLEO)
Un_leo<-leo[1,noSNPSLEO]


#snps ban
noSNPSBAN<-c()
for(i in 1:(ncol(ban))){
  allelesban<-unique(ban[,i])
  if(length(allelesban)<2) {noSNPSBAN<-c(noSNPSBAN,i)}
}
noSNPSBAN
length(noSNPSBAN)

Un_ban<-ban[1,noSNPSBAN]
length(Un_ban)
#
LEO_BAN<-merge(Un_leo,Un_ban, all=TRUE)
length

SNPSLEOBAN<-c()

for(i in 1:(ncol(LEO_BAN))){
  allelesleoban<-unique(LEO_BAN[,i])
  if(length(allelesleoban)>=2) {SNPSLEOBAN<-c(SNPSLEOBAN,i)}
  }
SNPSLEOBAN
length(SNPSLEOBAN)

a0<-as.data.frame(matrix(nrow = 2,ncol = 0));for(i in 1:dim(LEO_BAN)[2]){a<-LEO_BAN[,i];if(!is.na(a[order(a)])){a0[,(dim(a0)+1)]<-LEO_BAN[,i]}};rm(i)



#################
> dim(LEO_BAN)

[1]     2 20000
> length(SNPSLEO)/dim(LEO_BAN)[2]
[1] 0.00235
> View(LEO_BAN)
> LEO_BAN[is.na(LEO_BAN)]
[1] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
[26] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
[51] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
[76] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
[101] NA NA NA NA NA
> a<-LEO_BAN[,which(!is.na(LEO_BAN))]
Error in `[.data.frame`(LEO_BAN, , which(!is.na(LEO_BAN))) : 
  undefined columns selected
> is.na(c(NA,"A"))
[1]  TRUE FALSE
> isTRUE(is.na(c(NA,"A")))
[1] FALSE
> order(c("a",NA))
[1] 1 2
> a<-c("T",NA,"A")
> order(a)
[1] 3 1 2
> a[order(a)]
[1] "A" "T" NA 
> a0<-as.data.frame(matrix(nrow = 2,ncol = 0));for(i in 1:dim(LEO_BAN)[2]){a<-LEO_BAN[,i];if(!is.na(a[order(a)])){a0[,(dim(a0)+1)]<-LEO_BAN[,i]}};rm(i)