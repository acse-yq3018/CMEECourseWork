#!/bin/bash
# Author: Yuxin Qin yq3018@imperial.ac.uk
# Script: run_MiniProject.sh
# Desc: run the workflow of miniproject
# Date: Oct 2018

Rscript CalculateData.R
Rscript Analysis.R

## Create a pdf file
pdflatex miniproject.tex
bibtex bib.bib
pdflatex miniproject.tex
mv miniproject.pdf ../Report

## Cleanup
rm *.aux
rm *.log
rm *.blg
rm *.bbl