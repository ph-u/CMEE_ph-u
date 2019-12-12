#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: ph419_HPC_2019_clus19.sh
# Desc: call trial run on `ph419_HPC_2019_19.R`
# Input: qsub -J 1-100 ph419_HPC_2019_clus19.sh
# Output: none
# Arguments: 0
# Date: Nov 2019

## test modeling script by given command
#PBS -l walltime=14:00:00
#PBS -l select=1:ncpus=1:mem=1gb
module load anaconda3/personal
echo "R start"
R --vanilla < $HOME/code/ph419_HPC_2019_cluster.R $1
echo "job $1 done"

exit
