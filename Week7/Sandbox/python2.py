#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: python2.py
# Desc: scipy testing
# Input: python3 python2.py
# Output: none
# Arguments: 0
# Date: Nov 2019


"""scipy testing"""
import scipy as sc

a=sc.array(range(5));a
print(type(a))
print(type(a[0]))

a=sc.array(range(5), float);a
a.dtype

x=sc.arange(5);x
x=sc.arange(5.);x
x.shape
b=sc.array([i for i in range(10) if i%2==1]);b
c=b.tolist();c

mat=sc.array([[0,1],[2,3]]);mat
mat.shape
mat[1] ## 2nd row
mat[:,1] ## 2nd col
mat[0,0] ## 1st row, 1st element
mat[1,0] ## 2nd row, 1st element
mat[:,0] ## 1st col
mat[0,1]
mat[0,-1] ## wrap around, 1st row last col
mat[-1,0] ## wrap around, last row 1st col
mat[0,-2] ## wrap around, 1st row last 2nd col

## manipulating arrays
mat[0,0]=-1;mat ## replacing single element
mat[:,0]=[12,12];mat ## replace whole column
sc.append(mat,[[12,12]], axis=0) ## append row, note axis specification
sc.append(mat,[[12],[12]], axis=1) ## append col
newRow=[[12,12]] ## create new row
mat=sc.append(mat,newRow, axis=0);mat ## append that existing row
sc.delete(mat,2,0) ## del 3rd row
mat=sc.array([[0,1],[2,3]])
mat0=sc.array([[0,10],[-1,3]])
sc.concatenate((mat,mat0),axis=0)
mat.ravel() ## df -> array
mat.reshape((4,1)) ## num of row, col from ini df
mat.reshape((1,4)) ## =mat.ravel()
# mat.reshape((3,1)) ## total element must be the same

## pre-alocating arrays
sc.ones((4,2)) ## row, col of 1 float
sc.zeros((4,2)) ## row, col of 0 float
m=sc.identity(4);m ## identity matrix
m.fill(16);m ## fill matrix with float 16

## numpy matrix
mm=sc.arange(16)
mm=mm.reshape(4,4);mm ## convert to matrix
mm.transpose()
mm+mm.transpose()
mm-mm.transpose()
mm*mm.transpose()
mm//mm.transpose()
mm//(mm+1).transpose()
mm*sc.pi
mm.dot(mm) ## dot product
mm=sc.matrix(mm);mm ## convert to scipy matrix class
print(type(mm))
mm+mm

## sc.stats
import scipy.stats
scipy.stats.norm.rvs(size=10) ## 10 samples from N(0,1)
scipy.stats.randint.rvs(0,10,size=7) ## random int 0-10

## scipy numerical integration
import scipy.integrate as integrate
def dCR_dt(pops, t=0):
    R=pops[0]
    C=pops[1]
    dRdt=r*R-a*R*C
    dCdt=-z*C+e*a*R*C
    ## dimension analysis required (unit balance)
    ## automatically determine min time steps needed
    return sc.array([dRdt, dCdt])

type(dCR_dt)
r=1. ## (+1 ind per unit time) growth rate (num reproduced by num individuals per unit time)
a=.1 ## ability of consumers clearing space
z=1.5 ## num of individual loss per unit time
e=.75 ## no unit, kg/kg
t=sc.linspace(0,15,1e3) ## output 15 timesteps with 1e3 sub-timesteps

R0=10;C0=5;RC0=sc.array([R0,C0])
pops, infodict=integrate.odeint(dCR_dt, RC0, t, full_output=True);pops
type(infodict)
infodict.keys()
infodict['message']

## python plot
import matplotlib.pylab as p
f1=p.figure();f1
p.plot(t,pops[:,0], 'g-', label="Resource density") ## plot green line as 1st graphic entry
p.plot(t,pops[:,1], "b-", label="Consumer density")
p.grid()
p.legend(loc="best")
p.xlabel("Time");p.ylabel("Population density");p.title("Consumer-Resource population dynamics")
p.show()

f1.savefig("../results/LV_model.pdf")