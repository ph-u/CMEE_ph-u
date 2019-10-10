#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: align_seqs_fasta.py
# Desc: python homework -- genetic alignment module program
# Input: python3 align_seqs_fasta.py <seq_1.fa> <seq_2.fa>
# Output: 1. python interpretor output -- all alignment possibilities, raw sequences and best alignment score; 2. output best alignments and its/their score(s) to a txt file in `Data` subdirectory
# Arguments: 0 or 2
# Date: Oct 2019

"""
python homework -- genetic alignment module program
"""

__appname__="align_seqs_fasta.py"
__author__="PMH"
__version__="0.0.1"
__license__="None"

## imports
import sys
import os

## functions ##
def main(argv):
	"""Main entry point of the program"""
	dir=os.path.dirname(os.path.realpath(__file__))
	os.chdir(dir)
	f=open(../../Week01/Data)
	return 0

if __name__ == "__main__":
	"""Makes sure the 'main' function is called from command Line"""
	status=main(sys.argv)
	sys.exit()
