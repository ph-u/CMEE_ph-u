#!/bin/bash

# Author: PokMan HO (pok.ho19@imperial.ac.uk)
# Script: write_readme.sh
# Desc: Write README.md in each Week's directory
# Arguments: 0
# Input: FirstName LastName year MSc/MRes base_dir
# Date: Oct 2019

echo -e "# $3 $1 $2 $4 CMEE Coursework ${i}" #>> ${dir}/${i}/README.md
head -n 2 ${dir}/ReadmeProg/tmp_readme.md #> ${dir}/${i}/README.md
