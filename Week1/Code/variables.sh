#!/bin/bash

# Author: ph-u
# Script: variables.sh
# Desc: test out interactive variables usage
# Input: ./variables.sh
# Output: terminal outputs in interactive mode
# Arguments: interactive
# Date: Oct 2019

# Shows the use of variables
MyVar="some string"
echo "the current value of the variable is" $MyVar
echo "Please enter a new string"
read MyVar
echo "the current value of the variable is" $MyVar

## Reading multiple values
echo "Enter two numbers separated by space(s)"
read a b
a=${a:-0}
b=${b:-0}
mysum=`expr $a + $b`
echo "you entered $a" and "$b".  "Their sum is:" $mysum
