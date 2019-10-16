# Runs the stochastic (with gaussian fluctuations) Ricker Eqn .

rm(list=ls())

stochrick<-function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100)
{
  #initialize
  N<-matrix(NA,numyears,length(p0))
  N[1,]<-p0
  
  for (pop in 1:length(p0)) #loop through the populations
  {
    for (yr in 2:numyears) #for each pop, loop through the years
    {
      N[yr,pop]<-N[yr-1,pop]*exp(r*(1-N[yr-1,pop]/K)+rnorm(1,0,sigma))
    }
  }
  return(N)
  
}

## My function
stochrick.m<-function(p0=1e3,r=1.2,K=1,sigma=0.2,numyears=100){
  #initialize
  N<-matrix(NA,numyears,p0)
  N[1,]<-runif(p0,.5,1.5)
  
  ## calculate
  for (pop in 1:length(p0)) #loop through the populations
  {
    for (yr in 2:numyears) #for each pop, loop through the years
    {
      N[yr,pop]<-N[yr-1,pop]*exp(r*(1-N[yr-1,pop]/K)+rnorm(1,0,sigma))
    }
  }
  
  return(N)
}
# Now write another function called stochrickvect that vectorizes the above to the extent possible, with improved performance:

## comparison
a<-system.time(res2<-stochrick())
b<-system.time(res3<-stochrick.m())
print("My Vectorized Stochastic Ricker takes:\n")
cat(paste0(round(unname(b[1]),3),"\n"))
cat("Vectorized Stochastic Ricker takes:\n")
cat(paste0(round(unname(a[1]),3),"\n"))
# print(paste("My solution is faster than target by",round(unname(b[1])-unname(a[1]),4),"sec"))

## stat cal
  # library(ggplot2)
  # library(PMCMR)
  # 
  # ## run test
  # co<-1e3
  # compare<-data.frame(matrix(nrow = co,ncol = 2))
  # for(i in 1:co){
  #   compare[i,1]<-unname(system.time(stochrick())[1])
  #   compare[i,2]<-unname(system.time(stochrick.m())[1])
  # }
  # colnames(compare)=c("initial","modified")
  # write.csv(compare,"../Sandbox/Vectorize2_result.csv",quote = F,row.names = F)
  # 
  # ## stat test
  # compare<-read.csv("../Sandbox/Vectorize2_result.csv",header = T)
  # cc<-as.factor(c(rep("initial",co),rep("modified",co)))
  # cc<-data.frame(cc,c(compare[,1],compare[,2]))
  # kt<-kruskal.test(cc[,2],cc[,1])
  # pdf("../Sandbox/Vectorize2_result.pdf")
  # ggplot()+
  #   geom_boxplot(aes(cc[,1],cc[,2]))+
  #   xlab("Modification")+ylab("Runtime (sec)")+
  #   ggtitle("Runtime Comparison between initial and modified stochastic Ricker R model")+
  #   geom_label(aes(x=1.5,y=.4,label=paste("num iteration:",co,"\np.val=",round(kt$p.value,4),"\nwith Kruskal Test")),hjust=0)
  # dev.off()