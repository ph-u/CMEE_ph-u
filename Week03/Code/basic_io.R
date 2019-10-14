## a simple script to illustrate R input-output
## run line by line and check inputs outputs to understand what is happening

MyData<-read.csv("../data/trees.csv",header = T)## import with headers
write.csv(MyData,"../results/MyData.csv")## write it out as a new file
write.table(MyData[1,],"../results/MyData.csv".append=T)## append to it
write.csv(MyData,"../results/MyData.csv",row.names = T)## write row names
write.table(MyData,"../results/MyData.csv",col.names = F)## ignore column names