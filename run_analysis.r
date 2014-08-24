
# R script called run_analysis.R does the following: 
# - Merges the training and the test sets to create one data set.
# - Extracts only the measurements on the mean and standard 
#   deviation for each measurement. 
# - Uses descriptive activity names to name the activities in the data set
# - Appropriately labels the data set with descriptive variable names. 
# - Creates a second, independent tidy data set with the average of 
#   each variable for each activity and each subject.

#Author: Suresh Nageswaran
#Date: 08/08/2014

# Function: run_analysis()
# Inputs  : Path to input dataset
# Output  : First tidy dataset on disk. Second tidy dataset returned
# This function works on the input dataset and invokes all the other
# functions in this code.
# Firstly, it creates the folder structure for output
# Then, it consolidates the test and training datasets
# Following this, the first tidy dataset is created with subject
# and activity descriptions as required for the 66 variables (mean/stdev)
# Finally, the second tidy dataset is created with average values for
# the variables in the first one.

run_analysis <- function(sPath = "c:/Projects/Rwork/Getdata006/Assignment")
{
  #setwd("C:/Projects/RWork/GetData006/Assignment/UCI HAR Dataset/")
  
  # Set the working directory
  setwd(sPath)
  
  if(file.exists("UCI HAR Dataset") == FALSE)
  {
    print("Could not find the UCI HAR Dataset in the current working folder. Please copy this dataset to the current working folder or set the working folder to the parent of UCI HAR Dataset folder.")
    return(FALSE)
  }
  
  # Create the output folder structure  
  createOutput(sPath)
  
  # Consolidate the test and training datasets
  consolidateDatasets()
  
  # Create the first 'Tidy' dataset
  # It comprises of the consolidated dataset with subject, 
  # activity descriptions and 66 variables (33 for mean, 33 for Stdev)
  createTidyDataset()
  
  # Now create the second 'tidy' dataset
  # This contains the average values for all 66 variables for each 
  # subject and activity
  df <- createSecondTidyDataset()
  return(df)
  
}

# Set up items to deliver
createOutput <- function(sPath = "c:/Projects/Rwork/Getdata006/Assignment")
{
  # The output folder for this project has to contain the following:
  # 1. The Raw Data
  # 2. The Tidy Data Set
  # 3. Code book detailing variables and values in the tidy data set
  # 4. The recipe to get from raw to tidy
  print("Creating output folder structure ...")
  
  sPathtoRaw <- paste(sPath, "/UCI HAR Dataset", sep="")
  
  # Verify that the UCI HAR Dataset folder exists under this
  #tryCatch(setwd(sPathtoRaw), error = stop("Path was incorrect. Did not find the dataset"))
  setwd(sPathtoRaw)
  
  # Now create the output folder
  sPathtoOutput <- paste(sPath, "/output", sep="")
  
  dir.create(sPathtoOutput)
  dir.create(paste(sPathtoOutput,"/raw", sep=""))
  dir.create(paste(sPathtoOutput,"/tidy",sep=""))
  
  # and copy the raw data to the 'raw' folder under the new 'output' folder
  sPathtoOutput <- paste(sPathtoOutput,"/raw", sep="")
  
  file.copy(paste(sPathtoRaw,"/features.txt", sep=""), sPathtoOutput)
  file.copy(paste(sPathtoRaw,"/activity_labels.txt", sep=""), sPathtoOutput)
  
  file.copy(paste(sPathtoRaw,"/train/X_train.txt", sep=""), sPathtoOutput)
  file.copy(paste(sPathtoRaw,"/train/y_train.txt", sep=""), sPathtoOutput)
  file.copy(paste(sPathtoRaw,"/train/subject_train.txt", sep=""), sPathtoOutput)
  file.copy(paste(sPathtoRaw,"/test/X_test.txt", sep=""), sPathtoOutput)
  file.copy(paste(sPathtoRaw,"/test/y_test.txt", sep=""), sPathtoOutput)
  file.copy(paste(sPathtoRaw,"/test/subject_test.txt", sep=""), sPathtoOutput)
  
  return (TRUE)
  
}

