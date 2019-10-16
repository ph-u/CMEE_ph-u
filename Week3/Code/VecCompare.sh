#!/bin/bash

python3 Vectorize1.py [1]>V1py.txt
Rscript Vectorize1.R [1]>V1R.txt
# python3 Vectorize2.py [1]>V2py.txt
Rscript Vectorize2.R [1]>V2R.txt

## capture output files
v1pyS=`head -n 2 V1py.txt|tail -n 1`
v1rrS=`head -n 2 V1R.txt|tail -n 1`
v1pyB=`tail -n 1 V1py.txt`
v1rrB=`tail -n 1 V1R.txt`

# v2pyS=`head -n 2 V2py.txt|tail -n 1`
v2rrS=`head -n 2 V2R.txt|tail -n 1`
# v2pyB=`tail -n 1 V2py.txt`
v2rrB=`tail -n 1 V2R.txt`
v2pyS="0.000"
v2pyB="0.000"

dv1s=`echo -e "${v1pyS}-${v1rrS}"|bc`
dv1b=`echo -e "${v1pyB}-${v1rrB}"|bc`
dv2s=`echo -e "${v2pyS}-${v2rrS}"|bc`
dv2b=`echo -e "${v2pyB}-${v2rrB}"|bc`

echo
echo -e "    runtime for (sec) |\tpy\tR\tpy-R"
echo -e "----------------------------------------------"
echo -e "Vectorize1, self-code |\t${v1pyS}\t${v1rrS}\t${dv1s}"
echo -e "Vectorize1,  built-in |\t${v1pyB}\t${v1rrB}\t${dv1b}"
echo -e "Vectorize2, self-code |\t${v2pyS}\t${v2rrS}\t${dv2s}"
echo -e "Vectorize2,  built-in |\t${v2pyB}\t${v2rrB}\t${dv2b}"
echo

rm V*.txt