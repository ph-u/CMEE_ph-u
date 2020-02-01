rm(list=ls()) #Clear global environment 
#Set working directory
setwd("/Users/emmadeeks/Desktop/CMEECourseWork/week8/data")

# Get thee required packages
require('minpack.lm')
library('dplyr')
library('tidyr')


######################################## PREPARES DATA ###################
#Explore the data 
data <- read.csv('modified_CRat.csv', header = TRUE) #reads in data

data <- data[, -1] #removes first column 
#Subset data with a nice looking curve to model with 
Data2Fit <- subset(data, ID == 39982) #One curve, this is testing the data with just one curve
# Plot the curve 
plot(Data2Fit$ResDensity, Data2Fit$N_TraitValue) #plotting the curve 

data2 <- data %>%
  nest(data= -ID) #this is experimenting with nesting, by nesting the data i can suset the day by ID and go into that


####################### OBTAINING STARTING VALUES- OBTAINING STARTING VALUES ######################

a.line <- subset(Data2Fit, ResDensity <= mean(ResDensity))
plot(a.line$ResDensity, a.line$N_TraitValue)

#plot slope/ linear regressopn of cut slope 
lm <- summary(lm(N_TraitValue ~ ResDensity, a.line))
# Extracts slope value
a <- lm$coefficients[2]
# h parameter is the maximum of the slope so you take the biggest value 
h <- max(Data2Fit$N_TraitValue)

q = -1 


obtaining_start_values <- function(data){
h <- c()
removeddata <- c()
CurveData <- c()
lm <- c()
a <- c()
### Identify the peak of the curve (This is equal to the peak handling time)
### Store the peak handling time in a variable (h)
h <- max(data$N_TraitValue)
### Remove points after this value in order to fit models to the growth period
# Store x value for corresponding peak y value
removeddata = data$ResDensity[which.max(data$N_TraitValue)]
# Subset the data to contain only x values lower than this point
CurveData <- subset(data, ResDensity < removeddata)
### Calculate the linear regression of the cut slope
lm <- summary(lm(N_TraitValue ~ ResDensity, CurveData))
### Extract the value for the gradient, which is equal to the search rate
a <- lm$coefficients[2]
return(c(a, h))
} 

############# INPUTTING STARTING VALUES INTO 
finalframe = as.data.frame(matrix(nrow = 1, ncol = 3))
for(i in 1:length(data2$ID)){
  toadd <- c()
  datatry <- data2$data[[i]]
  ID <- data2$ID[[i]]
  okay <- obtaining_start_values(datatry)
  toadd <- c(ID, okay[1], okay[2])
  finalframe <- rbind(finalframe, toadd)
}

datatouse <- finalframe[-1, ]  

datcol<-c("ID","a","h")
colnames(datatouse) <- datcol
#datatouse <- na.omit(datatouse)

####################################### DEFINING FUNCTIONS OF MODELS ##############

#Holling type II functional response
#This is making a function of the second model we looked at 
powMod <- function(x, a, h) { #These are parameters
  return( (a*x ) / (1+ (h*a*x))) # This is the equation
}


#Generalised functional response model

GenMod <- function(x, a, h, q) { #These are parameters
  return( (a* x^(q+1) ) / (1+ (h*a*x^(q+1)))) # This is the equation 
}


################################### FITTING MODELS #############################

PowFit <- nlsLM(N_TraitValue ~ powMod(ResDensity, a, h), data = Data2Fit, start = list(a=a, h=h)) #as shown in the example document this is how to fit the model using NLLs function in model fitting package

QuaFit <- lm(N_TraitValue ~ poly(ResDensity,2), data = Data2Fit) #only use lm for this as it is just a lm 

GenFit <- nlsLM(N_TraitValue ~ GenMod(ResDensity, a, h, q), data = Data2Fit, start = list(a=a, h=h, q= q)) #also use minipack for this as well 

############################## PLOTTING MODELS ###################################

Lengths <- seq(min(Data2Fit$ResDensity),max(Data2Fit$ResDensity)) #so it runs through the points 

#as suggested in the model fitting exercise fit the models using the coefficients of the starting values 
Predic2PlotPow <- powMod(Lengths,coef(PowFit)["a"],coef(PowFit)["h"]) #apply the functions and save to a variable
Predic2PlotQua <- predict.lm(QuaFit, data.frame(ResDensity = Lengths))
Predic2PlotGen <- GenMod(Lengths,coef(GenFit)["a"],coef(GenFit)["h"], coef(GenFit)["q"])

# plot this lines onto a plot for visual comparison 
plot(Data2Fit$ResDensity, Data2Fit$N_TraitValue)
lines(Lengths, Predic2PlotGen, col = 'green', lwd = 2.5)
lines(Lengths, Predic2PlotPow, col = 'blue', lwd = 2.5)
lines(Lengths, Predic2PlotQua, col = 'red', lwd = 2.5)
legend("topleft", legend = c("Holling Type II", "Quadratic", "Generalised FR"), lwd=2, lty=1, col=2:4)

########################## LOOPING FUNCTIONS ############

################ CORRECT FOR LOOP FOR RUNNING THROUGH ALL FUNCTIONS MAYBE #########
# nest the data to id 
data2 <- data %>%
  nest(-ID)

