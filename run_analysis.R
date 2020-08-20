library(plyr)
library(dplyr)

#if(!file.exists("./getcleanfinal")){dir.create("./getcleanfinal")}
#fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileurl,"./getcleanfinal/projectdataset.zip")

#unzip("./getcleanfinal/projectdataset.zip",exdir = "./getcleanfinal")

#Reading test and train data
x_test<-read.table("./getcleanfinal/UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./getcleanfinal/UCI HAR Dataset/test/Y_test.txt")
sub_test<-read.table("./getcleanfinal/UCI HAR Dataset/test/subject_test.txt")

x_train<-read.table("./getcleanfinal/UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./getcleanfinal/UCI HAR Dataset/train/Y_train.txt")
sub_train<-read.table("./getcleanfinal/UCI HAR Dataset/train/subject_train.txt")

activity_label<-read.table("./getcleanfinal/UCI HAR Dataset/activity_labels.txt")
features<-read.table("./getcleanfinal/UCI HAR Dataset/features.txt")


#Assigning activitylabels
colnames(x_test)<-features[,2]
colnames(y_test)<-"activityID"
colnames(sub_test)<-"subjectID"

colnames(x_train)<-features[,2]
colnames(y_train)<-"activityID"
colnames(sub_train)<-"subjectID"

colnames(activity_label)<-c("activityID","typeofactivity")
#MErging all datasets in one
test_final<-cbind(x_test,y_test,sub_test)
train_final<-cbind(x_train,y_train,sub_train)

final<- rbind(train_final,test_final)
#Extracting mean and standard deviation
column_set<-colnames(final)
mean_std<-(grepl("activityID",column_set)| grepl("subjectID",column_set)|
          grepl("mean..",column_set) | 
          grepl("std..",column_set))
final_mean_set<-final[, mean_std==TRUE]

final_with_activity<-merge(final_mean_set,activity_label, by = "activityID",
                           all.x = TRUE )
tidySet<-aggregate(. ~subjectID + activityID,final_with_activity, mean)
tidySet<-tidySet[order(tidySet$subjectID,tidySet$activityID),]
#output in a text file
write.table(tidySet,"TidySet.txt",row.names = FALSE)


