#!/bin/env R

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: ph419_HPC_2019_main.R
# Desc: function input script
# Input: Rscript ph419_HPC_2019_main.R
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
  if(runif(1) < .5){community[a[1]] <- community[a[2]]}else{community[a[2]] <- community[a[1]]} ## determine 1st / 2nd element got replaced by the other
  return(community)
}

# Question 6
neutral_generation <- function(community){
  n0<-length(community)
  n1<-floor(n0/2)+n0%%2 ## calculate how many steps are going to run
  for(i in 1:n1){
    community<-neutral_step(community)
  }
  return(community)
}

# Question 7
neutral_time_series <- function(community,duration)  {
  sp_rich<-rep(NA,duration)
  for(i in 1:duration){
    community<-neutral_generation(community) ## calculate community players identity
    sp_rich[i]<-species_richness(community) ## add in sp-richness data into collected data
  }
  return(sp_rich)
}

# Question 8
question_8 <- function() {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  n0<-200 ## num of generations
  cat("num of generation: ")
  repeat{
    if(n0%%10==0){cat(paste0(n0,"; "))}
    a<-neutral_time_series(init_community_max(100), n0)
    if(min(a)==1){break} ## each run can never go up in species richness, assume no speciation (think biologically -- Francis Windram)
    n0<-n0+1 ## increase generation number if conditions not met
  }
  cat("\n")
  plot(a~seq(1:n0), pch=3, xlab="generation", ylab = "species richness", type="l", col="red") ## plot species richness 
  # lines(rep(1,n0)~seq(1:n0), add=T)
  
  return(cat(paste0("species richness = ",min(a)," at ",min(which(a==min(a)))," generations\nSpecies richness will always be either unchanged (replace by any of the species with multiple individuals) or decreased (when last of its kind get replaced)")))
}

# Question 9
neutral_step_speciation <- function(community,speciation_rate)  {
  a0<-choose_two(length(community))
  a1<-runif(2) ## array: [speciation?, which intial sp getting replaced]
  ## section allow spp reappearing
  # a2<-seq(1:length(community)^2)
  # a3<-a2!=community
  # a3<-sample(a2[a3==T],1)
  a3<-max(community)+1 ## not allow spp reappearing
  if(a1[2]<.5){i0<-1}else{i0<-2} ## determine which sp is getting replaced
  if(a1[1]<speciation_rate){i1<-a3}else{i1<-community[a0[i0%%length(a0)+1]]} ## determine replacement value
  community[a0[i0]]<-i1 ## replacement
  return(community)
}

# Question 10
neutral_generation_speciation <- function(community,speciation_rate)  {
  n0<-length(community)
  for(i in 1:(floor(n0/2)+n0%%2)){ ## run on designated generations
    community<-neutral_step_speciation(community,speciation_rate)
  }
  return(community)
}

# Question 11
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  sp_rich<-rep(NA, duration) ## pre-allocation of sp_richness collection vector
  for(i in 1:duration){
    community<-neutral_generation_speciation(community,speciation_rate)
    sp_rich[i]<-species_richness(community)
  }
  return(sp_rich)
}

# Question 12
question_12 <- function()  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  n0<-200; sp_rate<-.1; ind<-100 ## generation, speciation rate, population size
  a0<-neutral_time_series_speciation(init_community_max(ind),sp_rate, n0) ## initial pouplation max diversity
  a1<-neutral_time_series_speciation(init_community_min(ind),sp_rate, n0) ## initial population min diversity
  b0<-abs(a0-a1) ## calculate absolute population differences between the two intiial populations
  
  plot(a0~seq(1:n0), pch=3, xlab="generation", ylab = "species richness", type="l", col="red") ## plot species richness 
  suppressWarnings(lines(a1~seq(1:n0), pch=3, xlab="generation", ylab = "species richness", type="l", col="blue", add=T))
  legend(x=150,y=65,col = c("red","blue"), legend = c("max", "min"), title = "initial diversity", lty = 1:2)
  
  return(cat(paste0("Throughout ",n0," generations,\nIQR of species richness difference is ",IQR(b0),", from ",fivenum(b0)[2]," to ",fivenum(b0)[4],";\nIQR of high species diversity goup is from ",fivenum(a0)[2]," to ",fivenum(a0)[4],";\nIQR of low species diversity goup is from ",fivenum(a1)[2]," to ",fivenum(a1)[4],"\nReason of this pattern is due to the introduction of speciation with rate ",sp_rate,", which new mutations are hard to get rid of but diversity is easy to be reduced\nSo initial states have no observable effect on the final result\n"))) ## analysis summary
}

