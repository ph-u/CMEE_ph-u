#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Log_n.sh
# Desc: Collector for scattered numbers for insertion into report `Log_r.tex`
# Input: ```./Log_n.sh```
# Output: Log_total.txt in `results` subdirectory
# Arguments: 0
# Date: Dec 2019

echo -e "number collection for report"
rm ../results/Log_total.txt 2>nohup.out
cd ../data
touch ../results/Log_total.txt

for j in stat PCA appdx cite;do
	i=`echo -e "ttt_${j}.txt"`
	cat ${i} >> ../results/Log_total.txt
	rm ${i}
done

exit
