oo<-read.table("../Data/SparrowSize.txt", sep = "\t", header = T)
str(oo)
names(oo)
head(oo)
length(oo$Tarsus)
hist(oo$Tarsus)
mean(oo$Tarsus, na.rm=T)
median(oo$Tarsus, na.rm = T)
mode(oo$Tarsus)
a<-as.data.frame(table(oo$Tarsus))
a[,1]<-as.numeric(as.character(a[,1]))
a[which(a[,2]==max(a[,2])),]

mode<-function(NumericCol){
  ## input numeric column
  ## output mode of the column and frequency
  a<-as.data.frame(table(NumericCol))
  a[,1]<-as.numeric(as.character(a[,1]))
  return(a[which(a[,2]==max(a[,2])),])
}
## variance equation
## hedging for imprecision: df=n-1
## square of data --> give more weight for outliers to separate from the rest
######################

par(mfrow=c(2,2))
hist(oo$Tarsus, breaks = 3, col = "grey")
hist(oo$Tarsus, breaks = 10, col = "grey")
hist(oo$Tarsus, breaks = 30, col = "grey")
hist(oo$Tarsus, breaks = 100, col = "grey")

## lec hw
var(oo$Bill, na.rm = T)
sqrt(var(oo$Bill, na.rm = T))
mean(oo$Bill, na.rm = T)

var(oo$Mass, na.rm = T)
sqrt(var(oo$Mass, na.rm = T))
mean(oo$Mass, na.rm = T)

var(oo$Wing, na.rm = T)
sqrt(var(oo$Wing, na.rm = T))
mean(oo$Wing, na.rm = T)
