GetData006_CourseAssignment
===========================

This repository contains all items being submitted as part of the GetData006 course project assignment.

==================================================================
Coursera GetData006 : Course Project

Uses: Human Activity Recognition Using Smartphones Dataset
Version:  1.0
==================================================================
Suresh Nageswaran
sureshnageswaran@yahoo.com
Submitted: 08/24/2014
==================================================================

The notes on this assignment:
============================
<snip>
You should create one R script called run_analysis.R that does the following. 
 * Merges the training and the test sets to create one data set.
 * Extracts only the measurements on the mean and standard deviation for each measurement. 
 * Uses descriptive activity names to name the activities in the data set
 * Appropriately labels the data set with descriptive variable names. 
 * Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
</snip>

Submitted Items
===============
1) A tidy data set

FirstTidyDataset.csv found at this location : https://github.com/sureshnageswaran/GetData006_CourseAssignment/blob/master/FirstTidyDataset.csv
SecondTidyDataset.csv found at this location: https://github.com/sureshnageswaran/GetData006_CourseAssignment/blob/master/SecondTidyDataset.csv

2) Link to a Github repository with the script for performing the analysis

https://github.com/sureshnageswaran/GetData006_CourseAssignment

File to refer: run_analysis.r

Found at this location: https://github.com/sureshnageswaran/GetData006_CourseAssignment/blob/master/run_analysis.r

3) Code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.

Found at this location:  https://github.com/sureshnageswaran/GetData006_CourseAssignment/blob/master/CodeBook.md

4) File README.md in the repo with the scripts. This repo explains how all of the scripts work and how they are connected. 


Assumptions and Requirements:
============================

1. Assumed that you have downloaded the following file : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Assumed that this zip file has been extracted to a folder on your hard drive. 
3. Copy the run_analysis.r file to your folder.
4. Invoke run_analysis() with the path to UCI HAR Dataset 
e.g. If UCI HAR Dataset is located at C:/projects/rwork/getdata006/assignment/UCI HAR Dataset in your drive, then run the command below
     run_analysis ("C:/projects/rwork/getdata006/assignment/") 
5. The run_analysis() function returns a data frame. You can choose to capture it or view the results in the /output/tidy folder. Files are FirstTidyDataset.csv and SecondTidyDataset.csv.


The dataset includes the following files:
=========================================

- 'README.md' - This file

- 'run_analysis.r" - The code

- 'CodeBook.md' - The cookbook describing the code and all associated variables.

- 'FirstTidyDataset.csv' - The output from running run_analysis.r

- 'SecondTidyDataset.csv' - The output from running run_analysis.r
