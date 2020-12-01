#!/bin/env python3

# Author: ph-u
# Script: DrawFW.py
# Desc: network analysis in python3
# Input: python3 DrawFW.py
# Output: network graph in `results` subdirectory
# Arguments: 0
# Date: Nov 2019


"""network analysis in python3"""

__appname__="DrawFW.py"
__author__="ph-u"
__version__="0.0.1"
__license__="None"

import networkx as nx
import scipy as sc
import matplotlib.pyplot as p

## adjacency list + node list -> network
## adjacency list: consumer & resource interaction coupling, can be repeated
## node list: id & property of node, multiple property of nodes

def GenRdmAdjList(N = 2, C = .5):
    """synthetic food web, avoid cannibalis"""
    ## .1-.4 normal connectence probability (10-40% chance selecting two directly-interactinve spp)
    Ids = range(N)
    Alst = []
    for i in Ids:
        if sc.random.uniform(0,1,1) < C: ## coin-flipping, uniform distribution
            Lnk = sc.random.choice(Ids,2).tolist()
            if Lnk[0] != Lnk[1]: ## avoid cannibalis
                Alst.append(Lnk)
    return Alst

## Real C = L/(N*(N-1)) ## avoid cannibalis
## Real C = L/N^2 ## allow cannibalis
## L = potential number of links in a network
## N = size of network / number of nodes

MaxN = 30 ## max number of players
C = .75 ## probability of establishing a link

AdjL = sc.array(GenRdmAdjList(MaxN, C)) ## construct adjacent list
Sps = sc.unique(AdjL) ## get species ids 
SizRan = ([-10,10]) ## use log10 scale
Sizs = sc.random.uniform(SizRan[0], SizRan[1], MaxN)

# p.hist(Sizs) ## log10 scale
# p.hist(10 ** Sizs) ## raw scale
# p.close() ## close all open plot objects

pos=nx.circular_layout(Sps)
G = nx.Graph()
G.add_nodes_from(Sps)
G.add_edges_from(tuple(AdjL))
NodSizs=int(1e3)*(Sizs-min(Sizs))/(max(Sizs)-min(Sizs))

f1=p.figure()
nx.draw_networkx(G, pos, node_size = NodSizs)
f1.savefig("../results/DrawFW_py.pdf")
