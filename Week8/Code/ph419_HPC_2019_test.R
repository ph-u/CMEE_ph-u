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
species_richness()
# should return 4 when you've written the function correctly for question 1

# you may also like to use this file for playing around and debugging
# but please make sure it's all tidied up by the time it's made its way into the main.R file or other files.

## other tests
init_community_max()
init_community_min()
species_richness()
species_richness()
choose_two()
neutral_step()
neutral_generation()
neutral_time_series()
question_8()
neutral_step_speciation()
neutral_generation_speciation()
neutral_time_series_speciation()
question_12()
species_abundance()
octaves()
sum_vect()
question_16()

Challenge_A()
Challenge_B() ######### day 1
cluster_run(.1, 100, 10, 1, 10, 200, "my_test_file_1.rda")
process_cluster_results(dist_path = "Data/run/")
Challenge_C()
a<-unname(proc.time()[3])
Challenge_D()
unname(proc.time()[3])-a;rm(a)
question_21()
question_22()
chaos_game()
Challenge_E()
draw_spiral()
draw_tree()
draw_fern()
draw_fern2()
a<-unname(proc.time()[3])
Challenge_F()
unname(proc.time()[3])-a;rm(a)
