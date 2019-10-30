#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: run_MiniProject.sh
# Desc: Master script file reproducing the MiniProject
# Input: ./run_MiniProject.sh
# Output: 1. `pdf` output in main project subdirectory; 2. all result graphs in `results` subdirectory
# Arguments: 0
# Date: Oct 2019

echo -e "Running Analysis..."
Rscript Logistic.R

echo -e "Writing Report..."

echo -e "Done"
exit
