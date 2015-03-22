#run_analysis.r

        ##Downloading the file
        fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl,destfile="courseProject.zip")
        unzip("courseProject.zip",exdir="ds3")
                
        ##Creating the measurement column name table
        cols<-read.table("ds3/UCI HAR Dataset/features.txt",as.is=TRUE)
                
        ##Creating the measurement table in the test set
        test<-data.frame()
        test<-rbind(test,read.table("ds3/UCI HAR Dataset/test/X_test.txt",as.is=TRUE))
        colnames(test)<-cols[,2]
        
        ##Creating subject-activity table in the test set
        subj_test<-read.table("ds3/UCI HAR Dataset/test/subject_test.txt",as.is=TRUE)
        colnames(subj_test)<-"subject"
        act1_test<-read.table("ds3/UCI HAR Dataset/test/y_test.txt",as.is=TRUE)
        colnames(act1_test)<-c("activity")
        subj_act_test<-cbind(subj_test,act1_test)
            
        ##Creating the measurement table in the training set
        train<-data.frame()
        train<-rbind(train,read.table("ds3/UCI HAR Dataset/train/X_train.txt",as.is=TRUE))
        colnames(train)<-cols[,2]
        
        ##Creating subject-activity table in the training set
        subj_train<-read.table("ds3/UCI HAR Dataset/train/subject_train.txt",as.is=TRUE)
        colnames(subj_train)<-"subject"
        act1_train<-read.table("ds3/UCI HAR Dataset/train/y_train.txt",as.is=TRUE)
        colnames(act1_train)<-"activity"
        subj_act_train<-cbind(subj_train,act1_train)
                      
        ##Creating the full table with the test & training sets
        dataFull<-rbind(test,train)
                        
        ##Extracting the full table columns with mean and std in their names 
        strings<-c("mean","std")
        patt <- sub(',\\s','|',toString(strings))
        dataFull<-dataFull[,grepl(patt,colnames(dataFull))]
                       
        ##Modifying the columns names in the full table
        patt_acc<- sub(',\\s','|',toString("Acc"))
        patt_gyro<- sub(',\\s','|',toString("Gyro"))
        patt_freq<- sub(',\\s','|',toString("Freq"))
        patt_std<- sub(',\\s','|',toString("std"))
        colnames(dataFull)<-gsub(patt_acc,"Accelerometer",colnames(dataFull))
        colnames(dataFull)<-gsub(patt_gyro,"Gyroscope",colnames(dataFull))
        colnames(dataFull)<-gsub(patt_freq,"Frequency",colnames(dataFull))
        colnames(dataFull)<-gsub(patt_std,"StandardDeviation",colnames(dataFull))
        colnames(dataFull)<-gsub("-","",colnames(dataFull))
        colnames(dataFull)<-gsub("\\()","",colnames(dataFull))
               
        ##Adding the subject & activity columns to the full table 
        subj_act<-rbind(subj_act_test,subj_act_train)
        dataFull<-cbind(subj_act,dataFull)
                
        #Renaming the activity ids with their labels
        dataFull[dataFull[,2]==1,2]<-"WALKING"
        dataFull[dataFull[,2]==2,2]<-"WALKING_UPSTAIRS"
        dataFull[dataFull[,2]==3,2]<-"WALKING_DOWNSTAIRS"
        dataFull[dataFull[,2]==4,2]<-"SITTING"
        dataFull[dataFull[,2]==5,2]<-"STANDING"
        dataFull[dataFull[,2]==6,2]<-"LAYING"
        
        ##Looping through all subjects to create the dataMeanStd table with grouped means
        dataMeanStd<-data.frame()
        for (i in 1:30){   
                sub1<-subset(dataFull,dataFull$subject==i)
                sub2<-aggregate(sub1[,3:81], by=list(sub1$subject,sub1$activity),mean)
                dataMeanStd<-rbind(dataMeanStd,sub2)
        }
                
        ##Renaming the 2 columns in the dataMeanStd table used for grouping
        install.packages("dplyr",dependencies=TRUE)
        library(dplyr)
        dataMeanStd<-rename(dataMeanStd,subject= Group.1,activity= Group.2)
