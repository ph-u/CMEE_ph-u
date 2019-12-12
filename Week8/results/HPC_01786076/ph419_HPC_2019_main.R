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
personal_speciation_rate <- 0.006101 # will be assigned to each person individually in class and should be between 0.002 and 0.007

# Question 1
species_richness <- function(community=c(1,4,4,5,1,6,1)){
  return(length(unique(community)))
}

# Question 2
init_community_max <- function(size=7){
  return(seq(1,size))
}

# Question 3
init_community_min <- function(size=7){
  return(rep(1,size))
}

# Question 4
choose_two <- function(max_value=4){
  a<-init_community_max(max_value)
  return(sample(a,2))
}

# Question 5
neutral_step <- function(community=c(10,5,13)){
  a<-choose_two(length(community))
  if(runif(1) < .5){community[a[1]] <- community[a[2]]}else{community[a[2]] <- community[a[1]]} ## determine 1st / 2nd element got replaced by the other
  return(community)
}

# Question 6
neutral_generation <- function(community=c(10,5,14)){
  n0<-length(community)
  n1<-floor(n0/2)+n0%%2 ## calculate how many steps are going to run
  for(i in 1:n1){
    community<-neutral_step(community)
  }
  return(community)
}

# Question 7
neutral_time_series <- function(community=init_community_max(7),duration=20)  {
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
  
  return(cat(paste0("species richness = ",min(a)," at ",min(which(a==min(a)))," generations\nSpecies richness will always be either unchanged (replace by any of the species with multiple individuals) or decreased (when last of its kind get replaced)\n")))
}

# Question 9
neutral_step_speciation <- function(community=c(10,5,13),speciation_rate=.2)  {
  a0<-choose_two(length(community))
  ## section allow spp reappearing
  # a2<-seq(1:length(community)^2)
  # a3<-a2!=community
  # a3<-sample(a2[a3==T],1)
  a3<-max(community)+1 ## not allow spp reappearing
  i0<-ifelse(runif(1)<.5,1,2) ## determine which sp is getting replaced
  i1<-ifelse(runif(1)<speciation_rate,a3,community[a0[i0%%length(a0)+1]]) ## determine replacement value
  community[a0[i0]]<-i1 ## replacement
  return(community)
}

# Question 10
neutral_generation_speciation <- function(community=c(10,5,13),speciation_rate=.2)  {
  n0<-length(community)
  for(i in 1:(floor(n0/2)+n0%%2)){ ## run on designated generations
    community<-neutral_step_speciation(community,speciation_rate)
  }
  return(community)
}

# Question 11
neutral_time_series_speciation <- function(community=c(10,5,13),speciation_rate=.2,duration=10)  {
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
  legend(x=150,y=65,col = c("red","blue"), legend = c("max", "min"), title = "initial diversity", lty = 1)
  
  return(cat(paste0("Throughout ",n0," generations,\nIQR of species richness difference is ",IQR(b0),", from ",fivenum(b0)[2]," to ",fivenum(b0)[4],";\nIQR of high species diversity goup is from ",fivenum(a0)[2]," to ",fivenum(a0)[4],";\nIQR of low species diversity goup is from ",fivenum(a1)[2]," to ",fivenum(a1)[4],"\nReason of this pattern is due to the introduction of speciation with rate ",sp_rate,", which new mutations are hard to get rid of but diversity is easy to be reduced\nSo initial states have no observable effect on the final result\n"))) ## analysis summary
}

# Question 13
species_abundance <- function(community=c(1,5,3,6,5,6,1,1))  {
  return(rev(sort(unname(table(community))))) ## sort community abundances in decending order
}

# Question 14
octaves <- function(abundance_vector=c(100,64,63,5,4,3,2,2,1,1,1,1)) {
  a<-table(floor(log2(abundance_vector))) ## normal abundance vector with names linked with numbers, not necessary accending names order
  a0<-data.frame(seq(0,max(names(a))),0) ## create ordered abundance reference form
  for(i in 1:dim(a0)[1]){try(a0[i,2]<-a[which(names(a)==a0[i,1])],silent = T)} ## fill out the form with known numbers
  return(as.numeric(a0[,2]))
}

# Question 15
sum_vect <- function(x=c(1,3), y=c(1,0,5,2)) {
  if(length(x) < length(y)){a1<-x; a2<-y}else{a2<-x; a1<-y} ## let length(a2) always > length(a1)
  a1<-c(a1,rep(0,length(a2)-length(a1))) ## add 0 to end of shorter vector
  return(a1+a2)
}

