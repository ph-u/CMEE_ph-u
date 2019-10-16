SomeOperation<-function(v){
  if(sum(v)>0){
    return(v*100)
  }
  return(v)
}

M<-matrix(rnorm(100),10,10)
print(apply(M,1,SomeOperation))