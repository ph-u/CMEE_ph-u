a<-4;a
a*a
a_squared<-a*a
sqrt(a_squared)
v<-c(0,1,2,3,4)
is.vector(v)
mean(v)
var(v)
median<-v
sum(v)
prod(v+1)
length(v)
wing.width.cm<-1.2
wing.length.cm<-c(4.7,5.2,4.8)
ls.str()
arr1<-array(1:50,c(5,5,2))
col1<-1:10
col2<-letters[1:10]
col3<-runif(10)
mydf<-data.frame(col1,col2,col3)
names(mydf)<-c("MyFirstColumn","My Second Column","My.Third.Column")
mydf$`My Second Column`
v%*%t(v)
set.seed(1234567);rnorm(1)
set.seed(1234567);rnorm(11)
mydata<-read.csv("../Data/trees.csv")
ls()[grep("da",ls())]
