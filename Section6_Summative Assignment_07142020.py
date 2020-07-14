# -*- coding: utf-8 -*-
"""
Created on Tue Jul 14 18:38:02 2020

File: Section6_Summative Assignment_07142020

@author: Shruti Gupta
"""

import numpy as np


def unit_circle(length,angle):
    d= (length*length+angle*angle)**0.5  # notation for sqrt(.)
    x = length/d
    y = angle/d
    return x,y




Cir_length = np.random.normal(0,1)
Cir_angle = np.random.normal(0,1)


unitcircle=unit_circle(Cir_length,Cir_angle)
unitcircle