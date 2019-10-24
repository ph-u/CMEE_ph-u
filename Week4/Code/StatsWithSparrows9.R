a<-data.frame(c(1,2,3,4,8),c(4,3,5,7,9))
a<-data.frame(runif(1e6,.5,1.5),runif(1e6,.5,1.5))
m1<-lm(a[,2]~a[,1])
summary(m1) ## est +/- 2 se include 0 -> not quite stat sig
anova(m1)
resid(m1)
cov(a[,1],a[,2])
var(a[,1])
plot(a[,2]~a[,1])
