MyDF<-read.csv("../Data/EcolArchives-E089-51-D1.csv")
dim(MyDF)
plot(MyDF$Predator.mass,MyDF$Prey.mass)
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass))
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass),pch=20) ## Change marker
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass),pch=20,xlab="Predator Mass (kg)",ylab="Prey Mass (kg)") ## add labels

hist(MyDF$Predator.mass)
hist(log(MyDF$Predator.mass),xlab = "Predator Mass (kg)", ylab = "Count") ## include labels
hist(log(MyDF$Predator.mass),xlab = "Predator Mass (kg)", ylab = "Count", col="lightblue", border = "pink") ## change bar and borders colours

## exercise

###################

par(mfcol=c(2,1)) ## initialize multi-paneled plot
par(mfg=c(1,1)) ## specify which sub-plot to use first
hist(log(MyDF$Predator.mass),xlab = "Predator Mass (kg)", ylab = "Count", col = "lightblue", border = "pink", main = "Predator") ## add title
par(mfg=c(2,1)) ## second sub-plot
hist(log(MyDF$Prey.mass), xlab = "Prey Mass (kg)", ylab = "Count", col = "lightgreen", border = "pink", main = "prey")
hist(log(MyDF$Predator.mass), ## predator histogram
     xlab = "Body Mass (kg)", ylab = "Count", col = rgb(1,0,0,.5), ## note "rgb", fourth value is transparency
     main = "Predator-prey size overlap")
hist(log(MyDF$Prey.mass), col = rgb(0,0,1,.5),add=T) ## plot prey
legend("topleft",c("predators","prey"), ## add legend
       fill = c(rgb(1,0,0,.5),rgb(0,0,1,.5))) ## define legend colours

## exercise

###################

## boxplot