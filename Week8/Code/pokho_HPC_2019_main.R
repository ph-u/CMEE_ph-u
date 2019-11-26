#!/bin/env R

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: pokho_HPC_2019_main.R
# Desc: function input script
# Input: Rscript pokho_HPC_2019_main.R
# Output: none
# Arguments: 0
# Date: Nov 2019

# CMEE 2019 HPC excercises R code main proforma
# you don't HAVE to use this but it will be very helpful.  If you opt to write everything yourself from scratch please ensure you use EXACTLY the same function and parameter names and beware that you may loose marks if it doesn't work properly because of not using the proforma.

name <- "Pok Man Ho"
preferred_name <- "PokMan"
email <- "pok.ho19@imperial.ac.uk"
username <- "ph419"
personal_speciation_rate <- 0.002 # will be assigned to each person individually in class and should be between 0.002 and 0.007

# Question 1
species_richness <- function(community){
  return(length(unique(community)))
}

# Question 2
init_community_max <- function(size){
  return(seq(1,size))
}

# Question 3
init_community_min <- function(size){
  return(rep(1,size))
}

# Question 4
choose_two <- function(max_value){
  a<-init_community_max(max_value)
  return(sample(a,2))
}

# Question 5
neutral_step <- function(community){
  a<-choose_two(length(community))
  if(runif(1) < .5){community[a[1]] <- community[a[2]]}else{community[a[2]] <- community[a[1]]}
  return(community)
}

# Question 6
neutral_generation <- function(community){
  n0<-length(community)
  n1<-floor(n0/2)+n0%%2
  for(i in 1:n1){
    community<-neutral_step(community)
  }
  return(community)
}

# Question 7
neutral_time_series <- function(community,duration)  {
  sp_rich<-c()
  for(i in 1:duration){
    community<-neutral_generation(community)
    sp_rich<-c(sp_rich,species_richness(community))
  }
  return(sp_rich)
}

# Question 8
question_8 <- function() {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  n0<-200
  cat("num of generation: ")
  repeat{
    if(n0%%10==0){cat(paste0(n0,"; "))}
    a<-neutral_time_series(init_community_max(100), n0)
    if(min(a)==1){break} ## each run can never go up in species richness, assume no speciation (think biologically -- Francis Windram)
    n0<-n0+1
  }
  cat("\n")
  plot(a~seq(1:n0), pch=3, xlab="generation", ylab = "species richness", type="l", col="red") ## plot species richness 
  # lines(rep(1,n0)~seq(1:n0), add=T)
  
  return(cat(paste0("species richness = ",min(a)," at ",min(which(a==min(a)))," generations\nSpecies richness will always be either unchanged (replace by any of the species with multiple individuals) or decreased (when last of its kind get replaced)")))
}

# Question 9
neutral_step_speciation <- function(community,speciation_rate)  {
  a0<-choose_two(length(community))
  a1<-runif(2)
  ## section allow spp reappearing
  # a2<-seq(1:length(community)^2)
  # a3<-a2!=community
  # a3<-sample(a2[a3==T],1)
  a3<-max(community)+1 ## not allow spp reappearing
  if(a1[2]<.5){i0<-1}else{i0<-2}
  if(a1[1]<speciation_rate){i1<-a3}else{i1<-community[a0[i0%%length(a0)+1]]}
  community[a0[i0]]<-i1
  return(community)
}

# Question 10
neutral_generation_speciation <- function(community,speciation_rate)  {
  n0<-length(community)
  if(n0%%2!=0 & runif(1)<.5){n1<-floor(n0/2)+n0%%2}else{n1<-floor(n0/2)}
  for(i in 1:n1){
    community<-neutral_step_speciation(community,speciation_rate)
  }
  return(community)
}

# Question 11
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  sp_rich<-c()
  for(i in 1:duration){
    community<-neutral_generation_speciation(community,speciation_rate)
    sp_rich<-c(sp_rich,species_richness(community))
  }
  return(sp_rich)
}

# Question 12
question_12 <- function()  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  n0<-200
  sp_rate<-.1
  ind<-100
  a0<-neutral_time_series_speciation(init_community_max(ind),sp_rate, n0)
  a1<-neutral_time_series_speciation(init_community_min(ind),sp_rate, n0)
  b0<-abs(a0-a1)
  
  plot(a0~seq(1:n0), pch=3, xlab="generation", ylab = "species richness", type="l", col="red") ## plot species richness 
  suppressWarnings(lines(a1~seq(1:n0), pch=3, xlab="generation", ylab = "species richness", type="l", col="blue", add=T))
  legend(x=150,y=65,col = c("red","blue"), legend = c("max", "min"), title = "initial diversity", lty = 1:2)
  
  # return(paste0("species richness min difference at ",b0," at ",which(abs(a0-a1)==b0)," generations"))
  return(cat(paste0("Throughout ",n0," generations,\nIQR of species richness difference is ",IQR(b0),", from ",fivenum(b0)[2]," to ",fivenum(b0)[4],";\nIQR of high species diversity goup is from ",fivenum(a0)[2]," to ",fivenum(a0)[4],";\nIQR of low species diversity goup is from ",fivenum(a1)[2]," to ",fivenum(a1)[4],"\nReason of this pattern is due to the introduction of speciation with rate ",sp_rate,", which new mutations are hard to get rid of but diversity is easy to be reduced\nSo initial states have no observable effect on the final result\n")))
}

