#!/usr/bin/env python3

"""ANOVA analysis"""

__appname__ = 'anova.py'
__author__ = 'Yuxin Qin (yq3018@imperial.ac.uk)'
__version__ = '0.0.1'

###########################################################################
import pandas as pd
from statsmodels.formula.api import ols
from statsmodels.stats.anova import anova_lm

data = pd.read_csv("../Data/CommunityData.csv")
data = data.rename(columns ={'community.biomass':'biomass'} ) 
model = ols('biomass ~ C(month)*C(treat)', data).fit()
anova = anova_lm(model, typ=2)
anova.to_csv('../Data/cbanova.csv', index=True, header=True)