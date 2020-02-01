#!/usr/bin/env python3

""" Exploring Functional Responses data set
"""

# Some imports to explore the datasets
import pandas as pd
import scipy as sc
import matplotlib.pylab as pl
import seaborn as sns
import numpy as np
import csv

#########################################################
### Initial data visualisation ###
#########################################################

# Import data into python 
data = pd.read_csv("../data/CRat.csv")

# Print number of columns loaded
print("Loaded {} columns.".format(len(data.columns.values)))

# Print column headings
print(data.columns.values)

##########################################################
### Data preparation ###
##########################################################

### Create new data frame with only columns of interest for initial plots
newdata = data[['ID','ResDensity','N_TraitValue']].copy()
print(newdata)

### Remove any IDs containing NA values
newdata2 = newdata.dropna()
print(newdata2)

### Remove any IDs with less than 5 data points
# Visualise number of counts for each ID
newdata2.groupby('ID').ID.count() 

# Set the threshold value for number of repeats
threshold = 5

# Group data points by ID number and store a count of instances
ValueCounts = newdata2['ID'].value_counts()

# Create variable to hold IDs that need to be removed from the table
toremove = ValueCounts[ValueCounts <= threshold].index

# Replace IDs to remove with "NaN"
newdata2.replace(toremove, np.nan, inplace=True)

# Visually check claue counts are now more than 5
newdata2['ID'].value_counts()

# Remove all rows with NA data
newdata_no_missing = newdata.dropna()

# Count number of NAs in the data set to be sure all have been removed
newdata_no_missing.isnull().sum()

### Save modified data to a .csv file
newdata_no_missing.to_csv('../data/FunResData.csv')