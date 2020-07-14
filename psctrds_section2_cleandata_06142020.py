# -*- coding: utf-8 -*-
"""
Created on Sun Jun 14 15:02:14 2020

@file: psctrds_section2_cleandata_06142020.py
@author: Shruti
"""
#loading libraries

import pandas as pd
#import numpy as np

#reading the csv file
task2 = pd.read_csv("C:/Users/HP/Documents/Courses/edx/Principles, Statistical and Computational Tools for Reproducible Data Science/Section 2/Data/asset-v1_HarvardX+PH527x+1T2019+type@asset+block@2.4.7_data.csv")

task2

task2.columns

#drop column
task2.loc[task2['Patient gender']=='?']=task2.drop([6],inplace = True)
task2.loc[task2['Age of patient']=='?']=task2.drop([2],inplace = True)
task2.loc[task2['Height'].isnull()]=task2.drop([7],inplace = True)

#column name change
task2.columns=['Patient ID','Age','Gender','Height','Tumor Stage','Date enrolled','Complication']



#changing the variable values to a more standard formart

task2.replace({'Gender':{'f':1,'female':1,'m':0,'male':0,'Male':0,'M':0}},inplace=True)
task2.replace({'Complication':{'N':1,'No':1,'n':1,'no':1,'Y':0,'y':0,'Yes':0}},inplace=True)
task2.replace({'Tumor Stage':{'IV':4,'III':3,'II':2}},inplace=True)


#treatment column
task2['Treatment'] = ['Treatment B' if x =='Music' else 'Treatment A' for x in task2['Patient ID']]
task2.loc[task2['Patient ID'].isnull()]=task2.drop([3],inplace = True)

#writing the clean data
task2.to_csv("C:/Users/HP/Documents/Courses/edx/Principles, Statistical and Computational Tools for Reproducible Data Science/Section 2/Data/asset-v1_HarvardX+PH527x+1T2019+type@asset+block@2.4.7_data_Clean.csv")