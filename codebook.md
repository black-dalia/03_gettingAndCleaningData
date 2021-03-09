---
title: "Codebook for peer graded quiz week 4 of module 03 Getting and Cleaning the Data"
author: "Me! "
date: "February 25th 2021"
output:
  html_document:
    keep_md: yes
---

## Project Description
This project aims at extracting information, handling tables and creating tables from an experiment that measures several movement related variables over 30 subjects during 6 classes of activity.



## Study design and data processing
The experiments have been carried out with a group of **30 volunteers** within an age bracket of 19-48 years. Each person performed **six activities** (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.\
Using its embedded accelerometer and gyroscope, we captured **3-axial linear acceleration** and **3-axial angular velocity** at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.\

\ The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

## Collection of the raw data

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.\

\ Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).\ 

\ Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). \

\ These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

## Running script peer-graded.R

The script will create a data frame for each question.\

### Warnings

Before running the script peer-graded.R, be aware that this script will: \
- install packages dplyr and stringr in the default directory if there are not installed already\
- clean all your variables in the global environment at the beginning of the script\
- clean all intermediate variables at the end of the script\newline
- a temporary directory will be created in your current working directory, called DELETEME_612. The working directory will be then set to this DELETEME_612, and set back to your current directory at the end of the script.\
- If there is already a directory called DELETEME_612 in your working directory, there will be an error message. This will be the case if you are trying to rerun the script. Please remove the directory called DELETEME_612 before rerunning.  
\newline  
\newline
You will be left with 5 elements in your environment (if everything goes right):\
- **Q1_mergedf**: the data frame that answers Q1 after merging test and train dataset\
- **Q2_selectdf**: after selecting column containing either mean or standard deviation\
- **Q3_selectdf_label**: with descriptive activity names\
- **Q4_selectdf_label**: with optimized naming\
- **Q5_mean_by_gr**: a tidy dataset containing the mean by group for each column of Q4 dataset\

### Cleaning of the data
Data has been loaded and processed as detailed in the script file.\ 

## Description of the variables in the Q5_mean_by_gr data frame (final question of the quiz)
The final data frame Q5_mean_by_gr contains the mean per group of each of the selected variables  in question 2 (79 variables in total). The group, as I understood it, is unique per person and per activity. To overcome the issue of having to do a double grouping, I have created another variable **activity_subject** that would be unique for each activity and subject. 

```activity_subject
activity_subject = activity*100 + subject
```
The mean is then calculated for each of the 79 variables selected, per group activity_subject. 2 more columns are added to unsure the data frame is tidy: activity and subject. As there are 6 activities and 30 subject, the dimension of the resulting data frame will be:  
- 30*6 = 180 rows  
- 79 + 2= 81 columns  


(you can easily use Rcode for this, just load the dataset and provide the information directly form the tidy data file)

## Variable  description 1 (repeat this section for all variables in the dataset)
Short description of what the variable describes.

Some information on the variable including:
 - Class of the variable
 - Unique values/levels of the variable
 - Unit of measurement (if no unit of measurement list this as well)
 - In case names follow some schema, describe how entries were constructed (for example time-body-gyroscope-z has 4 levels of descriptors. Describe these 4 levels). 

(you can easily use Rcode for this, just load the dataset and provide the information directly form the tidy data file)

####Notes on variable 1:
If available, some additional notes on the variable not covered elsewehere. If no notes are present leave this section out.

##Sources
Sources you used if any, otherise leave out.

##Annex
If you used any code in the codebook that had the echo=FALSE attribute post this here (make sure you set the results parameter to 'hide' as you do not want the results to show again)
@rlugojr
