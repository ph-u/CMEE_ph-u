MyDF<-read.csv("../Data/EcolArchives-E089-51-D1.csv")
for(i in 1:dim(MyDF)[1]){
  if(as.character(MyDF[i,14])=="mg"){
    MyDF[i,9]<-MyDF[i,9]/1000
    MyDF[i,13]<-MyDF[i,13]/1000
    MyDF[i,14]<-"g"
  }
};rm(i)

dim(MyDF)
plot(MyDF$Predator.mass,MyDF$Prey.mass)
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass))
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass),pch=20) ## Change marker
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass),pch=20,xlab="Predator Mass (g)",ylab="Prey Mass (g)") ## add labels

hist(MyDF$Predator.mass)
hist(log(MyDF$Predator.mass),xlab = "Predator Mass (g)", ylab = "Count") ## include labels
hist(log(MyDF$Predator.mass),xlab = "Predator Mass (g)", ylab = "Count", col="lightblue", border = "pink") ## change bar and borders colours

## exercise
## bars with same, axes label larger & bold
## figure margins too large <https://stackoverflow.com/questions/23050928/error-in-plot-new-figure-margins-too-large-scatter-plot>
## par(mar=c(1,1,1,1))
###################

par(mfcol=c(2,1)) ## initialize multi-paneled plot
par(mfg=c(1,1)) ## specify which sub-plot to use first
hist(log(MyDF$Predator.mass),xlab = "Predator Mass (g)", ylab = "Count", col = "lightblue", border = "pink", main = "Predator") ## add title
par(mfg=c(2,1)) ## second sub-plot
hist(log(MyDF$Prey.mass), xlab = "Prey Mass (g)", ylab = "Count", col = "lightgreen", border = "pink", main = "prey")
hist(log(MyDF$Predator.mass), ## predator histogram
     xlab = "Body Mass (g)", ylab = "Count", col = rgb(1,0,0,.5), ## note "rgb", fourth value is transparency
     main = "Predator-prey size overlap")
hist(log(MyDF$Prey.mass), col = rgb(0,0,1,.5),add=T) ## plot prey
legend("topleft",c("predators","prey"), ## add legend
       fill = c(rgb(1,0,0,.5),rgb(0,0,1,.5))) ## define legend colours

## exercise

###################

boxplot(log(MyDF$Predator.mass), xlab="location", ylab="predator mass", main="predator mass")
boxplot(log(MyDF$Predator.mass)~MyDF$Location, ## why the tilde?
        xlab = "location", ylab = "predator mass", main="predator mass by location")
boxplot(log(MyDF$Predator.mass)~MyDF$Type.of.feeding.interaction,xlab = "location", ylab = "predator mass", main="predator mass by feeding interaction type")
{
  par(fig=c(0,.8,0,.8)) ## specify figure size as proportion
  plot(log(MyDF$Predator.mass), log(MyDF$Prey.mass), xlab = "predator mass (g)", ylab = "prey mass (g)") ## add labels
  par(fig=c(0,.8,.4,1), new=T)
  boxplot(log(MyDF$Predator.mass), horizontal = T, axes=F)
  par(fig=c(.55,1,0,.8), new=T)
  boxplot(log(MyDF$Prey.mass), axes=F)
  mtext("Fancy Predator-prey scatterplot", side = 3, outer = T, line=-3)
}
library(lattice)
densityplot(~log(Predator.mass)|Type.of.feeding.interaction,data = MyDF)

pdf("../results/Pred_Prey_Overlay.pdf", ## open blank pdf page using a relative path
    11.7, 8.3) ## these numbers are page dimensions in inches
hist(log(MyDF$Predator.mass), ## plot predator histogram (note 'rgb')
     xlab = "body mass (g)", ylab = "Count", col = rgb(1,0,0,.5),main = "Predator-Prey Size Overlap")
hist(log(MyDF$Prey.mass), ## plot prey weights
     col = rgb(0,0,1,.5),add=T) ## add to same plot = T
legend("topleft",c("predators","prey"), ## add legend
       fill = c(rgb(1,0,0,.5),rgb(0,0,1,.5)))
dev.off()

