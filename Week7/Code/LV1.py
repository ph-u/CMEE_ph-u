#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: LV1.py
# Desc: Consumer-Resource cycle plotting
# Input: python3 LV1.py
# Output: two graphical outputs
# Arguments: 0
# Date: Nov 2019


"""Consumer-Resource cycle plotting"""

__appname__="LV1.py"
__author__="PMH"
__version__="0.0.1"
__license__="None"

def LV():
    import scipy as sc
    import scipy.integrate as integrate
    import matplotlib.pylab as p

    ## function
    def dCR_dt(pops, t=0):
        """Lotka-Volterra model"""
        R=pops[0]
        C=pops[1]
        dRdt=r*R-a*R*C
        dCdt=-z*C+e*a*R*C
        ## dimension analysis required (unit balance)
        ## automatically determine min time steps needed
        return sc.array([dRdt, dCdt])

    ## set initial start parameters
    r=1.;a=.1;z=1.5;e=.75;t=sc.linspace(0,15,1e3)
    R0=10;C0=5;RC0=sc.array([R0,C0])
    pops, infodict=integrate.odeint(dCR_dt, RC0, t, full_output=True);pops

    f1=p.figure(num=1);f1
    p.plot(t,pops[:,0], 'g-', label="Resource density") ## plot green line as 1st graphic entry
    p.plot(t,pops[:,1], "b-", label="Consumer density")
    p.grid()
    p.legend(loc="best")
    p.xlabel("Time")
    p.ylabel("Population density")
    p.title("Consumer-Resource population dynamics")
    # p.show()

    f2=p.figure(num=2);f2
    p.plot(pops[:,0],pops[:,1],'r-')
    p.grid()
    p.xlabel("Resource density")
    p.ylabel("Consumer density")
    p.title("Consumer-Resource population dynamics")
    # p.show()

    f1.savefig("../results/LV1_model1.pdf")
    f2.savefig("../results/LV1_model2.pdf")

LV()