#!/bin/bash

cd `dirname $0`;cd ../../ ## self-aligning
dir=`pwd` ## hard nail path
for i in `ls ${dir}/Week01/Data/*.fasta`;do ## id fa
	nam=`basename ${i}|cut -f 1 -d "f"` ## confirm filenames
	tail -n +2 ${i}|tr -d "\n" > ${dir}/Week02/Data/${nam}_py.csv ## extract useful info
done
exit
