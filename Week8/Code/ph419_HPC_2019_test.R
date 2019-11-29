#!/bin/env R

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: ph419_HPC_2019_test.R
# Desc: test *_main.R script
# Input: Rscript ph419_HPC_2019_test.R
# Output: terminal outputs and .rda file
# Arguments: 0
# Date: Nov 2019

# CMEE 2019 HPC excercises R code HPC run code proforma

rm(list=ls()) # good practice 
source("ph419_HPC_2019_main.R")
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
neutral_step(c(10,5,13))
neutral_generation(floor(runif(10,0,10)))
neutral_time_series(init_community_max(7),20)
question_8()
neutral_step_speciation(c(10,5,13),.2)
neutral_generation_speciation(floor(runif(10,0,10)),.2)

neutral_time_series_speciation(floor(runif(10,0,10)),.1,20)
question_12()
species_abundance(c(1,5,3,6,5,6,1,1))
octaves(c(100,64,63,5,4,3,2,2,1,1,1,1))
sum_vect(c(1,3),c(1,0,5,2))
question_16()
Challenge_A()
Challenge_B() ######### day 1
cluster_run(.1, 100, 10, 1, 10, 200, "my_test_file_1.rda")
process_cluster_results()
Challenge_C()
Challenge_D()

question_21()
question_22()
chaos_game()
Challenge_E()
turtle()
elbow()
spiral()
