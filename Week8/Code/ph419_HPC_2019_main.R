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
cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name,
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
  
  r.0<-data.frame(seq(1,100),c(5e2,1e3,2.5e3,5e3)) ## ref df
  
  a.05<-a.10<-a.25<-a.50<-0
  cat("contain ");for(i in 1:dim(r.0)[1]){
    a<-try(load(paste0(full_path,dist_path,"q18_",i,".rda")), silent = T)
    # a<-try(load(paste0("q18_",i,".rda")), silent = T)
    if(class(a)!="try-error"){cat(paste0(i,"; "))
      if(size==5e2){ ## size 500
        for(j in 1:length(abdO)){
          a.05<-sum_vect(a.05,abdO[[j]])
          a.05b<-burn_in_generations
        }
      }else if(size==1e3){ ## size 1000
        for(j in 1:length(abdO)){
          a.10<-sum_vect(a.10,abdO[[j]])
          a.10b<-burn_in_generations
        }
      }else if(size==2.5e3){ ## size 2500
        for(j in 1:length(abdO)){
          a.25<-sum_vect(a.25,abdO[[j]])
          a.25b<-burn_in_generations
        }
      }else{## size 5000
        for(j in 1:length(abdO)){
          a.50<-sum_vect(a.50,abdO[[j]])
          a.50b<-burn_in_generations
        }
      }
    }
  };rm(i);cat("\n")
  
  pdf(paste0(full_path,"results/abundances.pdf"))
  ## plot
  par(mfrow=c(2,2))
  try(barplot(octaves(a.05)~seq(1,length(octaves(a.05))), xlab = paste0("octave for burn-in generations ",a.05b/1e3,"K"), ylab = "abundance", ylim = c(0,max(octaves(a.05))*1.3)), silent = T)
  try(barplot(octaves(a.10)~seq(1,length(octaves(a.10))), xlab = paste0("octave for burn-in generations ",a.10b/1e3,"K"), ylab = "abundance", ylim = c(0,max(octaves(a.10))*1.3)), silent = T)
  try(barplot(octaves(a.25)~seq(1,length(octaves(a.25))), xlab = paste0("octave for burn-in generations ",a.25b/1e3,"K"), ylab = "abundance", ylim = c(0,max(octaves(a.25))*1.3)), silent = T)
  try(barplot(octaves(a.50)~seq(1,length(octaves(a.50))), xlab = paste0("octave for burn-in generations ",a.50b/1e3,"K"), ylab = "abundance", ylim = c(0,max(octaves(a.50))*1.3)), silent = T)
  
  dev.off()
  
  combined_results <- list(a.05, a.10, a.25, a.50) #create your list output here to return
  save(combined_results,file = "../results/ph419_cx1_results.rda")
  return(combined_results)
}

# Question 21
question_21 <- function(x.0=3, x.1=8)  {
  x<-log(x.1)/log(x.0)
  return(cat(paste0(x,"\ndimension 1 of biggest structure contains ",x.0," repeating units, and the whole biggest structure contains ",x.1," repeating units")))
}

# Question 22
question_22 <- function(x.0=3, x.1=20)  {
  x<-log(x.1)/log(x.0)
  return(cat(paste0(x,"\ndimension 1 of biggest structure contains ",x.0," repeating units, and the whole biggest structure contains ",x.1," repeating units")))
}

# Question 23
chaos_game <- function(x=0, y=0, colrr=rgb(0,0,0,1), xI=c(0,3,4), yI=c(0,4,1))  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  a<-as.matrix(data.frame(xI,yI))
  a.p<-as.data.frame(matrix(nrow = 0, ncol = 2))
  a.p<-rbind(a.p,c(x,y))
  
  t.0<-proc.time()[3]
  repeat{
    r<-sample(dim(a)[1],1)
    a.p<-rbind(a.p,c((a[r,1]+a.p[dim(a.p)[1],1])/2,(a[r,2]+a.p[dim(a.p)[1],2])/2))
    if(proc.time()[3]-t.0>20){break}
  }
  
  plot(x = a.p[,1], y = a.p[,2], type = "p", xlim = c(min(a.p[,1]),max(a.p[,1])), ylim = c(min(a.p[,2]),max(a.p[,2])), xlab = "x", ylab = "y", cex=.01, pch=1, col=colrr)
  return("a fractal triangle with three spikes at the pre-designed points")
}

# Question 24
turtle <- function(start_position=c(0,0), direction=.03, length=.1)  {
  a<-c(start_position[1]+length*cos(direction),start_position[2]+length*sin(direction))
  suppressWarnings(lines(x=c(start_position[1],a[1]), y=c(start_position[2],a[2]), col=rgb(.5,.5,0,1), add=T, cex=.01))
  return(a) # you should return your endpoint here.
}

# Question 25
elbow <- function(start_position=c(.1,.1), direction=0, length=.5)  {
  # graphics.off()
  # plot.new()
  a<-as.data.frame(matrix(nrow = 0, ncol = 2))
  a<-rbind(a,start_position)
  a<-rbind(a,turtle(start_position, direction, length))
  a<-rbind(a,turtle(a[dim(a)[1],], direction+pi/4, .95*length))
  suppressWarnings(lines(x=a[,1], y=a[,2], add=T))
}

