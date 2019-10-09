#!/bin/env python3

"""Some functions exemplifying the use of control statements"""
## docstrings are considered part of the running code (normal comments are stripped).  Hence, you can access your docstrings at runtime.
__author__="Samraat Pawar (s.pawar@imperial.ac.uk)"
__version__="0.0.1"

import sys

def even_or_odd(x=0): ## if not specified, x should take value 0
	"""Find whether a number x is even or odd"""
	if x%2==0: ## the conditional if
		return "%d is even!" %x
	return "%d is odd!" %x

def largest_divisor_five(x=120):
	"""Find which is the largest divisor of x among 2,3,4,5"""
	largest = 0
	if x%5==0:
		largest = 5
	elif x%4==0:
		largest = 4
	elif x%3==0:
		largest = 3
	elif x%2==0:
		largest = 2
	else: ## when all other (if, elif) conditions are not met
		return "no divisor found for %d" %x ## each function can return a value or a variable
	return "The largest divisor of %d is %d" %(x, largest)

def is_prime(x=70):
	"""Find whether an integer is prime"""
	for i in range(2,x): ## "range" returns a seq of int
		if x%i==0:
			print("%d is not a prime: %d is a divisor" %(x, i))
			return False
	print("%d is a prime" % x)
	return True

def find_all_primes(x=22):
	"""Find all the primes up to x"""
	allprimes = []
	for i in range(2, x+1):
		if is_prime(i):
			allprimes.append(i)
	print("There are %d primes between 2 and %d"%(len(allprimes),x))
	return allprimes

def main(argv):
	print(even_or_odd(22))
	print(even_or_odd(33))
	print(largest_divisor_five(120))
	print(largest_divisor_five(121))
	print(is_prime(60))
	print(is_prime(59))
	print(find_all_primes(100))
	return 0

if(__name__=="__main__"):
	status=main(sys.argv)
	sys.exit(status)
