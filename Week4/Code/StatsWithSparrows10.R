setwd("/Volumes/HPM-000/Academic/Masters/ICL_CMEE/00_course/CMEECourseWork_pmH/Week4/Code/")
d<-read.table("../Data/SparrowSize.txt",sep = "\t",header = T)
plot(d$Mass~d$Tarsus, ylab = "Mass (g)", xlab="Tarsus (mm)", pch=19, cex=.4, ylim=c(-5,38), xlim=c(0,22))
d1<-d[which(!is.na(d$Mass)),]
d2<-d[which(!is.na(d$Tarsus)),]
length(d2$Tarsus)
m1<-lm(d2$Mass~d2$Tarsus)
summary(m1)
hist(m1$residuals)
head(m1$residuals)
d2$z.Tarsus<-scale(d2$Tarsus)
m3<-lm(d2$Mass~d2$z.Tarsus)
plot(d2$Mass~d2$z.Tarsus, pch=19, cex=.4)
abline(v=0, lty="dotted")
head(d)
str(d)
d$Sex<-as.numeric(d$Sex)
par(mfrow=c(1,2))
plot(d$Wing~d$Sex.1, ylab = "Wing (mm)")
plot(d$Wing~d$Sex, xlab="Sex", xlim=c(-.1,1.1), ylab = "")
abline(lm(d$Wing~d$Sex), lwd=2)
text(.15,76,"intercept")
text(.9,77.5,"slope", col = "red")

d4<-d[which(!is.na(d$Wing)),]
m4<-lm(d4$Wing~d4$Sex)
t4<-t.test(d4$Wing~d4$Sex, var.equal=T)
summary(m4)
t4
par(mfrow=c(2,2));plot(m3)
par(mfrow=c(2,2));plot(m4)

## exercise
par(mfrow=c(1,1))
plot(d$Wing~d$Sex.1)
plot(d$Tarsus~d$Sex.1)
plot(d$Mass~d$Sex.1)

a.0<-summary(lm(d$Mass~d$Bill))
paste("number of sparrows:",dim(d)[1]) 
paste("explanatory var: bill width (mm)")
paste("response var: mass (g)")

{i<-d$Tarsus
  print(mean(i, na.rm = T))
  print(length(!is.na(i)))
  print(sd(i, na.rm = T))
  print(min(i, na.rm = T))
  print(max(i, na.rm = T))}

