#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: LV4.py
# Desc: Consumer-Resource cycle plotting, discrete-time model with gaussian/normal distribution
# Input: python3 LV4.py
# Output: 1. two graphical outputs in `results` subdirectory; 2. final numbers terminal output
# Arguments: 0
# Date: Nov 2019


"""Consumer-Resource cycle plotting, discrete-time model with gaussian/normal distribution"""

__appname__="LV4.py"
__author__="PMH"
__version__="0.0.1"
__license__="None"

import sys
import scipy as sc
import scipy.stats as stats
import matplotlib.pylab as p

## sys argv imput
if len(sys.argv) < 4:
    print("not enough inputs, using defaults")
    print("r=1.  a=0.1  z=1.5  e=0")
    r=1.;a=.1;z=1.5;e=0
else:
    r=float(sys.argv[1])
    a=float(sys.argv[2])
    z=float(sys.argv[3])
    e=float(sys.argv[4])

def LV():
    """adaptation for cProfile"""
    ## function
    def dCR_dt(pop, t):
        """Lotka-Volterra model, discrete time"""
        R=pop[0]
        C=pop[1]
        ep=float(stats.norm.rvs(size=1))
        R1=R*(1+(r+ep)*(1-R/K)-a*C)
        C1=C*(1-z+e*a*R)
        ## dimension analysis required (unit balance)
        ## automatically determine min time steps needed
        return sc.array([R1, C1])

    ## set initial start parameters
    t=sc.linspace(0,15,1e3)
    K=5 ## max 5
    pops=sc.zeros(((len(t)),2))
    pops[0,:]=[6,5]
    for i in range(1,len(t)):
        pops[i,:]=dCR_dt(pops[(i-1),:],t[i])
        if pops[i,0] > K:
            pops[i,0]=K
        elif pops[i,0] < 0:
            pops[i,0]=0
        if pops[i,1] > K:
            pops[i,1]=K
        elif pops[i,1] < 0:
            pops[i,1]=0

    f1=p.figure(num=1);f1
    p.plot(t,pops[:,0], 'g-', label="Resource density") ## plot green line as 1st graphic entry
    p.plot(t,pops[:,1], "b-", label="Consumer density")
    p.grid()
    p.legend(loc="best")
    p.xlabel("Time")
    p.ylabel("Population density")
    p.title("Consumer-Resource population dynamics")
    ## text string for text box in graph
    tex='\n'.join((
        r'$r = %.2f$ time$^{-1}$' %(r, ),
        r'$a = %.2f$ area * time$^{-1}$' %(a, ),
        r'$z = %.2f$ time$^{-1}$' %(z, ),
        r'$e = %.2f$ [no unit]' %(e, )
    ))
    box=dict(boxstyle="round", facecolor="white",alpha=.8)

    p.text(9,max(pops[:,0])*.1,tex,bbox=box) ## <https://matplotlib.org/3.1.1/gallery/recipes/placing_text_boxes.html>
    # p.show()

    f2=p.figure(num=2);f2
    p.plot(pops[:,0],pops[:,1],'r-')
    p.grid()
    p.xlabel("Resource density")
    p.ylabel("Consumer density")
    p.title("Consumer-Resource population dynamics")
    # p.show()

    f1.savefig("../results/LV4_model1.pdf")
    f2.savefig("../results/LV4_model2.pdf")

    ## print final values
    print("final Consumer population:",round(pops[(pops.shape[0]-1),1], 2), "individuals / units at time",t[len(t)-1])
    print("final Resource population:",round(pops[(pops.shape[0]-1),0], 2), "individuals / units at time",t[len(t)-1])

LV()
