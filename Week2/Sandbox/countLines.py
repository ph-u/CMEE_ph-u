#!/bin/env python3

import sys

def file_len(fname):
    with open(fname) as r:
        for i,l in enumerate(r):
            pass
    return i+1

print(file_len(sys.argv[1]))