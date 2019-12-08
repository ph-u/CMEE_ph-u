#!/bin/bash

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Log_1.sh
# Desc: control script for Log_1_c.sh commander script; call parallel data subset processing
# Input: bash Log_1.sh
# Output: none
# Arguments: 0
# Date: Nov 2019

a0=`wc -l ../data/Log_Uq.txt|tr -s " "|sed 's/^ *//g'|cut -f 1 -d " "` ## get number of unique dataset for parallel processing

echo -e "start data subset analysis"
for i in `seq 1 $((${a0} -1))`;do ## parallel data subset processing
	nohup ./Log_1_c.sh ${i} 1e2 &
done

i2=5
echo -e "wait ${i2} sec for analysis to finish"
sleep ${i2} ## allow some time to run slave scripts before loading CPU for checking progress

## hault control script for intermediate data collection
i1=2
while [ $((`ps aux|grep slave|grep R|wc -l`)) -gt 0 ];do
	echo -e "analysis process remaining: `ps aux|grep slave|grep R|wc -l`; sleep ${i1} sec"
	sleep ${i1}
done

## confirm no previoius run
rm ../data/Log_t1_* 2> nohup.out ## <https://stackoverflow.com/questions/31318068/shell-script-to-remove-a-file-if-it-already-exist>

## collect intermediate result

echo -e "collecting scattered analysis results"
touch ../data/Log_t1_data.txt
touch ../data/Log_t1_para.txt
for i in `seq 1 $((${a0} -1))`;do ## parallel data subset processing
	cat ../data/Log_${i}_data.txt >> ../data/Log_t1_data.txt
	cat ../data/Log_${i}_para.txt >> ../data/Log_t1_para.txt
done

for i in `ls ../data/Log_[0-9]*[tr]a.txt`;do
	rm ${i}
done
#rm nohup*
exit
