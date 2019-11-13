#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: Nets.py
# Desc: plot university network linkages
# Input: python3 Nets.py
# Output: one graphical output in `results` subdirectory
# Arguments: 0
# Date: Nov 2019


"""plot university network linkages"""

__appname__="Nets.py"
__author__="PMH"
__version__="0.0.1"
__license__="None"

import networkx as nx ## network analysis
import scipy as sc ## calculation
import matplotlib.pyplot as p ## plot
import csv ## read input files

## raw
links=list(csv.reader(open("../Data/QMEE_Net_Mat_edges.csv", newline="")))
links.remove(links[0])
links=sc.matrix(links)
nodes=list(csv.reader(open("../Data/QMEE_Net_Mat_nodes.csv", newline="")))

## network edges
l_0=nx.convert_matrix.from_numpy_matrix(links)

## create graph object
G=nx.Graph()
n_0=[nodes[i][0] for i in range(1,(len(nodes)-1))]
G.add_nodes_from(n_0)
G.add_weighted_edges_from(tuple(links))
