#!/bin/env R

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: pokho_HPC_2019_test.R
# Desc: test *_main.R script
# Input: Rscript pokho_HPC_2019_test.R
# Output: none
# Arguments: 0
# Date: Nov 2019

# CMEE 2019 HPC excercises R code HPC run code proforma

rm(list=ls()) # good practice 
source("pokho_HPC_2019_main.R")
# it should take a faction of a second to source your file
# if it takes longer you're using the main file to do actual simulations
# it should be used only for defining functions that will be useful for your cluster run and which will be marked automatically

# do what you like here to test your functions (this won't be marked)
# for example
species_richness(c(1,4,4,5,1,6,1))
# should return 4 when you've written the function correctly for question 1

# you may also like to use this file for playing around and debugging
# but please make sure it's all tidied up by the time it's made its way into the main.R file or other files.

## other tests
init_community_max(7)
init_community_min(4)
species_richness(init_community_max(7))
species_richness(init_community_min(4))
choose_two(4)