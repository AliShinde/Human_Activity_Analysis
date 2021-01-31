The variables in the tidy data
Tidy data contains 180 rows and 68 columns. Each row has averaged variables for each subject and each activity.

Only all the variables estimated from mean and standard deviation in the tidy set were kept.
mean(): Mean value
std(): Standard deviation
The data were averaged based on subject and activity group.
Subject column is numbered sequentially from 1 to 30. Activity column has 6 types as listed below.

WALKING
WALKING_UPSTAIRS
WALKING_DOWNSTAIRS
SITTING
STANDING
LAYING


The script follows five steps to the give the output of tidySet 
Step 1: Reading files from the zip file
Step 2: Merging the datasets
Step 3: Extracting measurements on mean and standard deviation of each measurement
Step 4: Using activity names 
Step 5: Creating a second inependent tidy set as the output dataset

About variables:-
x_train, y_train and sub_train are the training set varaibales
x_test, y_test and sub_test are the test set variables
final is the dataset containg the merged dataset 
final_mean_std is the dataset containing the mean and standard deviation of each measurement
tidySet is the final output dataset 
