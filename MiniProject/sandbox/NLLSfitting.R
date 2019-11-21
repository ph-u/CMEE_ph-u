#!/bin/env Rscript
# Author: Anne Marie Saunders
# Script: NLLSfitting.R
# Desc: Finds starting values for models, fits them, and calculates statistical measures of model fit
# Arguments: ../Data/CRat.csv
# Date: 19/11/19

# Load packages
library(minpack.lm)
library(ggplot2)

## Load the data
data = read.csv("../Data/CRatsClean.csv", header = T, stringsAsFactors = F)


## define the models we will use
# quad_explained = function(x, B0, B1, B2){
#   B0 + B1 * x + B2 * x^2
# }


# poly!! Look up function
#lm(y~poly(sub$ResDensity, 3))
# cubic_explained = function(x, B0, B1, B2, B3){
#   B0 + B1 * x + B2 * (x^2) + B3 * (x^3)
# }
# 
# holl2 = function(a, h, x){
#   return((a * x)/(1 + h * a * x))
# }

hollgen = function(q, a, h, x){
  return((a * (x^(q+1)))/(1 + h * a * (x^(q+1))))
}

start.values = function(dat){
  h1 = max(dat$N_TraitValue) # find the maximum
  maxrow = dat[dat$N_TraitValue == h1,]
  dat = dat[dat$ResDensity <= maxrow$ResDensity,] # only keep data points at or below the x value of h
  amodel = lm(dat$N_TraitValue~dat$ResDensity)
  #  plot(dat$N_TraitValue~dat$ResDensity, pch = 19, col = "darkblue")
  #  abline(amodel, col = 'red')
  a1 = unname(amodel$coefficients[2])
  return(c(a1, h1))
}

# #### Models ####
# cubic = function(data){
#   cat("\nNow fitting a cubic ")
#   cubic_aics = rep(NA, length(unique(data$ID)))
#   ids = unique(data$ID)
#   rettable = data.frame(cubic_aics, ids)
#   cubes = lm(y~poly(sub$ResDensity, 3))
# }


# ## Testing individual problems
holl.gen = function(d){
  #holl_aics = rep(NA, length(unique(data$ID)))
  #q_norm = rnorm(n = 500, mean = 0, sd = 1)
  #pdf(paste0('../Results/hollgencompiled.pdf'))
  # for(i in 1:length(unique(data$ID))){
  #   browser()
  #   id<-unique(data$ID)[i]
  #   sub = subset(data, data$ID == id)
  #   values = start.values(sub)
  #   # sample from a normal ldistribution around a and h to find best value
  #   a_norm = abs(rnorm(n = 500, mean = values[1], sd = 1))
  #   h_norm = abs(rnorm(n = 500, mean = values[2], sd = 1))
  #   aic = rep(NA, 500)
  #   a_new = rep(NA, 500)
  #   h_new = rep(NA, 500)
  #   q_new = rep(NA, 500)
  #   tests = data.frame(a_norm, h_norm, q_norm, aic, a_new, h_new, q_new)
    for(t in 1:length(d$a_norm)){
      holl2fit<-try(nlsLM(N_TraitValue ~ hollgen(q, a, h, ResDensity), data = sub, start = list(q = q_norm[t], a = a_norm[t], h = h_norm[t])), silent=T)
      if(class(holl2fit)!= "try-error"){
        d$aic[t] = AIC(holl2fit)
        d$a_new[t] = unname(coef(holl2fit)["a"])
        d$h_new[t] = unname(coef(holl2fit)["h"])
        d$q_new[t] = unname(coef(holl2fit)["q"])}
    }
    rm(t)
    bestrow = d[which(d$aic == min(d$aic, na.rm = T)),]
    # Create x values of the predicted line
    #densities = seq(min(sub$ResDensity), max(sub$ResDensity), by = (max(sub$ResDensity) - min(sub$ResDensity))/20)
    # Extract coefficients from the model fit
    #a2 = bestrow$a_new[1]
    #h2 = bestrow$h_new[1]
    #q2 = bestrow$q_new[1]
    # Calculate y values of the predicted line
    #Predict = hollgen(q2, a2, h2, densities)
    # Create a data frame of predicted values for input to ggplot
    #predictframe = data.frame(Predict, densities)
    # Plot the data and the model fit
    #print(ggplot(data = sub, aes(ResDensity, N_TraitValue)) + geom_point(colour = "hotpink3") + theme_bw() + xlab("Resource Density") + ylab("Consumption Rate") + ggtitle(label = id) + geom_line(color = "grey37", data = predictframe, aes(x = densities, y = Predict)))
    return(bestrow$aic[1])
  }  

