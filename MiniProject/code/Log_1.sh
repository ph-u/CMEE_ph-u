#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Log_1.sh
# Desc: control script for Log_1_c.R commander script
# Input: bash Log_1.sh
# Output: none
# Arguments: 0
# Date: Nov 2019

a0=`wc -l ../data/Log_Uq.txt|tr -s " "|cut -f 2 -d " "` ## get number of unique dataset for parallel processing

for i in `seq 1 $((${a0} -1))`;do ## parallel data subset processing
	nohup ./Log_1_c.sh ${i} 1e2 &
done

sleep 20 ## allow some time to run slave scripts before loading CPU for checking progress

## hault control script for intermediate data collection
while [ $((`ps aux|grep slave|grep R|wc -l`)) -gt 0 ];do
	sleep 10
done

## collect intermediate result
touch ../data/Log_tt_data.txt
touch ../data/Log_tt_para.txt
for i in `seq 1 $((${a0} -1))`;do ## parallel data subset processing
	cat ../data/Log_${i}_data.txt >> ../data/Log_tt_data.txt
	cat ../data/Log_${i}_para.txt >> ../data/Log_tt_para.txt
done

for i in `ls ../data/*|grep "Log_[0-9]*_[dp]a[tr]a.txt"`;do
	rm ${i}
done
rm nohup*
exit
