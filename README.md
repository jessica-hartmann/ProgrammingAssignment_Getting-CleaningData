---
title: "ProgrammingAssignment_Getting-CleaningData"
output:
  html_document:
    df_print: paged
  pdf_document: default
---


# Short Project description 

This is the Getting and Cleaning Data Course Project. The purpose of this project is to show one's ability to collect, work with, and clean a data set. The dataset used in this project is 'Human Activity Recognition Using Smartphone Dataset Version 1.0', from Reyes-Ortiz et al., Smartlab - Non Linear Complex Systems Laboratory (experiment described below).
This README explains the contents of the ProgrammingAssignment_Getting-CleaningData repo and how the scripts work and how they are connected. 

# Contents of this repository 

- `run_analysis.R`: This is the R script executing the 5 steps outlined in the assignment, producing `tidydata.txt` and `tidydata_means.txt` from data files in `UCI HAR Dataset`. 
-  `UCI HAR Dataset`: This directory contains the raw **input** data files.   
- `tidydata.txt`: This is the cleaned up, tidy **output** data file (not summarised). It can be read into R using `read.table()`.  
- `tidydata_means.txt`: This is the independent, summarised tidy  **output** data file corresponding to step 5 in the assignment. It can be read into R using `read.table()`. 
- `CodeBook.md`: This is the expanded codebook, explaining every variable and summaries calculated, as well as their units and other important information.  
- `README.md`: This file explains how the analysis works and how the different elements of the repo are linked 

# What does `run_analysis.R` do? 

The R script `run_analysis.R` does the following tasks 

1. Merges the training and the test sets to create one data set  
2. Extracts only the measurements on the mean and standard deviation for each measurement   
3. Uses descriptive activity names to name the activities in the data set  
4. Appropriately labels the data set with descriptive variable names  
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

It produces the tidy data sets `tidydata.txt` (result of Step 1-4) and `tidydata_means.txt` (result of Step 5). More information on the solution proposed in `run_analysis.R` as well as information on variables and summaries calculated, along with units and other information, is presented in `Codebook.md`. 

# The UCI HAR Dataset: Background information
### The experiment 

>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

### The raw data 

The link to the Human Activity Recognition Using Smartphone Data Set is [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#), to directly download the data click [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

It consists of a test and a training dataset. 

### Attribute Information 
*- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration*  
*- Triaxial Angular velocity from the gyroscope*  
*- A 561-feature vector with time and frequency domain variables*   
*- Its activity label*  
*- An identifier of the subject who carried out the experiment* 
 
### Feature Selection
>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.*

>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

### The tidy data sets

The tidy data sets `tidydata.txt` and `tidydata_means.txt` are the output data sets after running the R script `run_analysis.R`. `tidydata.txt` consists of a tidy data set consisting of the merged training and test datasets with descriptive variable names and descriptive variable value labels.`tidydata_means.txt` is an independent tidy dataset consisting of only the **means** of the `tidydata.txt` dataset. Both tidy datasets can be read into R with `read.table()`. The variables and summaries calculated, along with units, and any other information, is contained in `codebook.md`.

# Licence 

>Use of the dataset in this project for publications must be acknowledged by referencing the following publication: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

