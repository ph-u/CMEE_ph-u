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

print("start import")
import networkx as nx ## network analysis
import scipy as sc ## calculation
import matplotlib.pyplot as p ## plot
import csv ## read input files
from matplotlib.lines import Line2D as L2D ## plot legend
print("finished import, start raw in")

## raw
links=list(csv.reader(open("../Data/QMEE_Net_Mat_edges.csv", newline="")))
l_0=links[0]
links.remove(links[0])
links=sc.matrix(links)
nodes=list(csv.reader(open("../Data/QMEE_Net_Mat_nodes.csv", newline="")))
print("finished raw in, start graphing")

## create graph object
G=nx.Graph()
n_0=[];n_2=[];l_3=[] ## can't link
for i in range(1,len(nodes)):
    if nodes[i][1] == "Hosting Partner": j='lime'
    elif nodes[i][1] == "University": j='blue'
    else: j='red' ## pyplot colour <https://matplotlib.org/3.1.0/gallery/color/named_colors.html>
    n_0.append(nodes[i][0]) ## node names
    n_2.append(j) ## node colour
    l_3.append(L2D([0], [0], color=j, label=nodes[i][1])) ## plot legend

n_1=[nodes[i][2] for i in range(1,(len(nodes)-1))] ## node weight
l_1=[];l_2=[] ## edges
for i in range((len(l_0)-1)):
    for j in range((i+1),len(l_0)):
        if int(links[j,i]) > 0:
            l_1.append((l_0[i],l_0[j]))
            l_2.append(int(links[j,i]))

G.add_nodes_from(n_0)
G.add_edges_from(tuple(l_1), weight=l_2)

G_1=nx.circular_layout(n_0)
print("finished graphing, start plotting")

## plotting
f1=p.figure()
nx.draw(G, G_1, node_color=n_2, edge_color='grey', with_labels=True, node_size=int(4e3))
## node_size=[int(n_1[i])*100 for i in range(len(n_1))]
## node colour <https://stackoverflow.com/questions/27030473/how-to-set-colors-for-nodes-in-networkx-python>
## named colours <https://matplotlib.org/3.1.0/gallery/color/named_colors.html>
f1.legend(handles=l_3, loc=10)
## main legend idea <https://matplotlib.org/3.1.0/gallery/text_labels_and_annotations/custom_legends.html>
## legend position <https://matplotlib.org/api/legend_api.html>
# p.show()
f1.savefig("../results/QMEENet_py.svg")
print("done")

exit