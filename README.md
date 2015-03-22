##ORIGINAL EXPERIMENT
The experiment carried out by Jorge L. Reyes-Ortiz & co. was conducted with 30 subjects within an age bracket of 19-48 years, wearing a smartphone(Samsung Galaxy S II) on their waists. Gyroscope and acceleromter readings were taken while each subject was performing 6 activities(walking, walking upstairs, walking downstairs, sitting, standing and laying). A 561-feature vector with time and frequency domain variables for the measurements was created for every record in the table. The experiment divided the data collected into 2 data sets- training and test. 70 % of the subjects were placed in the training data set and the remaining 30 % in the test set.

##PROJECT
##A script, run_analysis.r was created that satisfied the following requirements-
* Merges the test and training sets into one
* Extracts only the mean and standard deviation for each measurement
* Appropriately labels the column names and replace the activity ids with their descriptive names
* Creates a final tidy set from the table created with the above steps to contain only the means for every activity for evey subject

##SCRIPT DETAILS
###Downloading the file
* The file was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and placed in the working directory
* The file was then unzipped and placed in the directory, "ds3" created in the working directory

###Creating the measurement column name table
* The measurement column name table was created by reading the features from "ds3/UCI HAR Dataset/features.txt"

###Creating the measurement table in the test set
* The test set was read in from "ds3/UCI HAR Dataset/test/X_test.txt" and the rows bound to the "test" table
* The column names for the test table was extracted from the measurement column name table

###Creating subject-activity table in the test set
* The subject and activity tables for the test set were created after reading from "ds3/UCI HAR Dataset/test/subject_test.txt" and "ds3/UCI HAR Dataset/test/y_test.txt", respectively
* The columns of the 2 tables were concatenated to create the subject-activity table (columns= subject, activity) for the test set

###Creating the measurement table in the training set
* The training set was read in from "ds3/UCI HAR Dataset/train/X_train.txt" and the rows bound to the "training" table
* The column names for the training table were extracted from the measurement column name table

###Creating subject-activity table in the training set
* The subject and activity tables for the training set were created after reading from "ds3/UCI HAR Dataset/train/subject_train.txt" and "ds3/UCI HAR Dataset/train/y_train.txt", respectively
* The columns of the 2 tables were concatenated to create the subject-activity table (columns= subject, activity) for the training set

###Creating the full table with the test & training sets
* The rows of the test and the training tables, in that order, were concatenated to create the full table 

###Extracting the required full table columns
* All columns with mean and std in the full table column names were extracted using grepl() and passing the required pattern
* The columns included all matched names containing parentheses as well

###Modifying the columns names in the full table
* Acc,Gyro,Freq and std in the column names were expanded to Accelerometer,Gyroscope,Frequency &
StandardDeviation, respectively
* Upper case in the column names were not changed to lower case since the long names with only lower case would be a bit hard to read
* The parentheses symbol and "-" were removed from the full table column names using gsub()

###Adding the subject & activity columns to the full table
* The subject-activity table was added to the full table with the subject and activity columns at the beginning of the full table

###Renaming the activity ids with their labels
* The activity ids in the full table were renamed with their names as defined in "\ds3\UCI HAR Dataset\activity_labels.txt"

###Looping through all subjects to create the final table with grouped means
* The full table was broken into 30 subsets (for 30 subjects) and the column means for every activity for each subset was calculated using aggregate()
* The resulting rows from the above activity were added to the new data frame, dataMeanStd

###Renaming the 2 columns in the final table used for grouping
* The 2 columns in the dataMeanStd table used for grouping to determine the means were renamed to subject & activity, in that order

##POST SCRIPT TASKS
###Writing the table to a text file
* To write the table into a text file, the following command was run-
* write.table(dataMeanStd,file="dataMeanStd.txt",row.names=FALSE)
* The text file was created in the working directory

###Table reading and script running tasks by an external participant
####Reading the table into R
* To read the table into R from the course evaluation page, the following steps were taken-
* The file was opened in the "Preview" mode and saved from the internet into the working directory with the file name "dataMeanStd.txt"
* The following command was run in R Studio- dataMeanStdUploaded<-read.table("dataMeanStd.txt", sep=" ")
* The spreadsheet icon next to the file name in the Global environment section was clicked and the data frame showed up in the "script creation" window

####Running the Github repository script locally
* The following command was run within the local repository- git pull "Github repository address"
* The script was copied to the working directory and then run

##ACKNOWLEDGEMENTS
The data set used in the study was made possible by the following publication-
* Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