# Question 16 
question_16 <- function()  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  set.seed(9990)
  n0<-200;sp_rate<-.1;ind<-100;duration<-2e3;smp<-20 ## set parameters: generation, speciation rate, population size, data collection generation, sampling interval
  a0<-0
  community<-rep(1,ind)
  # community<-floor(runif(ind,0,ind)) ## population size filled with random individuals with identity ranging from 0 to population size num
  for(i in 1:(n0+duration)){
    community<-neutral_generation_speciation(community, sp_rate)
    if(i > n0 & i%%smp==0){a0<-sum_vect(a0,octaves(species_abundance(community)))}
  }
  a0<-a0[which(a0>0)]/(duration/smp) ## remove all null pre-allocated gaps & find mean on samples
  barplot(a0~seq(1,length(a0)), xlab = "Octave", ylab = "average species abundance", ylim=c(0,max(a0)*1.2))
  return("initial condition has no observable effect.  As generation time increases, speciation rate dictates final species abundance result")
}

# Question 17
cluster_run <- function(speciation_rate=personal_speciation_rate, size=100, wall_time=.001, interval_rich=1, interval_oct=10, burn_in_generations=200, output_file_name="my_test_file_1.rda",
                        full_path="../")  {
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
    }
    if(t1%%interval_oct==1){ ## interval record abundance vector
      abdO[[length(abdO)+1]]<-octaves(species_abundance(pop)) ## lengthening list for spp abundance
    }
    if(t1==burn_in_generations){popB<-pop} ## save population structure as initial state for dynamic equilibrium
    tE<-(unname(proc.time()[3])-t0)/(60^2) ## timed code speed
    if(tE>wall_time){break}else{t1<-t1+1} ## check time
  }
  cat("\nSaving file...\n")
  
  ## output
  save(popB, abdO, pop, tE, speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, file = paste0(full_path,"results/",output_file_name))
  # save(popB, abdO, pop, tE, speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, file =output_file_name)
}

# Questions 18 and 19 involve writing code elsewhere to run your simulations on the cluster

# Question 20 
process_cluster_results <- function(full_path="../", dist_path="results/")  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  r.0<-c(5e2,1e3,2.5e3,5e3) ## ref vec
  a.0<-list.files(path = paste0(full_path,dist_path), pattern = ".rda")
  a.1<-as.data.frame(matrix(nrow = length(a.0), ncol = 4)) ## rda num summary
  a.05<-a.10<-a.25<-a.50<-0
  cat("handling ")
  for(i in 1:length(a.0)){cat(paste0(i,"; "))
    a<-try(load(paste0(full_path, dist_path, "q18_",i,".rda")), silent = T)
    if(class(a)!="try-error"){
      a.1[i,]<-c(i,size,length(abdO),burn_in_generations) ## collect descriptive info
      a.2<-which(r.0==size) ## id which abundance dump should the data be saved to
      for(i0 in 1:length(abdO)){ ## collect abundance vectors
        if(a.2==1){
          a.05<-sum_vect(a.05, abdO[[i0]])
        }else if(a.2==2){
          a.10<-sum_vect(a.10, abdO[[i0]])
        }else if(a.2==3){
          a.25<-sum_vect(a.25, abdO[[i0]])
        }else{
          a.50<-sum_vect(a.50, abdO[[i0]])
        } ## save data in appropriate dump
      } ## for-loop sum vec
    } ## if load not try-error
  } ## for-loop on all rda files
  colnames(a.1)=c("run","size","NumGeneration","BurnIn")
  cat("\n")
  
  ## grab total number of combined data
  a.05b<-sum(a.1[which(a.1[,2]==r.0[1]),3])
  a.10b<-sum(a.1[which(a.1[,2]==r.0[2]),3])
  a.25b<-sum(a.1[which(a.1[,2]==r.0[3]),3])
  a.50b<-sum(a.1[which(a.1[,2]==r.0[4]),3])
  
  ## grab mean of total abundances
  a.05<-a.05/a.05b
  a.10<-a.10/a.10b
  a.25<-a.25/a.25b
  a.50<-a.50/a.50b
  
  pdf(paste0(full_path,"results/abundances.pdf"))
  ## plot
  par(mfrow=c(2,2))
  try(barplot(a.05~seq(1,length(a.05)), xlab = paste0("octave for ",round(a.05b/1e3),"K generations"), ylab = "abundance", ylim = c(0,max(a.05)*1.3)), silent = T)
  try(barplot(a.10~seq(1,length(a.10)), xlab = paste0("octave for ",round(a.10b/1e3),"K generationa"), ylab = "abundance", ylim = c(0,max(a.10)*1.3)), silent = T)
  try(barplot(a.25~seq(1,length(a.25)), xlab = paste0("octave for ",round(a.25b/1e3),"K generations"), ylab = "abundance", ylim = c(0,max(a.25)*1.3)), silent = T)
  try(barplot(a.50~seq(1,length(a.50)), xlab = paste0("octave for ",round(a.50b/1e3),"K generations"), ylab = "abundance", ylim = c(0,max(a.50)*1.3)), silent = T)
  
  dev.off()
  
  combined_results <- list(a.05, a.10, a.25, a.50) #create your list output here to return
  save(combined_results,file = "../results/ph419_cx1_results.rda")
  write.csv(a.1,"../results/ph419_cx1_summary.csv", row.names = F, quote = F)
  return(combined_results)
}

