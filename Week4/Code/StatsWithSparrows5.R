oo<-read.table("../Data/SparrowSize.txt", sep = "\t", header = T)
o.0<-subset(oo, oo$Year==2001)
t.test(o.0$Tarsus,mu=mean(oo$Tarsus,na.rm = T),na.rm=T)
t.test(o.0$Tarsus~o.0$Sex.1,na.rm=T)
 
## HW
library(ggplot2)
boxplot(oo$Mass~oo$Sex.1, col=c("red","blue"), ylab = "Body mass (g)") ## always show description of data (i.e. plot) BEFORE doing any analyses
t.test(oo$Mass~oo$Sex.1)

ggplot()+xlab("Mass (g)")+
  geom_density(aes(x=na.omit(oo$Mass[which(oo$Sex.1=="male")])),colour="blue")+
  geom_density(aes(x=na.omit(oo$Mass[which(oo$Sex.1=="female")])),colour="red")+
  geom_vline(xintercept = mean(oo$Mass[which(oo$Sex.1=="male")],na.rm = T),colour="blue")+
  geom_vline(xintercept = mean(oo$Mass[which(oo$Sex.1=="female")],na.rm = T),colour="red")

d1<-as.data.frame(head(oo,50))
length(d1$Mass)
t.test(d1$Mass~d1$Sex.1)

t.test(o.0$Wing, mu=mean(oo$Wing,na.rm = T),na.rm=T)
t.test(o.0$Wing~o.0$Sex.1,na.rm=T)
t.test(o.0$Wing[which(o.0$Sex.1=="male")], mu=mean(oo$Wing[which(o.0$Sex.1=="male")],na.rm = T),na.rm=T)
t.test(o.0$Wing[which(o.0$Sex.1=="female")], mu=mean(oo$Wing[which(o.0$Sex.1=="female")],na.rm = T),na.rm=T)

boxplot(oo$Tarsus~oo$Year)
t.test(o.0$Tarsus, mu=mean(oo$Tarsus,na.rm = T),na.rm=T)
t.test(o.0$Tarsus~o.0$Sex.1,na.rm=T)
t.test(o.0$Tarsus[which(o.0$Sex.1=="male")], mu=mean(oo$Tarsus[which(o.0$Sex.1=="male")],na.rm = T),na.rm=T)
t.test(o.0$Tarsus[which(o.0$Sex.1=="female")], mu=mean(oo$Tarsus[which(o.0$Sex.1=="female")],na.rm = T),na.rm=T)

oo.p<-oo
oo.p$Year<-"overall"
oo.p<-rbind(oo.p,oo[which(oo$Year==2001),])
boxplot(oo.p$Tarsus~oo.p$Year,col=c("red","blue"))
t.test(oo.p$Tarsus~oo.p$Year, na.rm=T)

## t-test assumptions
## variance equal
## normally-distributed