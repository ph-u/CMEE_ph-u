library(ggplot2)
library(minpack.lm) ## nlsLM cannot generate data out of source df scope
alb<-read.csv("../Data/albatross_grow.csv")
alb<-alb[which(!is.na(alb$wt)),]
plot(alb$age, alb$wt, xlab = "age (days)", ylab = "weight (g)", xlim = c(0,100))
logis.1<-function(t, r, k, N0){
  N0*k*exp(r*t)/(k+N0*(exp(r*t)-1))
}
vonbert.w<-function(t, Winf, c, k){
  Winf*(1-exp(-k*t)+c*exp(-k*t))^3
}
scale<-4e3
alb.lin<-lm(wt/scale~age, data = alb)
alb.log<-nlsLM(alb$wt/scale~logis.1(alb$age, r, k, N0), start = list(k=1, r=.1, N0=.1), data = alb)
alb.vb<-nlsLM(alb$wt/scale~vonbert.w(alb$age, Winf, c, k), start = list(Winf=.75, c=.01, k=.01), data = alb)

ages<-seq(0,100, length=93)
pred.lin<-predict(alb.lin, newdata = list(age=ages))*scale
pred.log<-predict(alb.log, newdata = list(age=ages))*scale
pred.vb<-predict(alb.vb, newdata = list(age=ages))*scale

plot(alb$age, alb$wt, xlab = "age (days)", ylab = "weight (g)", xlim = c(0,100));lines(ages, pred.lin, col=2, lwd=2);lines(ages, pred.log, col=3, lwd=2);lines(ages, pred.vb, col=4, lwd=2);legend("topleft", legend = c("linear", "logistic", "Von Bert"), lwd = 2, lty = 1, col = 2:4)

# ggplot()+theme_bw()+geom_point(aes(x=alb$age, y=alb$wt))+geom_line(aes(y=pred.lin, x=ages, colour="red"))+geom_line(aes(y=pred.log, x=ages, colour="green"))+geom_line(aes(y=pred.vb, x=ages, colour="blue"))+xlab("age.days")+ylab("weight.g")+scale_colour_manual(name="type", values = c("red","green","blue"), labels=c("linear", "logistic", "Von Bert")) ## ggplot2 version

par(mfrow=c(3,1), bty="n")
plot(alb$age, resid(alb.lin), main = "LM resids", xlim = c(0,100))
plot(alb$age, resid(alb.log), main = "Logistic resids", xlim = c(0,100))
plot(alb$age, resid(alb.vb), main = "VB resids", xlim = c(0,100))

n<-length(alb$wt)
list(lin=signif(sum(resid(alb.lin)^2)/(n-2*2), 3), log=signif(sum(resid(alb.log)^2)/(n-2*2), 3), vb=signif(sum(resid(alb.vb)^2)/(n-2*2), 3))

a<-list(alb.lin, alb.log, alb.vb);for(i in 1:3){
  j<-(i+1)%%3
  if(j==0){j<-3}
  print(paste(i,j))
  k<-AIC(a[[i]])-AIC(a[[j]])
  if(k<0){p<-paste(i,"better")}else if(k==0){p<-paste(i,"=",j)}else{p<-paste(j,"better")}
  print(paste("AIC:",round(k,2),";",p))
  
  k<-BIC(a[[i]])-BIC(a[[j]])
  if(k<0){p<-paste(i,"better")}else if(k==0){p<-paste(i,"=",j)}else{p<-paste(j,"better")}
  print(paste("BIC:",round(k,2),";",p))
};rm(a,i,j,k,p)

ggp<-data.frame("fac"=c(rep("alb.lin",length(resid(alb.lin))),rep("alb.log",length(resid(alb.log))),rep("alb.vb",length(resid(alb.vb)))),"x"=c(names(resid(alb.lin)),names(resid(alb.log)),names(resid(alb.vb))),"data"=c(unname(resid(alb.lin)),unname(resid(alb.log)),unname(resid(alb.vb))))
ggplot(data = ggp, aes(y=ggp$data, x=as.numeric(ggp$x)))+theme_bw()+
  facet_grid(ggp$fac ~.)+
  geom_point()+geom_smooth(se=F)

