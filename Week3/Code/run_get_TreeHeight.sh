#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: run_get_TreeHeight.sh
# Desc: call calculation programs of tree height in R and python3 respectively
# Input: ./run_get_TreeHeight.sh <.csv>
# Output: None
# Arguments: 1
# Date: Oct 2019

Rscript get_TreeHeight.R $1
python3 get_TreeHeight.py $1
