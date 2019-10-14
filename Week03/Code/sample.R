## run a simulation that involves sampling form a popuation
x<-rnorm(50) # Generate your population
doit<-function(x){
  x<-sample(x,replace = T)
  if(length(unique(x))>30){## only take mean if sample was sufficient
    print(paste("Mean of this sample was:",as.character(mean(x))))
  }
}
## run 100 iterations using vectorization:
result<-lapply(1:100,function(i) doit(x))

## using a for loop:
result<-vector("list",100)## preallocate/Initialize
for(i in 1:100){
  result[[i]]<-doit(x)
}