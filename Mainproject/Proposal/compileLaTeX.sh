#!/bin/bash
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: CompileLaTeX.sh
# Desc: create a pdf file in LaTeX and clean the meaningless files produced
# Arguments: bash CompileLaTeX.sh FirstExample.tex
# Date: Oct 2018

## Create a pdf file
pdflatex Proposal.tex
bibtex Proposal
pdflatex Proposal.tex
pdflatex Proposal.tex
evince Proposal.pdf 

## Cleanup
rm *.aux
rm *.log
rm *.blg
rm *.bbl
rm *.bCF
