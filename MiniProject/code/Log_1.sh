#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Log_1.sh
# Desc: control script for Log_1_c.R commander script
# Input: bash Log_1.sh
# Output: none
# Arguments: 0
# Date: Nov 2019

a0=`wc -l Log_Uq.txt|tr -s " "|cut -f 2 -d " "`
a0=`echo $((${a0} -1))`