# Question 21
question_21 <- function(x.0=3, x.1=8)  {
  x<-log(x.1)/log(x.0)
  return(list(x,paste0("dimension 1 of biggest structure contains ",x.0," repeating units, and the whole biggest structure contains ",x.1," repeating units")))
}

# Question 22
question_22 <- function(x.0=3, x.1=20)  {
  x<-log(x.1)/log(x.0)
  return(list(x,paste0("dimension 1 of biggest structure contains ",x.0," repeating units, and the whole biggest structure contains ",x.1," repeating units")))
}

# Question 23
chaos_game <- function(x=0, y=0, xI=c(0,3,4), yI=c(0,4,1), time=20)  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  a<-data.frame(xI,yI) ## source points df
  a.p<-as.data.frame(matrix(nrow = 0, ncol = 2)) ## initiate running points df
  a.p<-rbind(a.p,c(x,y)) ## mark first point
  
  t.0<-proc.time()[3]
  repeat{
    r<-sample(dim(a)[1],1) ## pick a point that the marker will go towards
    a.p<-rbind(a.p,c((a[r,1]+a.p[dim(a.p)[1],1])/2,(a[r,2]+a.p[dim(a.p)[1],2])/2)) ## mark points
    if(proc.time()[3]-t.0>time){break} ## time's up
  }
  
  plot(x = a.p[,1], y = a.p[,2], type = "p", xlim = c(min(a.p[,1]),max(a.p[,1])), ylim = c(min(a.p[,2]),max(a.p[,2])), xlab = "", ylab = "", cex=.01) ## plot all points
  return("a fractal triangle with three vertices at pre-designed points")
}

# Question 24
turtle <- function(start_position=c(0,0), direction=.03, length=.1)  {
  a<-c(start_position[1]+length*cos(direction),start_position[2]+length*sin(direction))
  colouring<-c(rgb(0,.7,.1,1),rgb(.5,.5,.2,1),rgb(1,0,0,1)) ## leaves, branches, tips
  ccol<-ifelse(length>2e-2,colouring[2],ifelse(length>7e-4,colouring[1],colouring[3]))
  suppressWarnings(lines(x=c(start_position[1],a[1]), y=c(start_position[2],a[2]), col=ccol, add=T, cex=.01))
  return(a) # you should return your endpoint here.
}

# Question 25
elbow <- function(start_position=c(.1,.1), direction=0, length=.5)  {
  a<-turtle(start_position, direction, length) ## plot & record
  turtle(a, direction+pi/4, .95*length) ## call another plot
}

# Question 26
spiral <- function(start_position=c(.15,0), direction=0, length=.45)  {
  a<-turtle(start_position,direction,length) ## plot and record
  if(length>1e-9){ ## plot if length not too small
    spiral(start_position = a, direction = direction+pi/4, length = length*.95)
  }
}

# Question 27
draw_spiral <- function()  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  plot.new()
  spiral()
  return("Error: C stack usage ... too close to limit")
}

# Question 28
tree <- function(start_position=c(.5,0), direction=90*2*pi/360, length=.3)  {
  a<-turtle(start_position,direction,length)
  if(length>1e-3){
    tree(start_position = a, direction = direction+pi/4, length = length*.65) ## left branching
    tree(start_position = a, direction = direction-pi/4, length = length*.65) ## right branching
  }
}
draw_tree <- function()  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  plot.new()
  tree()
}

