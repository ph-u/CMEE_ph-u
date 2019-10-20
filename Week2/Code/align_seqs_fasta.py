#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: align_seqs_fasta.py
# Desc: python homework -- genetic alignment program
# Input: python3 align_seqs_fasta.py <fasta_1> <fasta_2>
# Output: 1. python interpreter output -- alignment process; 2. output best alignment(s) and its/their score(s) to a `txt` file in `Data` subdirectory
# Arguments: 0 or 2
# Date: Oct 2019

"""python homework -- genetic alignment program"""

__appname__="align_seqs_fasta.py"
__author__="PMH"
__version__="0.0.1"
__license__="None"

## imports
import sys
from os import listdir
from os.path import isfile, join

## input
if len(sys.argv) ==1:
    ## list files in Week01/Data/ directory
    p="../../Week01/Data/"
    files=[f for f in listdir(p) if all([isfile(join(p,f)), f.startswith("4"), f.endswith(".fasta")])]

    ## cp commands from above
    for i in range(2):
        f=list(open(str(p+files[i]),"r"))
        del f[0]
        f=[i.strip() for i in f]
        if i < 1: seq2="".join(f)
        else: seq1="".join(f)
else:
    for i in range(1,2+1):
        f=list(open(str(sys.argv[i]),"r"))
        del f[0]
        f=[i.strip() for i in f]
        if i == 1: seq2="".join(f)
        else: seq1="".join(f)
del f
# f=open('../Data/seq.csv',"r")
# seq2=f.readline().strip()
# seq1=f.readline().strip()
# f.close()

# Two example sequences to match
# seq2 = "ATCGCCGGATTACGGG"
# seq1 = "CAATTCGGAT"

# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest

l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths

# A function that computes a score by returning the number of matches starting from arbitrary startpoint (chosen by user)

def calculate_score(s1, s2, l1, l2, startpoint):
    """calculate alignment score"""
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):

#	import ipdb; ipdb.set_trace() ## debug breakpoint added

        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    # print("." * startpoint + matched)           
    # print("." * startpoint + s2)
    # print(s1)
    # print(score) 

    return score

# Test the function with some example starting points:
# calculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1

print("Slave is writing your best results into report...")
f=open("../Data/result_f.txt","w")

for i in range(l1): # Note that you just take the last alignment with the highest score
    # import ipdb; ipdb.set_trace() ## debug breakpoint added
    z = calculate_score(s1, s2, l1, l2, i)
    # print("cal: pos ",i," with score ",z)
    if i%10000 == 0:
        print("Slave passed: pos",round(i/1000),"Kbp for seq lengths approx.",round(len(s1)/1000),"&",round(len(s2)/1000),"Kbp respectively")

    if z == my_best_score:
        my_best_align = "." * i + s2 # think about what this is doing!
        my_best_score = z 


        f.write(my_best_align+"\n")
        f.write(s1+"\n")
        f.write("Best score:"+str(my_best_score)+"\n\n")
        # print(my_best_align)
        # print(s1)
        # print("Best score:", my_best_score)
        print("cal: pos ",i," with score ",z," (equal)")
    elif z > my_best_score:
        ## reset best output
        f.close()
        f=open("../Data/result_f.txt","w")

        my_best_align = "." * i + s2 # think about what this is doing!
        my_best_score = z 


        f.write(my_best_align+"\n")
        f.write(s1+"\n")
        f.write("Best score:"+str(my_best_score)+"\n\n")
        print("cal: pos ",i," with score ",z)
        # print(my_best_align)
        # print(s1)
        # print("Best score:", my_best_score)

f.close()
print("Slave finishes its report")