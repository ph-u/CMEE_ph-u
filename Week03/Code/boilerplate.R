## a boilerplate R script

MyFunction<-function(Arg1, arg2){
  ## statements involving Arg1, arg2:
  print(paste("Argument",as.character(Arg1),"is a",class(Arg1)))## print Arg1's type
  print(paste("Argument",as.character(arg2),"is a",class(arg2)))## print arg2's type
}
MyFunction(1,2)## test the function
MyFunction("Riki","Tiki")