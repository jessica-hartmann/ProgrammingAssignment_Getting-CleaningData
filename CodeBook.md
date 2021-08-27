---
title: "Codebook"
output:
  html_document:
    df_print: paged
  pdf_document: default
---

# Description 
This is the CodeBook for the tidy datasets `tidydata.txt` and `tidydata_means.txt` obtained by running `run_analysis.R`. It provides information on all variables and summaries calculated as well as other important information on the raw data files contained in the `UCI HAR Dataset`.  

This is the Getting and Cleaning Data Course Project. For more background information on the project as well as the data used, please see `README.md`. 

# The raw data in `UCI HAR Dataset`

The link to the Human Activity Recognition Using Smartphone Data Set  [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#), to directly download the data click [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).


## Input files 
The `UCI HAR Dataset` provides the following files: 

### Main directory 
- `features.txt` contains 561 feature vector variable names. Of these, there are 66 variables containing the mean and standard deviation of the measurement, which are relevant for building the tidy dataset and listed below. For more information on feature selection, see the `README.md`.

  + `1 tBodyAcc-mean()-X`
  + `2 tBodyAcc-mean()-Y`
  + `...`
  + `543 fBodyBodyGyroJerkMag-std()`
  + `...`
  

- `activity_labels.txt` contains the labels and names of the activities performed by the participants. 

Index  | Label
------ | -------------------
1      | WALKING
2      | WALKING_UPSTAIRS
3      | WALKING_DOWNSTAIRS
4      | SITTING
5      | STANDING
6      | LAYING


### Subdirectories `test` and `training`
- `subject_test.txt` and `subject_train.txt` contain an index ranging from *1 to 30* corresponding to the participants performing the activities in this experiment

- `y_test.txt` and `y_train.txt` contain an integer ranging from *1 to 6* corresponding to the activity performed, manually scored 

- `X_test.txt` and `X_train.txt` contain the accelerometer and gyroscope 3-axial signals (for all features described above) for the activities performed during the experiment

- the diectory `Intertial Signals` contains the very raw data 


## Processing the data with `run_analysis.R`

### The assignment asks for the following to achieve in `run_analysis.R`: 
1. Merges the training and the test sets to create one data set  
2. Extracts only the measurements on the mean and standard deviation for each measurement   
3. Uses descriptive activity names to name the activities in the data set  
4. Appropriately labels the data set with descriptive variable names  
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

### Proposed solution sub-steps 

The following packages are required: `data.table()`, `dplyr()`, `sjlabelled()`

### 1. Merge the training and the test sets to create one dataset
- the user-defined function `assemble_df` assembles and **labels** the datasets with the following substeps: (a) put file names with pattern '.txt' to read in in a list (this includes y, X, and subjects); (b) read in all elements of list using `read.table()` and store in `data`; (c) combine the resulting big list of 3 into a big dataframe with `cbind()`; (d) read in descriptive feature variable names in 'feature' (this step is requested in step 5, please see below); (e) store descriptive variable names for subjects, features and activities in `names`; (f) name the column of the big dataset with descriptive variable names; (g) store in temporary dataframe `df_temp` 
- store the names of the datasets in vector `d`  
- apply `assemble_df()` function to the elements of `d` (i.e. apply the assembly function to both train and test datasets)  
- concatenate the list of dataframes into single, big dataframe including id (`.id`) for data source (i.e. if data originate from train or test dataset)

### 2. Extract only the measurements on the mean and standard deviation for each measurement
- using `dplyr()` package, select the relevant columns that contain mean() or std(), as well as the other relevant variables: subject id, data source (train vs test), and performed activities  
- rename the `.id` column which indicated data source to a more descriptive name `data_source`  
- label values for `data_source` either "TRAIN" or "TEST"  


### 3. Use descriptive activity names to name the activities in the data set
- read in the activity names `activity_labels.txt` from file and call them `activities`
- use the `factor()` function to create our own value labels stored in `activities`  
- store the dataset as `tidydata.txt`  

### 4. Appropriately label the dataset with descriptive variable names
- Please note that this has been done in the function `assemble_df` (step 1 (d)): we assign the descriptive variable names given in `features.txt` to the vector `names` and then use `colnames()` to assign descriptive names to the variables. (We also assign subject id the name `subj_id` and the performed activities the name (`activities`))  
- Please note this has also been done in step 2, where the `.id` column for data source is renamed to `data_source` and labelled with "TRAIN" and "TEST"

### 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject
- We group the data by subject id, data source (ie train vs test) and performed activities using `group_by()` from the `dplyr` package and then   
- summarise the feature variables using the mean  
- this independent, summarised tidy dataset is stored in `tidydata_mean.txt` 

## Output files 

- `tidydata.txt` contains the tidy data for **both the training and test datasets** of the UCI HAR Dataset after processing with `run_analysis.R`. It contains the following variables:  
  - `data_source` is a factor variable with two levels, (1) TRAIN and (2) TEST, indicating whether the data originate from train or test dataset  
  - `subj_id` is an integer variable ranging from 1 to 30 corresponding to the participant id volunteering in the experiment  
  - `activities` is a factor variable with 6 levels, indicating the performed activities by the participants. The six activities are: (1) WALKING, (2) WALKING_UPSTAIRS, (3) WALKING_DOWNSTAIRS, (4) SITTING,       (5) STANDING, (6) LAYING. These indexes originate from the supplied `activity_labels.txt`. 
  - `tBodyAcc-mean()-X` to `tBodyGyroJerk-std()-Y` contain all measurements from `X_test.txt` and `X_train.txt`  
  
  
### Head of `tidydata.txt` 

 
data_source | subj_id| activities | tBodyAcc-mean()-X | ... | 
------------| -------| -----------| ----------------- | --- | 
TRAIN       | 1      | STANDING   | 0.2885845         | ... |                      
TRAIN       | 1      | STANDING   | 0.2784188         | ... |                     
TRAIN       | 1      | STANDING   | 0.2784188         | ... |                      
TRAIN       | 1      | STANDING   | 0.2791739         | ... |                        
TRAIN       | 1      | STANDING   | 0.2766288         | ... |                       
TRAIN       | 1      | STANDING   | 0.2771988         | ... |       


- `tidydata_means.txt` is a tidy summarised dataset which contains the means of the measures from `tidydata.txt` per data source, participant id and performed activity 


### Head of `tidydata_mean.txt` 

data_source| subj_id | activities   | tBodyAcc-mean()-X | ... |
-----------| --------| -----------  | ----------------- | --- | 
TRAIN      | 1       | WALKING      | 0.277             | ... |                       
TRAIN      | 1       | WALKING_UPS..| 0.255             | ... |                      
TRAIN      | 1       | WALKING_DOW..| 0.289             | ... |                    
TRAIN      | 1       | SITTING      | 0.261             | ... |                       
TRAIN      | 1       | STANDING     | 0.279             | ... |                       
TRAIN      | 1       | LAYING       | 0.222             | ... |    
 