#holl2model.fit(data)

#### Main code ####
holl_aics = rep(NA, length(unique(data$ID)))
q_norm = rnorm(n = 500, mean = 0, sd = 1)
cat('\nNow fitting the Generalized Holling model to the data\n...\n')
for(i in 1:length(unique(data$ID))){
  id<-unique(data$ID)[i]
  sub = subset(data, data$ID == id)
  cat("Starting start.values\n")
  values = start.values(sub)
  # sample from a normal ldistribution around a and h to find best value
  a_norm = abs(rnorm(n = 500, mean = values[1], sd = 1))
  h_norm = abs(rnorm(n = 500, mean = values[2], sd = 1))
  aic = rep(NA, 500)
  a_new = rep(NA, 500)
  h_new = rep(NA, 500)
  q_new = rep(NA, 500)
  tests = data.frame(a_norm, h_norm, q_norm, aic, a_new, h_new, q_new)
  cat("Starting holl.gen\n\n")
  holl_aics[i] = holl.gen(tests)
  if(i %% 20 == 0){
    cat(paste0(round((i/308)*100)," % finished!\n"))
  }
}
rm(i)

ids = unique(data$ID)
comp_frame = data.frame(ids, holl_aics)

## End Goal: find models or datas that consistantly fail and examine why


# # THIS WORKS- KEEP AS BACKUP 
# pdf(paste0('../Results/holl2compiled.pdf'))
# for(id in unique(data$ID)){
#   sub = subset(data, data$ID == id)
#   values = start.values(sub)
#   # sample from a normal ldistribution around a and h to find best value
#   a_norm = abs(rnorm(n = 500, mean = values[1], sd = 1))
#   h_norm = abs(rnorm(n = 500, mean = values[2], sd = 1))
#   aic = rep(NA, 500)
#   a_new = rep(NA, 500)
#   h_new = rep(NA, 500)
#   tests = data.frame(a_norm, h_norm, aic, a_new, h_new)
#   for(t in 1:length(tests$a_norm)){
#     holl2fit<-try(nlsLM(N_TraitValue ~ holl2(a, h, ResDensity), data = sub, start = list(a = a_norm[t], h = h_norm[t])), silent=T)
#     if(class(holl2fit)!= "try-error"){
#       tests$aic[t] = AIC(holl2fit)
#       tests$a_new[t] = unname(coef(holl2fit)["a"])
#       tests$h_new[t] = unname(coef(holl2fit)["h"])}
#   }
#   bestrow = tests[which(tests$aic == min(tests$aic, na.rm = T)),]
#   # Create x values of the predicted line
#   densities = seq(min(sub$ResDensity), max(sub$ResDensity), by = (max(sub$ResDensity) - min(sub$ResDensity))/20)
#   # Extract coefficients from the model fit
#   #a2 = values[1]
#   a2 = bestrow$a_new[1]
#   #h2 = values[2]
#   h2 = bestrow$h_new[1]
#   # Calculate y values of the predicted line
#   Predict = holl2(a2, h2, densities)
#   # Create a data frame of predicted values for input to ggplot
#   predictframe = data.frame(Predict, densities)
#   # Plot the data and the model fit
#   print(ggplot(data = sub, aes(ResDensity, N_TraitValue)) + geom_point(colour = "hotpink3") + theme_bw() + xlab("Resource Density") + ylab("Consumption Rate") + ggtitle(label = id) + geom_line(color = "grey37", data = predictframe, aes(x = densities, y = Predict)))
# }  
# graphics.off()