# Question 13
species_abundance <- function(community)  {
  return(rev(sort(unname(table(community))))) ## sort community abundances in decending order
}

# Question 14
octaves <- function(abundance_vector) {
  a<-table(floor(log2(abundance_vector))) ## normal abundance vector with names linked with numbers, not necessary accending names order
  a0<-data.frame(seq(0,max(names(a))),0) ## create ordered abundance reference form
  for(i in 1:dim(a0)[1]){try(a0[i,2]<-a[which(names(a)==a0[i,1])],silent = T)} ## fill out the form with known numbers
  return(as.numeric(a0[,2]))
}

# Question 15
sum_vect <- function(x, y) {
  if(length(x) < length(y)){a1<-x; a2<-y}else{a2<-x; a1<-y} ## let length(a2) always > length(a1)
  a1<-c(a1,rep(0,length(a2)-length(a1))) ## add 0 to end of shorter vector
  return(a1+a2)
}

# Question 16 
question_16 <- function()  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  n0<-200;sp_rate<-.1;ind<-100;duration<-2e3;smp<-20 ## set parameters: generation, speciation rate, population size, data collection generation, sampling interval
  a0<-0
  community<-floor(runif(ind,0,ind)) ## population size filled with random individuals with identity ranging from 0 to population size num
  for(i in 1:(n0+duration)){
    community<-neutral_generation_speciation(community, sp_rate)
    if(i > n0 & i%%smp==0){a0<-sum_vect(a0,octaves(species_abundance(community)))}
  }
  a0<-a0[which(a0>0)]/(duration/smp) ## remove all null pre-allocated gaps & find mean on samples
  barplot(a0~seq(1,length(a0)), xlab = "Octave", ylab = "average species abundance", ylim=c(0,max(a0)*1.2))
  return("initial condition has no observable effect.  As generation time increases, speciation rate dictates final species abundance result")
}

