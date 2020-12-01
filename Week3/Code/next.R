#!/bin/env Rscript

# Author: ph-u
# Script: next.R
# Desc: 1-10 odd number printing
# Input: Rscript next.R
# Output: printing odd numbers from 1 to 10
# Arguments: 0
# Date: Oct 2019

for(i in 1:10){
  if((i%%2)==0)
    next ## pass to next iteration of loop
  print(i)
}
