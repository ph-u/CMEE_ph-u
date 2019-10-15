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

print("Using loops, the time taken is:")
print(system.time(SumAllElements(M)))

print("Using the built vectorized function, the time taken is:")
print(system.time(sum(M)))