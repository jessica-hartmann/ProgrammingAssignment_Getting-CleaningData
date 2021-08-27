####################################
##### Getting & Cleaning Data ######
#####  Programming Assignment ######
####################################

#This script does the following: 

#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each 
#   measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.


################################################################################

#1. Merge the training and test data sets. 
## Please note that this step already incorporates parts of step 4 (Appropriately 
## labels the data set with descriptive variable names)

### read in the data 

library(data.table)

 
## write user function to assemble and label datasets;
    ## (1) put file names with pattern txt to read in in a list ; 
    ## (2) read in all elements of list using read.table() and store in 'data`;
    ## (3) combine big list of 3 into a big dataframe with cbind();
    ## (4) read in feature variable names in 'feature'; 
    ## (5) store descriptive variable names for subjects, features and activities; 
    ## (6) name the column of the big dataset with descriptive variable names; 
    ## (7) store in temporary dataframe

assemble_df <- function(x) {
          file_list <- list.files(path = x, 
                      full.names = TRUE, pattern = ".*txt") ##1 
          data <- lapply(file_list, FUN = read.table, quote="\"", comment.char="") ##2 
          df <-  do.call("cbind", data) ##3 
          features <- data.table::fread("../ProgrammingAssignment_Getting-CleaningData/UCI HAR Dataset/features.txt", 
                                         quote="\"", drop = "V1", col.names = "features") ##4
          names =   c("subj_id", features$features, "activities") ##5 
          colnames(df) =  names ##6
           
          df_temp <<- df ##7

}
  
## store the names of the datasets in d 
d <- c("../ProgrammingAssignment_Getting-CleaningData/UCI HAR Dataset/train", "../ProgrammingAssignment_Getting-CleaningData/UCI HAR Dataset/test")

## apply my assemble_df function to the elements of d (i.e. apply the assembly 
## function to both data sets )
data_as_list <- lapply(d, assemble_df)

## concatenate the list of dataframes into single, big dataframe including id for
## data source
tidydata <- rbindlist(data_as_list, idcol = TRUE)

## remove temporary data set 


###############################################################################

#2. Extracts only the measurements on the mean and standard deviation for each 
##  measurement.
 
## using `dplyr()` package, select the relevant columns that contain mean() or 
## std(), as well as the other relevant variables: subject id, data source, and
## performed activities 

library(dplyr)
library(sjlabelled)
tidydata <- tidydata %>% 
      select(contains (c(".id","subj_id", "activities","mean()", "std()"))) %>% 
      rename(data_source = .id)  ##rename .id to more descriptive name 'data source'
  
## label values for data source either "train" or "test" 

tidydata$data_source <- factor(tidydata$data_source, levels = c(1,2), 
                        labels = c("TRAIN", "TEST"))
  

###############################################################################

#3. Use descriptive activity names to name the activities in the data set              


## read in the activity names and call them "activities"
activities <- read.table("../ProgrammingAssignment_Getting-CleaningData/UCI HAR Dataset/activity_labels.txt", 
                                quote="\"") 

## use the factor function to create our own value labels stored in "activities"
tidydata$activities <- factor(tidydata$activities, 
                         levels = activities$V1,
                         labels = activities$V2) 


## store the dataset 

write.table(tidydata, file = "tidydata.txt")

###############################################################################

#4. Appropriately labels the data set with descriptive variable names.

## Please note that this has been done in the previous steps with 

## names =   c("subj_id", features$features, "activities") 
#  colnames(df) =  names


################################################################################

#5. From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.

## We group the data by subject id, data source (ie train vs test) and performed 
## activities and summarise the feature variables using the mean
tidydata_mean <- tidydata %>%
        group_by(data_source, subj_id, activities) %>%
        summarise_all(mean)
        

## store the datasets as .txt 

write.table(tidydata_mean, file = "tidydata_mean.txt")



