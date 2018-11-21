#!/usr/bin/env python3

""" test how to use python to run R """

__appname__ = 'TestR.py'
__author__ = 'Yuxin Qin (yq3018@imperial.ac.uk)'
__version__ = '0.0.1'


import subprocess
subprocess.Popen("/usr/lib/R/bin/Rscript --verbose TestR.R > \
../Result/TestR.Rout 2> ../Result/TestR_errFile.Rout",\
 shell=True).wait()