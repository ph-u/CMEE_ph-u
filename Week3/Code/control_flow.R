#!/bin/env Rscript

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: control_flow.R
# Desc: test conditionals, `for` loops and `while` loops
# Input: Rscript control_flow.R
# Output: terminal output -- 1. 1-lined text string; 2. 100-lined text strings showing squared number results; 3. 3-lined text strings showing species names; 4. 3-lined text strings showing alphabet chain; 5. 100-lined numbers showing squared number results
# Arguments: 0
# Date: Oct 2019

## some code exemplifying control flow constructs in R

## if statement
a<-T
if(a==T){
  print("a is TRUE")
}else{
  print("a is FALSE")
}

## on a single line
z<-runif(1)## random number
if(z<=.5){
  print("less than a half")
}

## for loop using a sequence
for(i in 1:100){
  j<-i^2
  print(paste(i,"squared is",j))
}

## for loop over vector of strings
for(species in c("Heliodoxa rubinoides","Boissonneaua jardini","Sula nebouxii")){
  print(paste("The species is",species))
}

## for loop using a vector
v1<-c("a","bc","def")
for(i in v1){
  print(i)
}

## while loop
i<-0
while(i<100){
  i<-i+1
  print(i^2)
}