# Function consolidateDatasets()
# Inputs : Path to first dataset, second dataset and desired output
# This function reads both datasets and copies the contents
# into the output file.
# Returns TRUE if everything works
consolidateDatasets<- function(sPath = "c:/Projects/Rwork/Getdata006/Assignment")
{
  print("Consolidating datasets ...")
  sOutPath <- paste(sPath, "/output/tidy/FirstTidyDataset.txt", sep="")
  
  # initialize the connection
  inConX1 <- inConY1 <-inConSub1 <- inConX2 <- inConY2 <-inConSub2 <- outCon <- NULL
  
  # attempt to open the file connections
  inConX1 <- file(paste(sPath, "/output/raw/X_train.txt", sep=""), open="r")
  inConY1 <- file(paste(sPath, "/output/raw/Y_train.txt", sep=""), open="r")
  inConSub1 <- file(paste(sPath, "/output/raw/subject_train.txt", sep=""), open="r")
  outCon <- file(sOutPath, open = "w+")
  
  # Error Handling
  if(is.null(inConX1) || is.null(inConY1) || is.null(inConSub1) || is.null(outCon))
  {
    return(FALSE)
  }
  
  print("Processing training dataset...") 
  
  # Read the X file line by line and write it to output
  while (length(sLineX <- readLines(inConX1, n = 1 )) > 0)
  {
    #Read a line from the Y file 
    sLineY <- readLines(inConY1, n = 1)
    #Read a line from the subject file; 
    #the sprintf is to add the leading spaces
    sLineSub <- sprintf("%2s", readLines(inConSub1, n = 1))
    
    # Combine X and Y and Subject
    sOut <- paste(sLineSub, paste(sLineY, sLineX, sep=" "), sep =" ")
    
    writeLines(sOut, outCon)
  }
  
  close(inConX1)
  close(inConY1)
  close(inConSub1)
  
  # attempt to open the file connections
  inConX2 <- file(paste(sPath, "/output/raw/X_test.txt", sep=""), open="r")
  inConY2 <- file(paste(sPath, "/output/raw/Y_test.txt", sep=""), open="r")
  inConSub2 <- file(paste(sPath, "/output/raw/subject_test.txt", sep=""), open="r")
  
  # Error Handling
  if(is.null(inConX2) || is.null(inConY2) || is.null(inConSub2) || is.null(outCon))
  {
    return(FALSE)
  }
  
  print("Processing test dataset...") 
  
  # Read the X file line by line and write it to output
  while (length(sLineX <- readLines(inConX2, n = 1 )) > 0)
  {
    #Read a line from the Y file 
    sLineY <- readLines(inConY2, n = 1)
    #Read a line from the subject file
    #the sprintf is to add the leading spaces
    sLineSub <- sprintf("%2s", readLines(inConSub2, n = 1))
    
    # Combine X and Y and Subject
    sOut <- paste(sLineSub, paste(sLineY, sLineX, sep=" "), sep =" ")
    
    writeLines(sOut, outCon)
  }
  
  # Close all connections and return  
  close(inConX2)
  close(inConY2)
  close(inConSub2)
  close(outCon)
  
  return(TRUE)
}

# Function: createTidyDataset()
# Inputs  : Path to consolidated dataset - FirstTidyDataset.txt
# Output  : First tidy dataset  - FirstTidyDataset.csv
# This function works on the consolidated dataset and creates a 
# csv file as the Tidy dataset containing only the variable of
# interest.
# Returns : logical / TRUE

createTidyDataset<- function(sPath="c:/Projects/Rwork/Getdata006/Assignment")
{
  #tryCatch(setwd(sPath), error = stop("Path was incorrect. Did not find the dataset"))
  setwd(sPath)
  print ("Creating first 'Tidy' dataset under /output/tidy/FirstTidyDataset.csv ...")
  
  # Read in activity_labels.txt
  dfAct <- read.delim("output/raw/activity_labels.txt", header=FALSE, sep=" ")
  
  # Now read in the columns of interest in the FirstTidyDataset file
  dfCols <- getColNames()
  
  # Read in output/tidy/FirstTidyDataset.txt line by line (this is a v big dataset)
  inCon <- file(paste(sPath, "/output/tidy/FirstTidyDataset.txt", sep=""), open="r")
  outCon <- file(paste(sPath, "/output/tidy/FirstTidyDataset.csv", sep=""), open="w+")
  
  # We want only the column names of interest 
  # These are the rows with TRUE in the Include col of the dataframe  
  names <- subset(dfCols, Include==TRUE, Desc)
  names <- unlist(names, use.names = FALSE)
  
  # Append column names for the first two columns to the front of this vector
  names <- append(append(names,"ActivityLabels", after=0),"Subject", after=0)  
  # names is a character vector, which we will collapse into a CSV line
  names <- paste(names, collapse=",")
  
  #Finally write this line to the output
  write.table(names, file=outCon, row.names=FALSE, col.names=FALSE, quote=FALSE)
  
  while(length(sLine <- readLines(inCon, n = 1 )) > 0)
  {
    # Parse the line that was read into a vector of type double
    dblLine <- append(append(as.double(trim(substring(sLine, seq(from=6, to=8966, by=16), seq(from=22, to=8982, by=16)))), as.double(trim(substring(sLine,4,6))), after = 0),as.double(trim(substring(sLine,1,3))), after = 0)    
    
    # Then retain only the variables of interest
    # We use the columns of interest variable as a sieve to do this
    dblLine <- dblLine[dfCols[,3]]
    
    # Replace the activity number (1:6) with the descriptive label
    # This is in item 2 of the dblLine vector
    sActivityValue <- as.character(dfAct[match(dblLine[2], dfAct[,1]), 2])
    dblLine[2] <- sActivityValue
    
    # Convert this to a CSV line for output
    dblLine <- unlist(dblLine, use.name=FALSE)
    dblLine <- paste(dblLine, collapse=",")
    
    # Write the line to the output
    write.table(dblLine, file=outCon, row.names=FALSE, col.names=FALSE, quote=FALSE)
    
  }
  
  close(inCon)
  close(outCon)
  
  # Finally delete the FirstTidyDataset.txt file
  file.remove("output/tidy/FirstTidyDataset.txt")  
  
  return(TRUE)
}

