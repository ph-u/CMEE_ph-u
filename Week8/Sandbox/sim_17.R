#!/bin/env R

## Desc: personal script, testing cluster runs
## Nov 2019

rm(list=ls()) # good practice 
source("../Code/pokho_HPC_2019_main.R")

cluster_run(.1, 100, wall_time=1, 1, 10, 200, "my_test_file_1.rda")

