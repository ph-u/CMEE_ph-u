#!/bin/env python3

# Author: PokMan Ho pok.ho19@imperial.ac.uk
# Script: using_os.py
# Desc: trial on python3 os package
# Input: python3 using_os.py
# Output: terminal output
# Arguments: 0
# Date: Nov 2019


"""trial on python3 subprocess package"""

__appname__="using_os.py"
__author__="PMH"
__version__="0.0.1"
__license__="None"

# Use the subprocess.os module to get a list of files and  directories 
# in your ubuntu home directory 

# Hint: look in subprocess.os and/or subprocess.os.path and/or 
# subprocess.os.walk for helpful functions

import subprocess
import re

#################################
#~Get a list of files and 
#~directories in your home/ that start with an uppercase 'C'

# Type your code here:
p=subprocess.Popen(["ls"], stdout=subprocess.PIPE)
stdout, stderr = p.communicate()
print(stdout.decode())

# Get the user's home directory.
home = subprocess.os.path.expanduser("~")
subprocess.os.chdir(home)

# Create a list to store the results.
p=subprocess.Popen(["ls"], stdout=subprocess.PIPE)
stdout, stderr = p.communicate()
p=stdout.decode()
f_1=re.findall(r'\sC.+|\sC', p)
FilesDirsStartingWithC=[re.sub(r'\s+',"",f_1[i]) for i in range(len(f_1))]
print(FilesDirsStartingWithC)

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(home):
	print(subprocess.os.path.join(str(dir), str(subdir), str(files)))
  
#################################
# Get files and directories in your home/ that start with either an upper or lower case 'C'

# Type your code here:
p=subprocess.Popen(["ls"], stdout=subprocess.PIPE)
stdout, stderr = p.communicate()
p=stdout.decode()
f_1=re.findall(r'\s[Cc].+|\s[Cc]', p)
f_0=[re.sub(r'\s+',"",f_1[i]) for i in range(len(f_1))]
print(f_0)

#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:
p=subprocess.Popen(["ls"], stdout=subprocess.PIPE)
stdout, stderr = p.communicate()
p=stdout.decode()
f_1=re.findall(r'\s[Cc]\w+\s|\s[Cc]\s', p)
f_0=[re.sub(r'\s+',"",f_1[i]) for i in range(len(f_1))]
print(f_0)