library(ggplot2)
qplot(MyDF$Prey.mass,MyDF$Predator.mass)
qplot(log(Prey.mass), log(Predator.mass), data = MyDF)
qplot(log(Prey.mass), log(Predator.mass), data = MyDF,colour=Type.of.feeding.interaction)
qplot(log(Prey.mass), log(Predator.mass), data = MyDF,shape=Type.of.feeding.interaction)
qplot(log(Prey.mass), log(Predator.mass), data = MyDF,colour="red")
qplot(log(Prey.mass), log(Predator.mass), data = MyDF,colour=I("red"))
qplot(log(Prey.mass), log(Predator.mass), data = MyDF,size=3) ## with ggplot size mapping
qplot(log(Prey.mass), log(Predator.mass), data = MyDF,size=I(3)) ## no mapping
qplot(log(Prey.mass),log(Predator.mass),data=MyDF,shape=I(3))
qplot(log(Prey.mass), log(Predator.mass),data = MyDF,colour=Type.of.feeding.interaction, alpha=I(.5))
qplot(log(Prey.mass), log(Predator.mass),data = MyDF,colour=Type.of.feeding.interaction, alpha=.5)
qplot(log(MyDF$Prey.mass),log(MyDF$Predator.mass),geom=c("point","smooth"))
qplot(log(MyDF$Prey.mass),log(MyDF$Predator.mass),geom=c("point","smooth"))+geom_smooth(method = "lm")
qplot(log(MyDF$Prey.mass),log(MyDF$Predator.mass), geom=c("point","smooth"), colour=MyDF$Type.of.feeding.interaction)+ geom_smooth(method = "lm")
qplot(log(MyDF$Prey.mass), log(MyDF$Predator.mass), geom = c("point","smooth"), colour=MyDF$Type.of.feeding.interaction)+ geom_smooth(method = "lm", fullrange=T)
qplot(MyDF$Type.of.feeding.interaction, log(MyDF$Prey.mass/MyDF$Predator.mass))
qplot(MyDF$Type.of.feeding.interaction, log(MyDF$Prey.mass/MyDF$Predator.mass),geom = "jitter")
qplot(MyDF$Type.of.feeding.interaction, log(MyDF$Prey.mass/MyDF$Predator.mass),geom = "boxplot")
qplot(log(Prey.mass/Predator.mass),data = MyDF, geom="histogram")
qplot(log(Prey.mass/Predator.mass),data = MyDF, geom="histogram",fill=Type.of.feeding.interaction)
qplot(log(MyDF$Prey.mass/MyDF$Predator.mass), geom="histogram", fill=MyDF$Type.of.feeding.interaction, binwidth=1)
qplot(log(MyDF$Prey.mass/MyDF$Predator.mass), geom="density", fill=MyDF$Type.of.feeding.interaction)
qplot(log(MyDF$Prey.mass/MyDF$Predator.mass), geom="density", colour=MyDF$Type.of.feeding.interaction)
qplot(log(Prey.mass/Predator.mass), facets = Type.of.feeding.interaction ~., data = MyDF, geom =  "density")
qplot(log(Prey.mass/Predator.mass), facets = .~ Type.of.feeding.interaction, data = MyDF, geom =  "density")
qplot(log(Prey.mass/Predator.mass), facets = .~ Type.of.feeding.interaction + Location, data = MyDF, geom = "density")
qplot(log(Prey.mass/Predator.mass), facets = .~ Location + Type.of.feeding.interaction, data = MyDF, geom = "density")
qplot(Prey.mass, Predator.mass, data = MyDF, log="xy")
qplot(Prey.mass, Predator.mass, data=MyDF, log="xy", main="Relation between predator and prey mass", xlab="log(Prey mass)", ylab = "log(Predator mass)")
qplot(Prey.mass, Predator.mass, data=MyDF, log="xy", main="Relation between predator and prey mass", xlab="log(Prey mass)", ylab = "log(Predator mass)")+theme_bw()
pdf("../results/MyFirst-ggplot2-Figure.pdf")
print(qplot(Prey.mass, Predator.mass, data=MyDF, log = "xy", main = "Relation between predator and prey mass", xlab = "log(Prey mass)", ylab = "log(Predator mass)") + theme_bw())
dev.off()

## load the data
MyDF<-as.data.frame(read.csv("../Data/EcolArchives-E089-51-D1.csv"))
qplot(Predator.lifestage, data = MyDF, geom = "bar")
qplot(Predator.lifestage, log(Prey.mass), data = MyDF, geom = "boxplot")
qplot(log(Predator.mass), data = MyDF, geom = "density")
qplot(log(Predator.mass), data = MyDF, geom = "histogram")
qplot(log(Predator.mass), log(Prey.mass), data = MyDF, geom = "point")
qplot(log(Predator.mass), log(Prey.mass), data = MyDF, geom = "smooth")
qplot(log(Predator.mass), log(Prey.mass), data = MyDF, geom = "smooth", method="lm")

