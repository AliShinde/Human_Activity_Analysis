library(dplyr)
setwd("D:/getdata_projectfiles_UCI HAR Dataset")


#read train data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
sub_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#read test data
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
sub_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#read activity labels and description 
description <- read.table("./UCI HAR Dataset/features.text")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

#merging the test and the train dataset to a single dataset 
x_total <- rbind(x_train, x_test)
y_total <- rbind(y_train, y_test)
sub_total <- rbind(sub_train, sub_test)

#extracting mean and std values from the set 
required_var <- description[grep("mean\\(\\)|std\\(\\)"),description[,2],]
x_total <- x_total[,required_var[,1]] 

#Giving descriptive activity names 
colnames(y_total) <- "activity"
y_total$activitylabel <- factor(y_total$activity, labels = 
                                  as.character(activity_labels[,2]))
activitylabel <- y_total[,-1]

#appropriate labels with descriptive names
colnames(x_total) <- description[required_var[,1],2]

#From the above creates a tidy dataset with avg of each variable and activity
colnames(sub_total) <- "subject"
total <- cbind(x_total, activitylabel, sub_total)
total_mean <- total %>% group_by(activitylabel, subject) %>% summarise_each(funs = (mean))
write.table(total_mean, file = "./UCI HAR Dataset/tidydata.txt", row.names = FALSE,
            col.names = TRUE)
