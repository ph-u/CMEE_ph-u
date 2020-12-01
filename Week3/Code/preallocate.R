#!/bin/env Rscript

# Author: ph-u
# Script: preallocate.R
# Desc: test function speed with & without preallocation
# Input: Rscript preallocate.R
# Output: two blocks of four-lined R interpreter output
# Arguments: 0
# Date: Oct 2019

ss<-function(p){
  a<-NA
  for(i in seq(1:p)){
    a<-c(a,i)
    # print(a)
    # print(object.size(a))
  }
  print(object.size(a))
}
sf<-function(p){
  a<-rep(NA,p)
  for(i in seq(1:p)){
    a[i]<-i
    # print(a)
    # print(object.size(a))
  }
  print(object.size(a))
}

print("Not pre-allocated:");print(system.time(ss(1e4)))
print("Pre-allocated:");print(system.time(sf(1e4)))
