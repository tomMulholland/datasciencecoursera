Human Activity Recognition Using Smartphones
========================================================

This project organizes data from the University of California - Irvine's Machine Learning Repository

Data comes from 30 users carrying a Samsung Galazy S II smartphone

Accelerometer measurements were taken, and each of six activities were labeled. More information is available at <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>
Data is available (as of 11 May 2014) at <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

The script "run_analysis.R" aggregates the test and training data, then takes only the columns that mention the mean() or standard deviation std(). Those columns are then averaged according to each subject and activity. The final table is output to "subject_activity_means.txt"

