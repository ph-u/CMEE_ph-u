library(repr)
#options(repr.plot.width = 4, repr.plot.height = 4) ## change plot sizes (in cm) in Jupyter notebook
library(minpack.lm)
powMod<-function(x, a, b){
  return(a*x^b)
}
MyData<-read.csv("../Data/GenomeSize.csv")
head(MyData)
Data2Fit<-MyData[which(MyData$Suborder=="Anisoptera" & !is.na(MyData$TotalLength)),]

plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)
library(ggplot2)
ggplot(Data2Fit,aes(x=Data2Fit$TotalLength, y=Data2Fit$BodyWeight))+geom_point(size=(3), colour="red")+theme_bw()+labs(y="Body mass (mg)", x="Wing length (mm)")

PowFit<-nlsLM(Data2Fit$BodyWeight~powMod(Data2Fit$TotalLength, a, b), data = Data2Fit, start = list(a=.1, b=.1))
summary(PowFit)

Lengths<-seq(min(Data2Fit$TotalLength), max(Data2Fit$TotalLength), len=200)
coef(PowFit)["a"]
coef(PowFit)["b"]
Predic2PlotPow<-powMod(Lengths, coef(PowFit)["a"], coef(PowFit)["b"])
plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)
lines(Lengths, Predic2PlotPow, col="blue", lwd=2.5)
confint(PowFit)

## num of rows not matching, not working
QuaFit<-lm(Data2Fit$BodyWeight~poly(Data2Fit$TotalLength,degree = 2))
# Predic2PlotQua<-predict.lm(QuaFit, data.frame(TotalLength=Lengths)) ## https://stackoverflow.com/questions/27464893/getting-warning-newdata-had-1-row-but-variables-found-have-32-rows-on-pred

plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)
lines(Lengths, Predic2PlotPow, col="blue", lwd=2.5)
# lines(Lengths, Predic2PlotQua, col="red", lwd=2.5)

RSS_Pow<-sum(residuals(PowFit)^2) ## residual sum of sq
TSS_Pow<-sum((Data2Fit$BodyWeight-mean(Data2Fit$BodyWeight))^2) ## total sum of sq
RSq_Pow<-1-(RSS_Pow/TSS_Pow) ## R^2

RSS_Qua<-sum(residuals(QuaFit)^2) ## res sum of sq
TSS_Qua<-sum((Data2Fit$BodyWeight-mean(Data2Fit$BodyWeight))^2) ## total sum of sq
RSq_Qua<-1-(RSS_Qua/TSS_Qua) ## R^2
RSq_Pow;RSq_Qua

## model selection
n<-nrow(Data2Fit) ## set sample size
pPow<-length(coef(PowFit)) ## get number of parameters in power law model
pQua<-length(coef(QuaFit)) ## get number of parameters in quadratic model

AIC_Pow<-n+2 +n*log(2*pi/n) +n*log(RSS_Pow) +2*pPow
AIC_Qua<-n+2 +n*log(2*pi/n) +n*log(RSS_Qua) +2*pQua
AIC_Pow-AIC_Qua
AIC(PowFit)-AIC(QuaFit) ## lm vs lm
