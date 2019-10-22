oo<-read.table("../Data/SparrowSize.txt", sep = "\t", header = T)
o.0<-subset(oo, is.na(oo$Tarsus)==F)
seTarsus<-sqrt(var(o.0$Tarsus)/length(o.0$Tarsus))
o.2001<-subset(o.0,o.0$Year==2001)
seTarsus2001<-sqrt(var(o.2001$Tarsus)/length(o.2001$Tarsus))
for(i in c(3:6)){
  print(colnames(o.2001)[i])
  print(paste("N:",length(oo[which(is.na(oo[,i])==F),i])))
  x<-sqrt(var(o.2001[,i],na.rm = T)/length(o.2001[,i]))
  print(paste0("se of 2001 column ",i,": ",x))
  print(paste0("0.95CI: ",mean(o.2001[,i]-1.96*x,na.rm = T),"   ",mean(o.2001[,i]+1.96*x,na.rm = T)))
};rm(i)

## hw
