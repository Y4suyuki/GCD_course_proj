# Code Book
The original data source:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Data Process
from the original data I made result.txt by following process

1. merge training and test data set
2. Extract only measurement on the mean and std
3. Label the data set with appropriate name
4. Subset data by taking means for each Activity and each Subject for all other variables

## Variables
1. Activity: activities name each subject performed
2. Subject: number from 1-30 represent each subject performed activity

Rest of variables are mean of each measured data for each Activity and Subject.