p<-ggplot(MyDF, aes(x=log(Predator.mass), y=log(Prey.mass), colour=Type.of.feeding.interaction));p
p+geom_point()
p<-ggplot(MyDF, aes(x=log(Predator.mass), y=log(Prey.mass), colour=Type.of.feeding.interaction))
q<-p+geom_point(size=I(2), shape=I(10))+theme_bw();q
q+theme(legend.position = "none")

library(reshape2)
GenerateMatrix<-function(N){
  M<-matrix(runif(N^2),N,N)
  return(M)
}
M<-GenerateMatrix(10)
Melt<-melt(M)
p<-ggplot(Melt, aes(Var1, Var2, fill=value))+geom_tile();p
p+geom_tile(colour="black")
p+theme(legend.position = "none")
p+theme(legend.position = "none", panel.background = element_blank(), axis.ticks = element_blank(), panel.grid = element_blank(), axis.text = element_blank(), axis.title = element_blank())
p+scale_fill_continuous(low="yellow", high="darkgreen")
p+scale_fill_gradient2()
p+scale_fill_gradientn(colours=grey.colors(10))
p+scale_fill_gradientn(colours=rainbow(10))
p+scale_fill_gradientn(colours=c("red","white","blue"))

##############################
########## elipse ############
##############################
build_ellipse<-function(hradius, vradius){ ## function that returns an ellipse
  npoints=250
  a<-seq(0,2*pi, length=npoints+1)
  x<-hradius*cos(a)
  y<-vradius*sin(a)
  return(data.frame(x=x, y=y))
}
N<-250 ## assign size of the matrix
M<-matrix(rnorm(N^2), N, N) ## build the matrix
eigvals<-eigen(M)$values ## find the eigenvalues
eigDF<-data.frame("Real"=Re(eigvals), "Imaginary"=Im(eigvals)) ## Build a dataframe
my_radius<-sqrt(N) ## the radius of the circle is sqrt(N)
ellDF<-build_ellipse(my_radius, my_radius) ## dataframe to plot the ellipse
names(ellDF) <- c("Real", "Imaginary") ## rename the columns
p<-ggplot(eigDF, aes(x=Real, y=Imaginary))
p<-p+geom_point(shape=I(3))+theme(legend.position = "none")
p<-p+geom_hline(aes(yintercept=0))
p<-p+geom_vline(aes(xintercept=0))
p<-p+geom_polygon(data = ellDF, aes(x=Real, y=Imaginary, alpha=1/20, fill="red"));p

a<-read.table("../Data/Results.txt", header = T)
head(a)
a$ymin<-rep(0,dim(a)[1]) ## append a column of zeros

## Print the first linerange
p<-ggplot(a)
p<-p+geom_linerange(data = a, aes(x=x, ymin=ymin,ymax=y1,size=.5),colour="#E69F00", alpha=.5, show.legend = F)

## print the second linerange
p<-p+geom_linerange(data = a, aes(x=x, ymin=ymin, ymax=y2, size=.5), colour="#56B4E9", alpha=.5, show.legend = F)

## print the third linerange
p<-p+geom_linerange(data = a, aes(x=x, ymin=ymin, ymax=y3, size=.5), colour="#D55E00", alpha=.5, show.legend = F)

## annotate the plot with labels
p<-p+geom_text(data = a, aes(x=x, y=-500, label=Label))

## not set the axis labels, remove the legend, and prepare for bw printing
p<-p+scale_x_continuous("My x axis", breaks = seq(3,5,by=.05))+ scale_y_continuous("My y axis")+ theme_bw()+ theme(legend.position = "none");p

x<-seq(0,100,by=.1)
y<--4+.25*x+rnorm(length(x),mean=0., sd=2.5)

## and put them in a dataframe
my_data<-data.frame(x=x, y=y)

## perform a linear regressioln
my_lm<-summary(lm(y~x, data = my_data))
p<-ggplot(my_data, aes(x=x, y=y, colour=abs(my_lm$residuals)))+geom_point()+scale_color_gradient(low = "black", high = "red")+theme(legend.position = "none")+scale_x_continuous(expression(alpha^2*pi/beta*sqrt(Theta)))
p<-p+geom_abline(intercept = my_lm$coefficients[1][1], slope=my_lm$coefficients[2][1], colour="red")
## throw some math on the plot
p<-p+geom_text(aes(x=60, y=0, label="sqrt(alpha) *2 *pi"), parse = T, size=6, colour="blue");p

library(ggthemes)
p<-ggplot(MyDF, aes(x=log(Predator.mass), y=log(Prey.mass), colour=Type.of.feeding.interaction))+geom_point(size=I(2),shape=I(10))+theme_bw()
p+geom_rangeframe()+ ## now fine tune the geom to Tufte's range frame
  theme_tufte() ## and theme to Tufte's minimal ink theme
