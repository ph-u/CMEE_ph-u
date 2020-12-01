#!/bin/env python3

# Author: ph-u
# Script: regexs.py
# Desc: regular expression classwork
# Input: python3 regexs.py
# Output: terminal output
# Arguments: 0
# Date: Nov 2019


"""regular expression classwork"""

__appname__="regexs.py"
__author__="ph-u"
__version__="0.0.1"
__license__="None"

import re

match = re.search(r'2', "it takes 2 to tango");match.group()
match = re.search(r'\d', "it takes 2 to tango");match.group()
match = re.search(r'\d.*', "it takes 2 to tango");match.group()
match = re.search(r'\s\w{1,3}\s', "once upon a time");match.group()
match = re.search(r'\s\w*$', "once upon a time");match.group()
re.search(r'\w*\s\d.*\d', 'take 2 grams of H2O').group()
re.search(r'^\w*.*\s', 'once upon a time').group()
re.search(r'<.+>', 'This is a <EM>first</EM> test').group()
re.search(r'<.+?>', 'This is a <EM>first</EM> test').group()
re.search(r'\d*.?\d*', '1432.75+60.22i').group()
re.search(r'[ATGC]+', 'the sequence ATTCGT').group()
re.search(r'\s+[A-Z]\w+\s*\w+', "The bird-shit frog's name is Theloderma asper.").group()

MyStr='Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecology theory'
match=re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s]+",MyStr)
match.group()

MyStr='Samraat Pawar, s-pawar@imperial.ac.uk, Systems biology and ecology theory'
re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s]+",MyStr).group()

MyStr='Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecology theory'
match=re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s]+",MyStr)
match.group()
match.group(0)

match=re.search(r"([\w\s]+),\s([\w\.-]+@[\w\.-]+),\s([\w\s&]+)", MyStr)
if match:
    print(match.group(0))
    print(match.group(1))
    print(match.group(2))
    print(match.group(3))

MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory; Another academic, a-academic@imperial.ac.uk, Some other stuff thats equally boring; Yet another academic, y.a_academic@imperial.ac.uk, Some other stuff thats even more boring"
emails = re.findall(r'[\w \. -]+@[\w\.-]+', MyStr)
for email in emails:
    print(email)
found_matches = re.findall(r"([\w \s]+), ([\w \. -]+@[\w \. -]+)", MyStr) ## regex space character: either \s or " "
found_matches

f = open("../Data/TestOaksData.csv", 'r')
found_oaks = re.findall(r"Q[\w\s].*\s", f.read())
found_oaks

import urllib3
import scipy as sc

conn = urllib3.PoolManager() ## open a connection
r = conn.request("Get", "https://www.imperial.ac.uk/silwood-park/academic-staff/")
webpage_html = r.data ## read in web contents
type(webpage_html)
My_Data = webpage_html.decode()
pattern = r"Dr[\s \']+\w+[\s \']+\w+|Prof[\s \']+\w+[\s \']+\w+"
regex=re.compile(pattern) ## example use of re.compile(); can also ignore case with re.IGNORECASE
mm=[]
for match in regex.finditer(My_Data):
    mm.append(match.group())

mm=sc.unique(mm)
mm.sort()
for i in range(len(mm)):
    print(mm[i])

