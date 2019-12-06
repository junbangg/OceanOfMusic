# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import pandas as pd
import matplotlib.pyplot as plt
import csv

x = []
y = []

df = pd.read_csv('data.csv')

plt.plot(df)