# Question 17
cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name)  {
  pop<-rep(1,size) ## create intiial min div population
  t1<-1 ## set ini generation
  sppR<-rep(NA,burn_in_generations) ## pre-allocate spp-richness vector
  abdO<-list() ## ini abundance octave list
  cat("at gen: ")
  
  t0<-unname(proc.time()[3])
  repeat{
    if(t1%%1e3==0){cat(paste0(t1/1e3,"K; "))} ## terminal print generation progress
    pop<-neutral_generation_speciation(pop,speciation_rate) ## model
    if(t1<=burn_in_generations & t1%%interval_rich==1){ ## record spp richness before population stabilizes
      sppR[t1]<-species_richness(pop)
    }else if(t1%%interval_oct==1){ ## recordabundance vector after population stabilizes
      abdO[[length(abdO)+1]]<-octaves(species_abundance(pop)) ## lengthening list for spp abundance
    }
    if(t1==burn_in_generations){popB<-pop} ## save population structure as initial state for dynamic equilibrium
    tE<-(unname(proc.time()[3])-t0)/60 ## timed code speed
    if(tE>wall_time){break}else{t1<-t1+1} ## check time
  }
  cat("\nSaving file...\n")
  
  ## output
  save(popB, abdO, pop, tE, speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, file = paste0("../results/",output_file_name))
  # save(popB, abdO, pop, tE, speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, file =output_file_name)
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
  n0<-200;sp_rate<-.1;ind<-100;ciNum<-.972 ## set parameters: burn-in generation num, speciation rate, pop size, confidence interval
  a.h<-a.l<-as.data.frame(matrix(nrow = 0, ncol = n0)) ## initialize recording df for both initial states
  repeat{
    a.h<-rbind(a.h,neutral_time_series_speciation(init_community_max(ind),sp_rate, n0)) ## record high diversity initial state
    a.l<-rbind(a.l,neutral_time_series_speciation(init_community_min(ind),sp_rate, n0)) ## record low diversity initial state
    if(dim(a.h)[1]>30 & fivenum(a.h[1:(dim(a.h)[1]-1),n0])[3]-fivenum(a.h[1:dim(a.h)[1],n0])[3]<1 & fivenum(a.l[1:(dim(a.l)[1]-1),n0])[3]-fivenum(a.l[1:dim(a.l)[1],n0])[3]<1){break} ## break loop if more than 30 generations run & median is stabilized
  }
  errh<-errl<-a.h.y<-a.l.y<-rep(NA,n0) ## pre-allocate record vectors
  xxx<-seq(n0) ## set x-axis
  for(i in 1:n0){
    errh[i]<-qnorm(ciNum)*sqrt(var(a.h[,i])/dim(a.h)[1]) ## calculate errors for high diversity initial state
    errl[i]<-qnorm(ciNum)*sqrt(var(a.l[,i])/dim(a.l)[1]) ## calculate errors for low diversity initial state
    a.h.y[i]<-median(a.h[,i]) ## extract median for each generation for every simulation on high div ini state
    a.l.y[i]<-median(a.l[,i]) ## extract median for each generation for every simulation on low div ini state
  }
  a.h.eqm<-min(which(abs(a.h.y[c(1:(length(a.h.y)-10))]-a.h.y[-c(1:10)])<1)) ## extract min time for establishing eqm on high div ini state
  a.l.eqm<-min(which(abs(a.l.y[c(1:(length(a.l.y)-10))]-a.l.y[-c(1:10)])<1)) ## extract min time for establishing eqm on low div ini state
  a.h.y<-c(a.h.y+errh,rev(a.h.y)-errh) ## create plot polygon y values on high div ini state
  a.l.y<-c(a.l.y+errl,rev(a.l.y)-errl) ## create plot polygon y values on low div ini state
  xxx<-c(xxx,rev(xxx)) ## create x values on both ini state
  
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
  n0<-200;sp_rate<-.1;ind<-100;ciNum<-.972 ## set parameters: burn-in generation, speciation rate, pop size, confidence interval
  a.h<-as.data.frame(matrix(nrow = 0, ncol = n0)) ## ini df for record simulations
  repeat{
    ind<-sample(ind,ind, replace = TRUE) ## create random sample of unbiased population
    a.h<-rbind(a.h,neutral_time_series_speciation(ind,sp_rate, n0)) ## simulation
    if(dim(a.h)[1]>30 & fivenum(a.h[1:(dim(a.h)[1]-1),n0])[3]-fivenum(a.h[1:dim(a.h)[1],n0])[3]<1){break} ## break loop if sample is large enough and median is stabilized
  }
  errh<-a.h.y<-rep(NA,n0) ## pre-allocation of recording vectors
  xxx<-seq(n0) ## create x-axis
  for(i in 1:n0){
    errh[i]<-qnorm(ciNum)*sqrt(var(a.h[,i])/dim(a.h)[1]) ## calculate error values vector
    a.h.y[i]<-median(a.h[,i]) ## calculate median values at every generation
  }
  a.h.eqm<-min(which(abs(a.h.y[c(1:(length(a.h.y)-10))]-a.h.y[-c(1:10)])<1)) ## extract generation of eqm
  a.h.y<-c(a.h.y+errh,rev(a.h.y)-errh) ## create plotting y-values
  xxx<-c(xxx,rev(xxx)) ## create plotting x-values
  
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


