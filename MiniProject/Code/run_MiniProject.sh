#!/bin/bash
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: run_MiniProject.sh
# Desc: run the workflow of miniproject
# Date: Feb 2019

Rscript CalculateData.R
Rscript ComBiomass.R
Rscript Analysis.R
python3 anova.py
Rscript anovafigure.R

## Create a pdf file
pdflatex miniproject.tex
bibtex minbib.bib
pdflatex miniproject.tex
pdflatex miniproject.tex
mv miniproject.pdf ../Report

## Cleanup
rm *.aux
rm *.log
rm *.blg
rm *.bbl