# Question 26
spiral <- function(start_position=c(.15,0), direction=0, length=.45)  {
  a<-turtle(start_position,direction,length)
  suppressWarnings(lines(x=c(start_position[1],a[1]), y=c(start_position[2],a[2]), add=T))
  if(length>1e-9){
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
tree <- function(start_position=c(.5,0), direction=90*2*pi/360, length=.4, LR=0)  {
  a<-turtle(start_position,direction,length)
  suppressWarnings(lines(x=c(start_position[1],a[1]), y=c(start_position[2],a[2]), add=T))
  dirr<-direction+ifelse(LR==0,pi/4,-pi/4)
  lenn<-length*.65
  if(length>1e-2){
    tree(start_position = a, direction = dirr, length = lenn, LR=0)
    tree(start_position = a, direction = dirr, length = lenn, LR=1)
  }
}
draw_tree <- function()  {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  plot.new()
  a<-turtle(c(.5,.5),-pi/2,1)
  for(i in 0:1){
    tree(LR=i)
  }
}

# Question 29
fern <- function(start_position=c(.5,0), direction=90*2*pi/360, length=.4, LR=0)  {
  a<-as.data.frame(matrix(nrow = 0, ncol = 2))
  ang<-direction; len<-length
  ddir<-ifelse(LR==0,pi/4,0)
  llen<-ifelse(LR==0,.38,.87)
  a<-rbind(a,start_position)
  repeat{
    a<-rbind(a,turtle(a[dim(a)[1],],ang<-ang+ddir,len<-len*llen))
    if(len<1e-9){break}
  }
  suppressWarnings(lines(x=a[,1], y=a[,2], add=T))
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
  graphics.off() # clear any existing graphs and plot your graph within the R window
  fList<-length(list.files("../results/", pattern = "q18"))
  a.0<-vector(mode = "list", length = fList)
  
  for(i in 1:fList){
    load(paste0("../results/q18_",i,".rda"))
    a.2<-rep(NA,length(abdO))
    for(j in 1:length(abdO)){a.2[j]<-sum(abdO[[j]])}
    a.0[[i]]<-a.2
  }
  
  a.1<-as.data.frame(matrix(nrow = 0, ncol = 3))
  for(i in 1:4){
    for(j in 0:(length(a.0)/4-1)){
      if(j==0){a.2<-a.0[[i+j*4]]}else{a.2<-sum_vect(a.2,a.0[[i+j*4]])}
    }
    a.1<-rbind(a.1,data.frame(seq(1,length(a.2))-1,i,a.2))
  }
  a.1[,2]<-ifelse(a.1[,2]<3, ifelse(a.1[,2]<2,5e2,1e3), ifelse(a.1[,2]>3,5e3,25e2))
  
  plot(a.1[,3]/3~a.1[,1], type = "n", xlab = "generation", ylab = "species richness", pch=3)
  lines(a.1[which(a.1[,2]==5e2),3]/3~a.1[which(a.1[,2]==5e2),1], col=rgb(1,0,0,.3))
  lines(a.1[which(a.1[,2]==1e3),3]/3~a.1[which(a.1[,2]==1e3),1], col=rgb(0,0,0,.3))
  lines(a.1[which(a.1[,2]==25e2),3]/3~a.1[which(a.1[,2]==25e2),1], col=rgb(0,1,0,.3))
  lines(a.1[which(a.1[,2]==5e3),3]/3~a.1[which(a.1[,2]==5e3),1], col=rgb(0,0,1,.3))
  legend(x=1.7e4, y=70, lty = 1, col = c(rgb(1,0,0,1),rgb(0,0,0,1),rgb(0,1,0,1),rgb(0,0,1,1)), legend = c(5e2,1e3,25e2,5e3), title = "Community size")
}

# Challenge question D
Challenge_D <- function() {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  set.seed(9990)
  j<-N<-100
  v<-.1
  pop<-rep(1,j)
  abd<-c()
  th<-v*(j-1)/(1-v)
  repeat{
    chg<-sample(N,1)
    if(runif(1)<th/(th+N-1)){
      abd<-c(abd, pop[chg])
    }else{
      tmp<-seq(N)
      tmp<-tmp[which(tmp!=chg)]
      tmp<-sample(tmp,1)
      pop[tmp]<-pop[tmp]+pop[chg]
    }
    pop<-pop[-chg]
    if(N>1){N<-N-1}else{break}
  }
  return(octaves(abd))
}

# Challenge question E
Challenge_E <- function(x=1, y=0, colrr=rgb(1,0,0,1), xI=c(0,2,1), yI=c(0,0,sqrt(3/4))) {
  graphics.off() # clear any existing graphs and plot your graph within the R window
  chaos_game(x,y,colrr, xI, yI)
  return("initial points has no effect on resultant plot")
}

# Challenge question F
Challenge_F <- function() {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Challenge question G should be written in a separate file that has no dependencies on any functions here.


