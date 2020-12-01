#!/bin/bash

# Author: ph-u
# Script: CountLines.sh
# Desc: print "Hello (username)" in two variable-coding methods
# Input: ./MyExampleScript.sh
# Output: two-lined duplicated "Hello" messages under two coding methods
# Arguments: 0
# Date: Oct 2019

msg1="Hello"
msg2=$USER
echo "$msg1 $msg2"
echo "Hello $USER"
echo