# Question 29
fern <- function(start_position=c(0,0), direction=45*2*pi/360, length=.13)  {
  a<-turtle(start_position,direction,length)
  if(length > 0.005){
    fern(start_position = a, direction = direction, length = length*.87) ## straight branching
    fern(start_position = a, direction = direction-pi/4, length = length*.38) ## diverged branching
  }
}
draw_fern <- function()  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  plot.new()
  fern()
}

# Question 30
fern2 <- function(start_position=c(.5,0), direction=90*2*pi/360, length=.13, LR=1, details=3)  {
  a<-turtle(start_position,direction,length)
  if(length > 10^(-1*details)){
    fern2(start_position = a, direction = direction, length = length*.87, LR=-LR, details = details) ## inverted straight brnaching
    fern2(start_position = a, direction = direction+pi/4*LR, length = length*.38, LR = LR, details = details) ## diverged branching
  }
}
draw_fern2 <- function()  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  plot.new()
  fern2(details=2)
}

# Challenge questions - these are optional, substantially harder, and a maximum of 16% is available for doing them.  

# Challenge question A
Challenge_A <- function(burnInGen=200, sp_rate=.1, num_ind=100, ciNum=.972) {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  n0<-burnInGen ## burn-in generation
  sp_rate<-sp_rate ## speciation rate
  ind<-num_ind ## population size
  ciNum<-ciNum ## confidence interval
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
  sp_rate=.1 ## speciation rate
  num_ind=100 ## number of individuals
  cat("handling ")
  for(i in seq(1,num_ind,by = 10)){
    cat(paste0("sp_rich-",i,": "))
    sp_time<-c()
    pop=seq(1:i)
    pop=c(pop,sample(pop,num_ind-length(pop),replace = T)) ## fill up gaps using random species on population size with fixed species richness if necessary
    for(j in 1:30){
      if(j%%10==0){cat(paste0("rep-",j,"; "))}
      sp_time=sum_vect(sp_time,neutral_time_series_speciation(community = pop, speciation_rate = sp_rate, duration = num_ind))
    }
    sp_time=sp_time/j ## mean of species richness collected through j cycles
    if(i==1){
      plot(c(species_richness(pop),sp_time)~seq(0:num_ind), type="l", ylim=c(0,num_ind), xlab="generation time",ylab="species richness") ## plot mean species richness through time
    }else{
      suppressWarnings(lines(c(species_richness(pop),sp_time)~seq(0:num_ind), type="l", add=T))
    }
  }
  cat("\n")
}

# Challenge question C
Challenge_C <- function(path="../Data/run/") {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  fList<-length(list.files(path = path, pattern = "q18"))
  ref<-c(5e2,1e3,25e2,5e3) ## population size reference
  refLen<-rep(0,length(ref)) ## data size reference
  LNcol<-c(rgb(1,0,0,.3),rgb(0,0,0,.3),rgb(0,1,0,.3),rgb(0,0,1,.3)) ## colour for line plotting
  maxGen<-0 ## max generation time for plotting
  maxSpR<-0 ## max species richness for plotting
  a.0<-vector(mode = "list", length = length(ref))

  cat("handling ")
  for(i in 1:fList){
    if(i%%10==0){cat(paste0(i,"; "))}
    load(paste0(path,"q18_",i,".rda"))
    a.2<-rep(NA,length(abdO)) ## species richness vector in a time series (single run)
    for(j in 1:length(abdO)){
      a.2[j]<-sum(abdO[[j]]) ## species richness vector fill up
      maxGen<-ifelse(length(a.2)>maxGen,length(a.2),maxGen) ## update plot x-limit if necessary
    }
       maxSpR<-ifelse(max(a.2)>maxSpR,max(a.2),maxSpR) ## update plot y-limit if necessary
   a.0[[which(size==ref)]]<-sum_vect(a.0[[which(size==ref)]],a.2) ## collect species richness along time series
    refLen[which(size==ref)]<-refLen[which(size==ref)]+1 ## collect number of run for later mean calculation
  }
  cat("Plotting\n")
  plot(y=c(0,maxSpR), x=c(0,maxGen), type = "n", xlab = "generation", ylab = "mean species richness") ## initialize plot area
  for(i in 1:length(a.0)){
    suppressWarnings(lines(a.0[[i]]/refLen[i] ~ seq(length(a.0[[i]])), col=LNcol[i])) ## plot lines
  }
  legend(x=maxGen/2, y=maxSpR*.9, lty=1, col=LNcol, legend = ref, title = "Community size")
}

