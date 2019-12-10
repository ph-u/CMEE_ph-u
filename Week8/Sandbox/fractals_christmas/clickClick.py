#!/bin/env python3

## Author 		: internet sources
## Script 		: clickClick.py
## Input 		: none
## Output 		: mouse click to end screen record
## Arguments 	: 0
## Date 		: Dec 2019

"""mouse click on designated place"""

__appname__="clickClick.py"
__author__="internet"
__version__="0.0.1"
__license__="none"

## https://stackoverflow.com/questions/42530309/no-such-file-requirements-txt-error-while-installing-quartz-module
## https://discussions.apple.com/thread/5664353

import mouseClicks as m
import time

#time.sleep(60**2*1.8)
time.sleep(60**2)
#time.sleep(1**2*2)
#m.mouseclick(765,10) ## when vpn < 10 hrs
m.mouseclick(740,10) ## when vpn >= 10 hrs
