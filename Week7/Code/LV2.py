#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: LV2.py
# Desc: Consumer-Resource cycle plotting
# Input: python3 LV2.py
# Output: 1. two graphical outputs in `results` subdirectory; 2. final numbers terminal output
# Arguments: 0
# Date: Nov 2019


"""Consumer-Resource cycle plotting"""

__appname__="LV2.py"
__author__="PMH"
__version__="0.0.1"
__license__="None"

import sys
import scipy as sc
import scipy.integrate as integrate
import matplotlib.pylab as p

def LV():
    """adaptation for cProfile"""
    ## sys argv imput
    if len(sys.argv) < 4:
        print("not enough inputs, using defaults")
        print("r=1  a=0.1  z=1.5  e=0.75")
        r=1.;a=.1;z=1.5;e=.75
    else:
        r=float(sys.argv[1]) ## intrinsic (per-capita) growth rate
        a=float(sys.argv[2]) ## per-capita "search-rate" for resource
        z=float(sys.argv[3]) ## mortality rate
        e=float(sys.argv[4]) ## consumer's efficiency for resource -> biomass

    ## function
    def dCR_dt(pops, t=0):
        """Lotka-Volterra model"""
        R=pops[0]
        C=pops[1]
        dRdt=r*R*(1-R/K)-a*R*C
        dCdt=-z*C+e*a*R*C
        ## dimension analysis required (unit balance)
        ## automatically determine min time steps needed
        return sc.array([dRdt, dCdt])

    ## set initial start parameters
    t=sc.linspace(0,15,1e3)
    K=37 ## carrying capacity
    R0=10;C0=5 ## initial population of resource & consumers
    RC0=sc.array([R0,C0])
    pops, infodict=integrate.odeint(dCR_dt, RC0, t, full_output=True);pops

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

    p.text(9,12,tex,bbox=box) ## <https://matplotlib.org/3.1.1/gallery/recipes/placing_text_boxes.html>
    # p.show()

    f2=p.figure(num=2);f2
    p.plot(pops[:,0],pops[:,1],'r-')
    p.grid()
    p.xlabel("Resource density")
    p.ylabel("Consumer density")
    p.title("Consumer-Resource population dynamics")
    # p.show()

    f1.savefig("../results/LV2_model1.pdf")
    f2.savefig("../results/LV2_model2.pdf")

    ## print final values
    print("final Consumer population:",round(pops[(pops.shape[0]-1),1], 2), "individuals / units at time",t[len(t)-1])
    print("final Resource population:",round(pops[(pops.shape[0]-1),0], 2), "individuals / units at time",t[len(t)-1])

LV()
