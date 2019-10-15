M<-matrix(runif(1e6),1e3,1e3)

SumAllElements<-function(M){
  Dimensions<-dim(M)
  Tot<-0
  for(i in 1:Dimensions[1]){
    for(j in 1:Dimensions[2]){
      Tot<-Tot+M[i,j]
    }
  }
  return(Tot)
}

cat("Using loops, the time taken is:\n")
cat(paste0(round(unname(system.time(SumAllElements(M))[1]),3),"\n"))

cat("Using the built vectorized function, the time taken is:\n")
cat(paste0(round(unname(system.time(sum(M))[1]),3),"\n"))