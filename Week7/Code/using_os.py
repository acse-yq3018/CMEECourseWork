#!/usr/bin/env python3

"""use python to run subprocess"""

__appname__ = 'using_os.py'
__author__ = 'Yuxin Qin (yq3018@imperial.ac.uk)'
__version__ = '0.0.1'


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

# Get the user's home directory.
home = subprocess.os.path.expanduser("~")

# Create a list to store the results.
FilesDirsStartingWithC = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(home):
    for strings in subdir + files:
        FilesDirsStartingWithC += re.findall(r"C.*", strings)

print("Files and directories in your home/ that start with either an upper case 'C'")
print(FilesDirsStartingWithC)

#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'

# Type your code here:
FilesDirsStartingWithCc = []

for (dir, subdir, files) in subprocess.os.walk(home):
    for strings in subdir + files:
        FilesDirsStartingWithCc += re.findall(r"[Cc].*", strings)

print("Files and directories in your home/ that start with either an upper or lower case 'C'")
print(FilesDirsStartingWithCc)



#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:
DirsStartingWithCc = []

for (dir, subdir, files) in subprocess.os.walk(home):
    for d in subdir:
        DirsStartingWithCc += re.findall(r"[Cc].*", d)

print("Directories in your home/ that start with either an upper or lower case 'C'")
print(DirsStartingWithCc)


print("summary")

C = len(FilesDirsStartingWithC)
Cc = len(FilesDirsStartingWithCc)
DCc = len(DirsStartingWithCc)
print("The number of files and directories in your home/ that start with an uppercase 'C' is", C)
print("The number of files and directories in your home/ that start with an uppercase or lowercase 'C' is", Cc)
print("The number of directories in your home/ that start with an uppercase or lowercase 'C' is", DCc)