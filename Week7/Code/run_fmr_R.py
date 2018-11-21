#!/usr/bin/env python3

"""use python to run fmr.R"""

__appname__ = 'run_fmr_R.py'
__author__ = 'Yuxin Qin (yq3018@imperial.ac.uk)'
__version__ = '0.0.1'

import subprocess

fmr = subprocess.Popen("/usr/lib/R/bin/Rscript --verbose fmr.R > ../Result/fmr.Rout 2> ../Result/fmr_errFile.Rout", shell = True).wait()

if fmr == 0:
    subprocess.os.system("cat ../Result/fmr.Rout")
    print("\nfmr succeeded")

if fmr != 0:
    subprocess.os.system("cat ../Result/fmr_errFile.Rout")
    print("\nfmr failed")