# Challenge question D
Challenge_D <- function(num_reps=1e2, samplesize=c(5e2,1e3,25e2,5e3)) {
  timing<-unname(proc.time()[3])
  graphics.off() # clear any existing graphs and plot your graph within the R window
  cat("handling rep: ")
  a.05<-a.10<-a.25<-a.50<-c()
  set.seed(99999)
  for(i in 1:num_reps){
    if(i%%1e3==0){cat(paste0(i/1e3,"K; "))}
    j<-N<-ifelse(i%%4==0,samplesize[4],samplesize[i%%4]) ## set ref sample size
    v<-personal_speciation_rate
    pop<-rep(1,j) ## initialize assuming all idividuals from different species
    abd<-c()
    th<-v*(j-1)/(1-v)
    repeat{
      chg<-sample(N,1) ## choose individual to be identity-changed
      if(runif(1)<th/(th+N-1)){
        abd<-c(abd, pop[chg]) ## new sp found; extract out from community
      }else{
        tmp<-seq(N)
        tmp<-tmp[which(tmp!=chg)] ## ensure choosing individual not overlapping changing one
        tmp<-sample(tmp,1) ## choose sp in community to merge with
        pop[tmp]<-pop[tmp]+pop[chg] ## coalescence
      }
      pop<-pop[-chg] ## removed merged individual separate position in community
      if(N>1){N<-N-1}else{break} ## continue coalescence only when number of remaining known species identity > 1
    }
    if(i%%4==1){
      a.05<-sum_vect(a.05,octaves(abd))
    }else if(i%%4==2){
      a.10<-sum_vect(a.10,octaves(abd))
    }else if(i%%4==3){
      a.25<-sum_vect(a.25,octaves(abd))
    }else if(i%%4==0){
      a.50<-sum_vect(a.50,octaves(abd))
    }
  }
  cat(paste0("\nPlotting...\n"))
  ## calculate overall octaves
  oc.05<-a.05/(num_reps/length(samplesize))
  oc.10<-a.10/(num_reps/length(samplesize))
  oc.25<-a.25/(num_reps/length(samplesize))
  oc.50<-a.50/(num_reps/length(samplesize))
  
  ## plots
  yyl<-"abundance"
  xxl<-"octaves of size "
  par(mfrow=c(2,2))
  try(barplot(oc.05~seq(1:length(oc.05)), xlab=paste0(xxl,samplesize[1]), ylab=yyl, ylim=c(0,max(oc.05)*1.2)), silent = T)
  try(barplot(oc.10~seq(1:length(oc.10)), xlab=paste0(xxl,samplesize[2]), ylab=yyl, ylim=c(0,max(oc.10)*1.2)), silent = T)
  try(barplot(oc.25~seq(1:length(oc.25)), xlab=paste0(xxl,samplesize[3]), ylab=yyl, ylim=c(0,max(oc.25)*1.2)), silent = T)
  try(barplot(oc.50~seq(1:length(oc.50)), xlab=paste0(xxl,samplesize[4]), ylab=yyl, ylim=c(0,max(oc.50)*1.2)), silent = T)
  return(cat(paste0("The coalescence simulation has done ",num_reps/1e3,"K trials used approx ",round((unname(proc.time()[3])-timing)/60^2,2)," hours with 1 CPU\nThe reason is because vectors storing temporary data would not getting larger like forward simulations.  This saved more and more space for the computer to run increasingly faster.\n")))
}

# Challenge question E
Challenge_E <- function(x=1, y=0, xI=c(0,2,1), yI=c(0,0,sqrt(3/4)), time=20) {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  chaos_game(x,y, xI, yI, time)
  return("initial points has no effect on resultant plot")
}

# Challenge question F
Challenge_F <- function() {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  plot.new()
  for(i in c(2,2.3,2.7,3,3.3)){
    cat(paste0("plotting detail level = ",i,"\n"))
    fern2(details = i)
    Sys.sleep(1)
  }
  Sys.sleep(2)
  title(main = "Merry Christmas 2019~", sub = "and a Happy New Year!")
  return(cat("The output gives increasingly details in an exponential way\nGrowing a Christmas tree~\nMerry Christmas\n"))
}

# Challenge question G should be written in a separate file that has no dependencies on any functions here.


