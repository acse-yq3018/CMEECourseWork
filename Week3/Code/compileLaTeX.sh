#!/bin/bash
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: CompileLaTeX.sh
# Desc: create a pdf file in LaTeX and clean the meaningless files produced
# Arguments: bash CompileLaTeX.sh FirstExample.tex
# Date: Oct 2018

# create the figure
Rscript TAutoCorr.R

## Create a pdf file`
pdflatex TAutoCorr.tex
mv TAutoCorr.pdf ../Result
evince ../Result/TAutoCorr.pdf 

## Cleanup
rm *.aux
rm *.log
rm *.blg
rm *.bbl