#create a vector with model names 
modelvec<-c("PowFit","QuaFit","GenFit") 

# create two new columns and convert into a data frame with the AICs and BICs 
modelvec<-data.frame("Model"=modelvec,
              "AIC"=rep(NA,length(modelvec)),
              "BIC"=rep(NA,length(modelvec)))

#paraopt = as.data.frame(matrix(nrow = 1, ncol = 7), stringsAs)
# Create new data frame to store values
paraopt<-data.frame("ID"= NA,
                     "a"= NA,
                     "h"= NA, "minAIC"= NA, "minBIC"= NA, "AIC"= NA, "BIC"= NA, stringsAsFactors = T)

#col <- c("ID", "a", "h", "min AIC", "min BIC", "AIC", "BIC")
#colnames(paraopt) <- col
#paraopt <- paraopt[-1 , ]
data2 <- merge(data2, datatouse, by= "ID")

for(i in 1:length(data2$data)){
  index <- c()
  add <- c()
  datatry <- data2$data[[i]] #select each data category 
  #and fit the model to it like before in the example 
  # use try because it stops any null values being included
  a <- data2$a[i]
  h <- data2$h[i]
  q = -1
  PowFit <- try(nlsLM(N_TraitValue ~ powMod(ResDensity, a, h), data = datatry, start = list(a=a, h=h)), silent=T)
  QuaFit <- try(lm(N_TraitValue ~ poly(ResDensity,2), data = datatry), silent=T)
  GenFit <- try(nlsLM(N_TraitValue ~ GenMod(ResDensity, a, h, q), data = datatry, start = list(a=a, h=h, q= q)), silent=T)
  #select each index of the modelvec dataframe, one for each model 
  # if the powfit is an error then repeat two more times, if it isnt an error then output the two AIC values 
  modelvec[1,2]<-ifelse(class(PowFit)=="try-error",rep(NA,2), (AIC(PowFit)))
  modelvec[2,2]<-ifelse(class(QuaFit)=="try-error",rep(NA,2), (AIC(QuaFit)))
  modelvec[3,2]<-ifelse(class(GenFit)=="try-error",rep(NA,2), (AIC(GenFit)))
  modelvec[1,3]<-ifelse(class(PowFit)=="try-error",rep(NA,2), (BIC(PowFit)))
  modelvec[2,3]<-ifelse(class(QuaFit)=="try-error",rep(NA,2), (BIC(QuaFit)))
  modelvec[3,3]<-ifelse(class(GenFit)=="try-error",rep(NA,2), (BIC(GenFit)))
  okAIC <- modelvec[which(modelvec$AIC==min(modelvec$AIC,na.rm = T)), 1]
  okBIC <- modelvec[which(modelvec$BIC==min(modelvec$BIC,na.rm = T)), 1]
  okAIC <- as.character(okAIC[1][[1]])
  okBIC <- as.character(okBIC[1][[1]])
  #index <- apply(modelvec,2, min)
  minAIC <- min(modelvec[,2], na.rm=T)
  minBIC <- min(modelvec[,3], na.rm=T)
  add <- c(data2$ID[[i]], a, h, okAIC, okBIC, minAIC, minBIC)
  #add <- ifelse(okAIC[1]==length(1), c(data2$ID[[i]], a, h, okAIC[1], okBIC[1], index[2], index[3]), )
  #tryCatch(, warning = function(c) print(paste("warning on id", i)))
  paraopt <- rbind(paraopt, add)
  #cat(paste0("id: ",data2$ID[[i]]," ; min AIC:",modelvec[which(modelvec$AIC==min(modelvec$AIC,na.rm = T)),1]," ; min BIC:",modelvec[which(modelvec$BIC==min(modelvec$BIC,na.rm = T)),1],"\n"))
  
}


optimising <-data.frame("ID"= NA,
                    "a"= NA,
                    "h"= NA, "minAIC"= NA, stringsAsFactors = T)


for(i in 1:length(data2$data)){
  datatry <- data2$data[[i]] #select each data category 
  #and fit the model to it like before in the example 
  # use try because it stops any null values being included
  a <- data2$a[i]
  h <- data2$h[i]
  avalues <- rnorm(10, a, 0.00000000001)
  hvalues <- rnorm(10, h, 0.000000000001)
  id <- data2$ID[i]
  TempTable <- data.frame("avalues" = NA, "hvalues" = NA, "AIC_Hol_values" = NA)
  for (i in 1:length(avalues)){
    ### Fit models
    AICHol <- c()
    anew <- avalues[i]
    hnew <- hvalues[i]
    PowFit <- try(nlsLM(N_TraitValue ~ powMod(ResDensity, anew, hnew), data = datatry, start = list(a=anew, h=hnew)), silent=T)
    # Holling II model
    AICHol <- ifelse(class(PowFit) == "try-error", NA, AIC(PowFit))
    temptable <- c(anew, hnew, AICHol)
    TempTable <- rbind(TempTable, temptable)
  }
  minAIC <- min(TempTable[,3])
  add <- c(id, a, h, minAIC)
  optimising <- rbind(optimising, add)
}




######################## NOTES 
