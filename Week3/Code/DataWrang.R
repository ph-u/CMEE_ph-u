MyData<-as.matrix(read.csv("../Data/PoundHillData.csv",header = F,stringsAsFactors = F))
MyMetaData<-read.csv("../Data/PoundHillMetaData.csv",header = T,sep = ";",stringsAsFactors = F)
head(MyData)
MyMetaData
MyData[MyData==""]=0
MyData<-t(MyData)
TempData<-as.data.frame(MyData[-1,],stringAsFactors=F)
head(TempData)
colnames(TempData)<-MyData[1,] ## assign column names from original data
head(TempData)
rownames(TempData)<-NULL
library(reshape2)
MyWrangledData<-melt(TempData,id=c("Cultivation","Block","Plot","Quadrat"),variable.name = "Species",value.name = "Count")
head(MyWrangledData);tail(MyWrangledData)

MyWrangledData[,"Count"]<-as.integer(MyWrangledData[,"Count"])
str(MyWrangledData)
