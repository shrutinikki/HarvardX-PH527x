# -*- coding: utf-8 -*-
"""
Created on Fri Jun 19 2020

@file: psctrds_section4_section5_cleandata_06142020.py
@author: Shruti
"""
#loading libraries

import pandas as pd
#import numpy as np

#reading the csv file
task2 = pd.read_csv("C:/Users/HP/Documents/Courses/edx/Principles, Statistical and Computational Tools for Reproducible Data Science/Section 4/Section 5/Data/Data_Assessment_5.3.1_06192020.csv")

task2

task2.columns
task2.reset_index(level=0, inplace=True)
task2.drop(columns='Name', inplace = True)
#column name change
task2.columns=['ID', 'Year', 'Sex', 'State', 'Weight', 'Height', 'Heart rate']


#changing the variable values to a more standard formart

task2.replace({'Sex':{'Female':1,'Male':0}},inplace=True)
task2['Year'] = pd.DatetimeIndex(task2['Year']).year

task2['State']=task2['State'].apply(lambda x: x.split()[1])



#writing the clean data
task2.to_csv("C:/Users/HP/Documents/Courses/edx/Principles, Statistical and Computational Tools for Reproducible Data Science/Section 4/Section 5/Data/Data_Assessment_5.3.1_06192020_Clean.csv")