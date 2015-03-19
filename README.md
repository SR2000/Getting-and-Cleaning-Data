OVERVIEW
The name of the script is run_analysis.r

##SCRIPT DETAILS
###Downloading the file
*The file was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zipand placed in the working directory
*The file was then unzipped and placed in the directory, "ds3" created in the working directory

###Creating the measurement column name table
*The measurement column name table was created by reading the features from "ds3/UCI HAR Dataset/features.txt"

###Creating the measurement table in the test set
*The test set was read in from "ds3/UCI HAR Dataset/test/X_test.txt" and the rows bound to the test table
*The column names for the test table was extracted from the measurement column name table

###Creating subject-activity table in the test set
*The subject(participants) and activity tables for the test set were created after reading from "ds3/UCI HAR Dataset/test/subject_test.txt" and "ds3/UCI HAR Dataset/test/y_test.txt", respectively
*The columns of the 2 tables were concatenated to create the subject-activity table (columns= subject, activity) for the test set

###Creating the subject_activity-measurement table in the test set
*The columns of the subject-activity(test) table and the test table were concatenated to form a single subject-activity-test table

###Creating the measurement table in the training set
*The training set was read in from ""ds3/UCI HAR Dataset/train/X_train.txt"" and the rows bound to the test table
*The column names for the training table was extracted from the measurement column name table

###Creating subject-activity table in the training set
*The subject(participants) and activity tables for the training set were created after reading from ds3/UCI HAR Dataset/train/subject_train.txt" and 
"ds3/UCI HAR Dataset/train/y_train.txt", respectively
*The columns of the 2 tables were concatenated to create the subject-activity table (columns= subject, activity) for the training set

###Creating the subject_activity-measurement table in the training set
*The columns of the subject-activity(test) table and the test table were concatenated to form a single subject-activity-test table

###Creating the full table with the test & training sets
*The rows of the test and the training tables, in that order, were concatenated to create the full table 

###Extracting the full table columns with mean and std in their names
*All columns with mean and std in the full table were extracted using the grepl()and passing the required pattern
*The columns were not restricted to only those names without parentheses but rather all columns having mean and std anywhere
in their name

###Renaming the activity ids with their labels
*The activity ids in the full table were renamed with their names as defined in "\ds3\UCI HAR Dataset\activity_labels.txt"

###Full table column name changes and ensuring the full table has consistent data type
*Columns in the full table with Acc,Gyro,Freq and std in their names were expanded to Accelerometer,Gyroscope,Frequency &
StandardDeviation, respectively
*Upper case in the column names were not changed to lower case since the long names with the same lower case would be rather confusing

###Removing parentheses and "-" from the full table column names
*Column names carrying "-" and the symbol for parentheses were modified to not have them using grepl()

###Re-adding the subject & activity columns to the full table
*Since the full table column name changes removed those columns not in the corresponding patterns, the subject-activity table had to be re-added to the full table
*All measurement value columns in the full table were ensured to be numeric

###Looping through all subjects to create the dataMeanStd table with grouped means
*The full table was broken into 30 subsets (for 30 subjects) and the column means for every activity for each subset was calculated using aggregate()
*The resulting rows from the above activity were added to the new data frame, dataFinal

###Renaming the 2 columns in the dataMeanStd table used for grouping
*The 2 columns in the dataMeanStd table used for grouping to determine the means were renamed to subject & activity

##POST SCRIPT TASKS
###Writing the table to a textfile
*To write the table into a text file, the following command was run- 
**write.table(dataMeanStd,file="dataMeanStd.txt",row.names=FALSE))

###Reading the table into R
*To read the table into R, the following steps were taken-
**temp1<-read.table("dataMeanStd.txt", sep=" ")
**Click on spreadsheet icon next to the file in the Global environment section and the data frame will show up in the window above the console 