# Question 13
species_abundance <- function(community)  {
  return(rev(sort(as.data.frame(table(community))[,2])))
}

# Question 14
octaves <- function(abundance_vector) {
  a<-table(floor(log2(abundance_vector)))
  a0<-data.frame(seq(0,max(names(a))),0)
  for(i in 1:dim(a0)[1]){try(a0[i,2]<-a[which(names(a)==a0[i,1])],silent = T)}
  return(as.numeric(a0[,2]))
}

# Question 15
sum_vect <- function(x, y) {
  if(length(x) < length(y)){a1<-x; a2<-y}else{a2<-x; a1<-y}
  a1<-c(a1,rep(0,length(a2)-length(a1)))
  return(a1+a2)
}

# Question 16 
question_16 <- function()  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  n0<-200;sp_rate<-.1;ind<-100;duration<-2e3;smp<-20
  # a0<-as.data.frame(matrix(nrow = ind,ncol = floor(duration/smp)+1))
  a0<-c()
  community<-floor(runif(ind,0,n0))
  for(i in 1:n0){
    community<-neutral_generation_speciation(community, sp_rate)
  }
  a0<-sum_vect(a0,octaves(species_abundance(community)))
  # i<-1
  # a1<-octaves(species_abundance(community))
  # a0[,i]<-c(a1,rep(0,dim(a0)[1]-length(a1)))
  for(i0 in 1:duration){
    community<-neutral_generation_speciation(community, sp_rate)
    if(i0%%20==0){
      # i<-i+1
      # a1<-octaves(species_abundance(community))
      # a0[,i]<-c(a1,rep(0,dim(a0)[1]-length(a1)))
      a0<-sum_vect(a0,octaves(species_abundance(community)))
    }
  }
  # a1<-c()
  # for(i in 1:dim(a0)[1]){a1<-c(a1,mean(as.numeric(a0[i,])))}
  # a1<-a1[which(a1>0)]
  a0<-a0[which(a0>0)]/(n0+duration)
  barplot(a0~seq(1,length(a0)), xlab = "Octave", ylab = "average species abundance")
  return("initial condition has no observable effect.  As generation time increases, speciation rate dictates final species abundance result")
}

# Question 17
cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name)  {
  
}

# Questions 18 and 19 involve writing code elsewhere to run your simulations on the cluster

# Question 20 
process_cluster_results <- function()  {
  # clear any existing graphs and plot your graph within the R window
  combined_results <- list() #create your list output here to return
  return(combined_results)
}

# Question 21
question_21 <- function()  {
  return("type your written answer here")
}

# Question 22
question_22 <- function()  {
  return("type your written answer here")
}

