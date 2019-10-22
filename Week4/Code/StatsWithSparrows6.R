oo<-read.table("../Data/SparrowSize.txt", sep = "\t", header = T)

library(pwr)
pwr.t.test(d=5/sd(oo$Wing,na.rm = T),sig.level = .05,power = .8)
