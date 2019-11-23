#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Log_2.sh
# Desc: collector for slave script results
# Input: bash Log_2.sh
# Output: combined result of best-fit parameters
# Arguments: 0
# Date: Nov 2019

a0=`wc -l Log_Uq.txt|tr -s " "|cut -f 2 -d " "`
a0=`echo $((${a0} -1))`


