#!/bin/bash

python3 Vectorize1.py [1]>V1py.txt
Rscript Vectorize1.R [1]>V1R.txt
python3 Vectorize2.py [1]>V2py.txt
Rscript Vectorize2.R [1]>V2R.txt

## capture output files
v1pyS=`head -n 2 V1py.txt|tail -n 1`
v1rrS=`head -n 2 V1R.txt|tail -n 1`
v1pyB=`tail -n 1 V1py.txt`
v1rrB=`tail -n 1 V1R.txt`

v2pyS=`head -n 2 V2py.txt|tail -n 1`
v2rrS=`head -n 2 V2R.txt|tail -n 1`
v2pyB=`tail -n 1 V2py.txt`
v2rrB=`tail -n 1 V2R.txt`
# v2pyS="0.000"
# v2pyB="0.000"

dv1s=`echo -e "${v1pyS}-${v1rrS}"|bc`
dv1b=`echo -e "${v1pyB}-${v1rrB}"|bc`
dv2s=`echo -e "${v2pyS}-${v2rrS}"|bc`
dv2b=`echo -e "${v2pyB}-${v2rrB}"|bc`

dv1py=`echo -e "${v1pyS}-${v1pyB}"|bc`
dv1rr=`echo -e "${v1rrS}-${v1rrB}"|bc`
dv2py=`echo -e "${v2pyS}-${v2pyB}"|bc`
dv2rr=`echo -e "${v2rrS}-${v2rrB}"|bc`

echo
echo -e "        runtime for (sec) |\tpy\tR\t|py-R"
echo -e "-----------------------------------------------------"
echo -e "Vectorize1,     self-code |\t${v1pyS}\t${v1rrS}\t|${dv1s}"
echo -e "Vectorize1,      built-in |\t${v1pyB}\t${v1rrB}\t|${dv1b}"
echo -e "Vectorize2,      modified |\t${v2pyS}\t${v2rrS}\t|${dv2s}"
echo -e "Vectorize2,       initial |\t${v2pyB}\t${v2rrB}\t|${dv2b}"
echo -e "-----   ----   -----   ---------   ------   ---   ---"
echo -e "Vectorize1,  self-BuiltIn |\t${dv1py}\t${dv1rr}\t|"
echo -e "Vectorize2,   mod-initial |\t${dv2py}\t${dv2rr}\t|"
echo

rm V*.txt