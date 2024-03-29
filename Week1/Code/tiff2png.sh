#!/bin/bash
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: tiff2png.sh
# Desc: transfer a tiff picture to jpg picture
# Arguments: bash tiff2png.sh ../Sandbox/TiffSample.tiff
# Date: Oct 2018

for f in $1; 
    do  
        echo "Converting $f"; 
        convert "$f"  "../Result/$(basename "$f" .tiff).jpg";
    done