# Function: createSecondTidyDataset()
# Inputs  : Path to tidy dataset - FirstTidyDataset.csv
# Output  : Second tidy dataset  - FirstTidyDatasetSummary.csv
# This function works on the tidy dataset and creates a 
# second, independent tidy data set with the average of 
# each variable for each activity and each subject.

createSecondTidyDataset<-function(sPath="c:/projects/rwork/Getdata006/Assignment")
{  
  setwd(sPath)
  print("Creating second tidy dataset under /output/tidy/SecondTidyDataset.csv ...")
  
  # Read the 
  df <- read.csv("output/tidy/FirstTidyDataset.csv")
  df <- aggregate(.~Subject+ActivityLabels, data=df, FUN=mean)
  write.csv(df, "output/tidy/SecondTidyDataset.csv", row.names=FALSE, quote=FALSE)
  # Added because submission requires a .txt file not a .csv file
  write.table(df, "output/tidy/SecondTidyDataset.txt", row.names=FALSE, quote=FALSE)
  
  return(df)
}


# Utility Function: trim (character string) returns char string
# This function removes the leading and trailing spaces
# on the input character string
trim <- function (x) gsub("^\\s+|\\s+$", "", x)

# Function getColNames : invoked by createTidyDataset to create
# the first tidy dataset.
# Input  : Path to the folder structure containing the features.txt file
# Output : Data frame 
# Details:
# This function works on the features.txt file in the dataset.
# The features.txt lists out all the column names in our datasets.
# This function will mark with TRUE all the column names that have
# either "mean" or "std" in them. These are the variables of interest.
# Returns : data frame with variable number, variable name, logical
# TRUE/FALSE indicating interest

getColNames <- function(sPath = "c:/Projects/Rwork/Getdata006/Assignment")
{
  setwd(sPath)
  print ("Extracting column names ...")
  
  # read in the features file
  df<-read.delim ("output/raw/features.txt", header=FALSE, sep =" ")
  
  # renumber the elements; move by 2 to match format in FirstTidyDataset.txt
  df[,1] <- seq(from=3, to=563, by=1)
  
  # grep for the variables with mean or std-dev values
  df<- cbind(df, (grepl("mean\\(\\)", df[,2]) | grepl("std\\(\\)", df[,2])))
  colnames(df) <- c("Num", "Desc", "Include")
  
  # Now invoke the cleanColNames function on the contents of the dataframe
  df[,2] <- sapply(df[,2], cleanColNames)
  
  return(df)
}


# My interpretation of the "descriptive column names" rubric
# is that we remove all punctuations and convert to Hungarian
# Notation. 
# e.g. tGravityAcc-correlation()-X,Y
# to   tGravityAccCorrelation_XY
# Clean column names from the punctuations in them
cleanColNames <- function(sInput)
{
  print ("Cleaning dataset ...")
  #First we remove the dashes and capitalize the letter after
  sOut <- gsub("-([a-zA-Z])", "\\U\\1", sInput, perl=TRUE)
  # Now remove the () if found
  sOut <- gsub("\\(\\)", "", sOut, perl=TRUE)
  # Now remove any commas and capitalize the letter after
  sOut <- gsub(",([a-zA-Z])", "\\U\\1", sOut, perl=TRUE)
  return(sOut)
}
