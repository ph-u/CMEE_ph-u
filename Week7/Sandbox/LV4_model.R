setwd("/Volumes/HPM-000/Academic/Masters/ICL_CMEE/00_course/CMEECourseWork_pmH/Week7/Sandbox/")

LV4<-function(Rt, Ct, K, r, a, z, e){
  epp<-rnorm(1)
  Rt1<-Rt*(1+(r+epp)(1-Rt/K)-a*Ct)
  Ct1<-Ct*(1-z+e*a*Rt)
  return(Rt1,Ct1)
}

LV5<-function(Rt, Ct, K, r, a, z, e){
  epp<-rnorm(1)
  Rt1<-Rt*(2+epp+r-Rt/K-a*Ct)
  Ct1<-Ct*(1-z+epp+e*a*Rt)
}

KRF<-seq(5,100,1)
rRF<-seq(0,5,.1)
aRF<-seq(0,2,.01)
zRF<-seq(0,2,.0001)
eRF<-seq(0,.5,.00001)

hist<-as.data.frame(matrix(nrow = 0,ncol = 4))
LV4rs<-data.frame('t'=seq(0,15,15/999),'R'=rep(NA,1e3),'C'=rep(NA,1e3))
LV5rs<-data.frame('t'=seq(0,15,15/999),'R'=rep(NA,1e3),'C'=rep(NA,1e3))
LV4eqm<-LV5eqm<-0
tmpRF<-as.data.frame(matrix(nrow = 0, ncol = 5))
LV4rs[1,2:3]<-LV5rs[1,2:3]<-c(10,5) ## ini

repeat{
  tmp<-c(sample(KRF,1),sample(rRF,1),sample(aRF,1),sample(zRF,1),sample(eRF,1))
  tmpRF<-dim(hist[which(
    tmpRF[,1]==tmp[1] &
      tmpRF[,1]==tmp[1] &
      tmpRF[,1]==tmp[1] &
      tmpRF[,1]==tmp[1]),])[1]
  if(tmpRF==0){
    hist<-rbind(hist,tmp)
    if(length(LV4eqm)==1){
      for(i in 2:dim(LV4rs)[1]){
        LV4rs[i,]<-LV4(LV4rs[i-1,2],LV4rs[i-1,3],tmp[1],tmp[2],tmp[3],tmp[4],tmp[5])
      }
      if(lm(tail(LV4rs[,2])~tail(LV4rs[,1]))<.1){
        LV4eqm<-tmp
      }}
    
    if(length(LV5eqm)==1){
      for(i in 2:dim(LV5rs)[1]){
        LV5rs[i,]<-LV5(LV5rs[i-1,2],LV5rs[i-1,3],tmp[1],tmp[2],tmp[3],tmp[4],tmp[5])
      }
      if(lm(tail(LV5rs[,2])~tail(LV5rs[,1]))<.1){
        LV5eqm<-tmp
      }}
  }
  if(length(LV4eqm)>1 & length(LV5eqm)>1){break}
}
