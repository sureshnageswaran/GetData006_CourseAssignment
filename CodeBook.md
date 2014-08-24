CodeBook.md

This file describes all the work done to achieve the results.

All code is present in a single file called run_analysis.r

Procedure:
=========
1. This run_analysis() function invokes several functions internally.
2. All output is first created in the /output folder under the current working directory. The function invoked is createOutput().
3. The raw data is copied into the /output/raw folder.
4. The training and test datasets (including X_train, Y_train, subject_train, X_test, 
Y_test, subject_test and activity_labels ) are consolidated into a single dataset. The function invoked to do this is consolidateDatasets()
5. Further, this dataset is filtered to ensure only the columns containing mean() and std() 
data are retained. This dataset is saved under /output/tidy/FirstTidyDataset.csv. The function invokeed to do this is createTidyDataset()
6. The run_analysis() function finally invokes the createSecondTidyDataset() function to create the SecondTidyDataset.csv file. This file
contains average values for all the 66 variables for the Subject/Activity pairs.

Variable List
=============
Subject : The subject (1:30)
ActivityLabels : The descriptive activities (SITTING, LAYING, STANDING, WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS)

tBodyAccMeanX  : Variable of interest 
tBodyAccMeanY : Variable of interest 
tBodyAccMeanZ : Variable of interest 
tBodyAccStdX : Variable of interest 
tBodyAccStdY : Variable of interest 
tBodyAccStdZ : Variable of interest 
tGravityAccMeanX : Variable of interest 
tGravityAccMeanY : Variable of interest 
tGravityAccMeanZ : Variable of interest 
tGravityAccStdX : Variable of interest 
tGravityAccStdY : Variable of interest 
tGravityAccStdZ : Variable of interest 
tBodyAccJerkMeanX : Variable of interest 
tBodyAccJerkMeanY : Variable of interest 
tBodyAccJerkMeanZ : Variable of interest 
tBodyAccJerkStdX : Variable of interest 
tBodyAccJerkStdY : Variable of interest 
tBodyAccJerkStdZ : Variable of interest 
tBodyGyroMeanX : Variable of interest 
tBodyGyroMeanY : Variable of interest 
tBodyGyroMeanZ : Variable of interest 
tBodyGyroStdX : Variable of interest 
tBodyGyroStdY : Variable of interest 
tBodyGyroStdZ : Variable of interest 
tBodyGyroJerkMeanX : Variable of interest 
tBodyGyroJerkMeanY : Variable of interest 
tBodyGyroJerkMeanZ : Variable of interest 
tBodyGyroJerkStdX : Variable of interest 
tBodyGyroJerkStdY : Variable of interest 
tBodyGyroJerkStdZ : Variable of interest 
tBodyAccMagMean : Variable of interest 
tBodyAccMagStd : Variable of interest 
tGravityAccMagMean : Variable of interest 
tGravityAccMagStd : Variable of interest 
tBodyAccJerkMagMean : Variable of interest 
tBodyAccJerkMagStd : Variable of interest 
tBodyGyroMagMean : Variable of interest 
tBodyGyroMagStd : Variable of interest 
tBodyGyroJerkMagMean : Variable of interest 
tBodyGyroJerkMagStd : Variable of interest 
fBodyAccMeanX : Variable of interest 
fBodyAccMeanY : Variable of interest 
fBodyAccMeanZ : Variable of interest 
fBodyAccStdX : Variable of interest 
fBodyAccStdY : Variable of interest 
fBodyAccStdZ : Variable of interest 
fBodyAccJerkMeanX : Variable of interest 
fBodyAccJerkMeanY : Variable of interest 
fBodyAccJerkMeanZ : Variable of interest 
fBodyAccJerkStdX : Variable of interest 
fBodyAccJerkStdY : Variable of interest 
fBodyAccJerkStdZ : Variable of interest 
fBodyGyroMeanX : Variable of interest 
fBodyGyroMeanY : Variable of interest 
fBodyGyroMeanZ : Variable of interest 
fBodyGyroStdX : Variable of interest 
fBodyGyroStdY : Variable of interest 
fBodyGyroStdZ : Variable of interest 
fBodyAccMagMean : Variable of interest 
fBodyAccMagStd : Variable of interest 
fBodyBodyAccJerkMagMean : Variable of interest 
fBodyBodyAccJerkMagStd : Variable of interest 
fBodyBodyGyroMagMean : Variable of interest 
fBodyBodyGyroMagStd : Variable of interest 
fBodyBodyGyroJerkMagMean : Variable of interest 
fBodyBodyGyroJerkMagStd : Variable of interest 
