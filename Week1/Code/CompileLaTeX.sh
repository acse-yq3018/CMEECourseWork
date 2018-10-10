#!/bin/bash
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: CompileLaTeX.sh
# Desc: create a pdf file in LaTeX and clean the meaningless files produced
# Arguments: bash CompileLaTeX.sh FirstExample.tex
# Date: Oct 2018

## Create a pdf file
basename=`basename $1 .tex`
pdflatex $1
bibtex $basename
pdflatex $1
mv ${basename}.pdf ../Result
evince ../Result/${basename}.pdf 

## Cleanup
rm *.aux
rm *.log
rm *.blg
rm *.bbl