# Question 23
chaos_game <- function()  {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Question 24
turtle <- function(start_position, direction, length)  {
  
  return() # you should return your endpoint here.
}

# Question 25
elbow <- function(start_position, direction, length)  {
  
}

# Question 26
spiral <- function(start_position, direction, length)  {
  return("type your written answer here")
}

# Question 27
draw_spiral <- function()  {
  # clear any existing graphs and plot your graph within the R window
  
}

# Question 28
tree <- function(start_position, direction, length)  {
  
}
draw_tree <- function()  {
  # clear any existing graphs and plot your graph within the R window
}

# Question 29
fern <- function(start_position, direction, length)  {
  
}
draw_fern <- function()  {
  # clear any existing graphs and plot your graph within the R window
}

# Question 30
fern2 <- function(start_position, direction, length)  {
  
}
draw_fern2 <- function()  {
  # clear any existing graphs and plot your graph within the R window
}

# Challenge questions - these are optional, substantially harder, and a maximum of 16% is available for doing them.  

# Challenge question A
Challenge_A <- function() {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  n0<-200;sp_rate<-.1;ind<-100;ciNum<-.972
  a.h<-a.l<-as.data.frame(matrix(nrow = 0, ncol = n0))
  repeat{
    a.h<-rbind(a.h,neutral_time_series_speciation(init_community_max(ind),sp_rate, n0))
    a.l<-rbind(a.l,neutral_time_series_speciation(init_community_min(ind),sp_rate, n0))
    if(dim(a.h)[1]>30 & fivenum(a.h[1:(dim(a.h)[1]-1),n0])[3]-fivenum(a.h[1:dim(a.h)[1],n0])[3]<1 & fivenum(a.l[1:(dim(a.l)[1]-1),n0])[3]-fivenum(a.l[1:dim(a.l)[1],n0])[3]<1){break}
  }
  errh<-errl<-a.h.y<-a.l.y<-rep(NA,n0)
  xxx<-seq(n0)
  for(i in 1:n0){
    errh[i]<-qnorm(ciNum)*sqrt(var(a.h[,i])/dim(a.h)[1])
    errl[i]<-qnorm(ciNum)*sqrt(var(a.l[,i])/dim(a.l)[1])
    a.h.y[i]<-median(a.h[,i])
    a.l.y[i]<-median(a.l[,i])
  }
  a.h.eqm<-min(which(abs(a.h.y[c(1:(length(a.h.y)-10))]-a.h.y[-c(1:10)])<1))
  a.l.eqm<-min(which(abs(a.l.y[c(1:(length(a.l.y)-10))]-a.l.y[-c(1:10)])<1))
  a.h.y<-c(a.h.y+errh,rev(a.h.y)-errh)
  a.l.y<-c(a.l.y+errl,rev(a.l.y)-errl)
  xxx<-c(xxx,rev(xxx))
  
  plot(c(1,n0), c(0,max(a.h)), type = "n", xlab = "generations", ylab = "species richness")
  suppressWarnings(polygon(xxx,a.h.y, col = rgb(1,0,0,.5), add=T, border = NA))
  suppressWarnings(polygon(xxx,a.l.y, col = rgb(0,0,1,.5), add=T, border = NA))
  suppressWarnings(abline(v=a.h.eqm, col=rgb(1,0,0,1), add=T))
  suppressWarnings(text(x = a.h.eqm+5,y = 0, labels = a.h.eqm, col = rgb(1,0,0,1), add=T))
  suppressWarnings(abline(v=a.l.eqm, col=rgb(0,0,1,1), add=T))
  suppressWarnings(text(x = a.l.eqm+5,y = 5, labels = a.l.eqm, col = rgb(0,0,1,1), add=T))
  legend(x=50,y=max(a.h)*.9,col = c("red","blue"), legend = c("max", "min"), title = paste0(ciNum," C.I. on initial diversity"), lty = 1)
}

# Challenge question B
Challenge_B <- function() {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  n0<-200;sp_rate<-.1;ind<-100;ciNum<-.972
  a.h<-as.data.frame(matrix(nrow = 0, ncol = n0))
  repeat{
    ind<-sample(ind,ind, replace = TRUE)
    a.h<-rbind(a.h,neutral_time_series_speciation(ind,sp_rate, n0))
    if(dim(a.h)[1]>30 & fivenum(a.h[1:(dim(a.h)[1]-1),n0])[3]-fivenum(a.h[1:dim(a.h)[1],n0])[3]<1){break}
  }
  errh<-a.h.y<-rep(NA,n0)
  xxx<-seq(n0)
  for(i in 1:n0){
    errh[i]<-qnorm(ciNum)*sqrt(var(a.h[,i])/dim(a.h)[1])
    a.h.y[i]<-median(a.h[,i])
  }
  a.h.eqm<-min(which(abs(a.h.y[c(1:(length(a.h.y)-10))]-a.h.y[-c(1:10)])<1))
  a.h.y<-c(a.h.y+errh,rev(a.h.y)-errh)
  xxx<-c(xxx,rev(xxx))
  
  plot(c(1,n0), c(0,max(a.h)), type = "n", xlab = "generations", ylab = "species richness")
  suppressWarnings(polygon(xxx,a.h.y, col = rgb(0,0,0,.5), add=T, border = NA))
  suppressWarnings(abline(v=a.h.eqm, col=rgb(0,.5,.5,1), add=T))
  suppressWarnings(text(x = a.h.eqm+5,y = 0, labels = a.h.eqm, col = rgb(0,.5,.5,1), add=T))
  suppressWarnings(text(x = 100,y = max(a.h)*2/3, labels = paste0(ciNum," C.I. on varying initial diversity"), col = rgb(0,0,0,1), add=T))
}

# Challenge question C
Challenge_C <- function() {
  # clear any existing graphs and plot your graph within the R window
}

# Challenge question D
Challenge_D <- function() {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Challenge question E
Challenge_E <- function() {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Challenge question F
Challenge_F <- function() {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Challenge question G should be written in a separate file that has no dependencies on any functions here.


