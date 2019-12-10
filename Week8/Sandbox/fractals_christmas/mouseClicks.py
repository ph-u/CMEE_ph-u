#!/bin/env python3

## Author 		: internet sources
## Script 		: mouseClicks.py
## Input 		: none
## Output 		: functions defined for screen click
## Arguments 	: 0
## Date 		: Dec 2019

"""functions defined for screen click"""

__appname__="mouseClicks.py"
__author__="internet"
__version__="0.0.1"
__license__="none"

## https://stackoverflow.com/questions/42530309/no-such-file-requirements-txt-error-while-installing-quartz-module
## https://discussions.apple.com/thread/5664353

import sys
from Quartz.CoreGraphics import *

def mouseEvent(type, posx, posy):
		theEvent = CGEventCreateMouseEvent(None, type, (posx, posy), kCGMouseButtonLeft)
		CGEventPost(kCGHIDEventTap, theEvent)

def mousemove(posx, posy):
		mouseEvent(kCGEventMouseMoved, posx, posy);

def mouseclick(posx, posy):
		mouseEvent(kCGEventLeftMouseDown, posx, posy);
		mouseEvent(kCGEventLeftMouseUp, posx, posy);

ourEvent = CGEventCreate(None);

