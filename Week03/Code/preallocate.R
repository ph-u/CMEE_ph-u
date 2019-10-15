ss<-function(p){
  a<-NA
  for(i in seq(1:p)){
    a<-c(a,i)
    # print(a)
    # print(object.size(a))
  }
  print(object.size(a))
}
sf<-function(p){
  a<-rep(NA,p)
  for(i in seq(1:p)){
    a[i]<-i
    # print(a)
    # print(object.size(a))
  }
  print(object.size(a))
}

print(paste("Not pre-allocated:",system.time(ss(1e4))))
print(paste("Pre-allocated:",system.time(sf(1e4))))