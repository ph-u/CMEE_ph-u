#!/bin/env python3

def makeabug(x):
	y=x**4
	z=0.
	# import ipdb; ipdb.set_trace() ## set up break point in debug mode
	y=y/z
	return y
makeabug(25)
