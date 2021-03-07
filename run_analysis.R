#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# warning message: 
# all variables from global environment will be removed from workspace at the beginning
# at the end there will be only the final data frame for each question left
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
remove(list=ls())
#######################Download zip file containing all data
wdir1<-getwd()
# I here create a temporary folder that will be the working directory
# if in your current working directory you have a directory called DELETEME_612 it will stop running the script with error message. This might happen if you are trying to rerun the script. In this case delete the DELETEME_612 and rerun
if(dir.exists("DELETEME_612")){remove(list=ls())
        stop("In your current directory there is a subdirectory called DELETEME_612, that might cause a problem to running this script. Please rename your directory to something else momentarily. This might happen if you are trying to rerun the script. In this case delete the DELETEME_612 and rerun Thanks!")}
dir.create("DELETEME_612")
wdir<-paste(wdir1,"DELETEME_612",sep = "/")
setwd(wdir)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","peer-graded-files.zip")
unzip("peer-graded-files.zip")
# check if needed packages are downloaded and download them if not
if(!"dplyr" %in% installed.packages()[,1]) {install.packages(dplyr)}
library(dplyr)
if(!"stringr" %in% installed.packages()[,1]) {install.packages(stringr)}
library(stringr)
###################### load tables
x_test<-read.table("UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt",header=F)
x_test<-bind_cols(x_test,y_test,subject_test)

x_train<-read.table("UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt", header=F)
x_train<-bind_cols(x_train,y_train,subject_train)

#Read colname
colname<-read.csv("UCI HAR Dataset/features.txt",sep = " ",header = F)[,2]
# make every name unique (there are duplicated)
colname<-make.names(colname,unique = T)
# add a colname for the activity stored in y_test
# "()" in the names are replaced by "..
# add the 2 columns manually for acrivity and subject
colname<-c(colname,"activity","subject")
# assign colname to both tables
names(x_test)<-colname
names(x_train)<-colname

#add a column to save the stage and subject (test or train)
x_test<-as_tibble(x_test)
x_test<-mutate(x_test,stage="test")

x_train<-as_tibble(x_train)
x_train<-mutate(x_train,stage="train")

######## Q1 Merges the training and the test sets to create one data set.
Q1_mergedf<-bind_rows(x_train,x_test)
# QC that there are 2947 rows from test dataset and 7352 rows from train dataset
table(Q1_mergedf$stage)

######### Q2 Extracts only the measurements on the mean and standard deviation for each measurement. 
# manually add the column created "activity" "subject" "stage"
newcol<-grep("mean|std",colname,value = T) %>% c("activity","subject","stage")
Q2_selectdf<-select(Q1_mergedf,all_of(newcol))

######### Q3 Uses descriptive activity names to name the activities in the data set
activity_label<-read.table("UCI HAR Dataset/activity_labels.txt")[,2]
Q3_selectdf_label<-mutate(Q2_selectdf,activity_name=activity_label[Q2_selectdf$activity])

######### Q4 Appropriately labels the data set with descriptive variable names
# replace "..." by _
# remove ".."
# trim leading and triming white space (call library stringr)
Q4_selectdf_label<-Q3_selectdf_label
names(Q4_selectdf_label)<-gsub("\\.\\.\\.","_",names(Q4_selectdf_label)) 
names(Q4_selectdf_label)<-gsub("\\.\\.","",names(Q4_selectdf_label)) %>% str_trim()

######### Q5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# As I understand the question, I will create a new dataset with average for each selected variables per activity and subject
# I need to create another variable that is unique for activity and subject called activity_subject
# There are 6 activities and 30 subjects. There will be 180 groups. 
newdf<-mutate(Q4_selectdf_label,activity_subject=activity*100+subject)
newdf_gr<-group_by(newdf,activity_subject)

# Store in a character vector the columns to apply the sum (this will exclude columns activity, activity_name, subject, activity_subject)
colapply<-grep("mean|std",names(newdf_gr),value=T)
#compute mean for every column (using across) of newdf_gr and bygroup activity_subject
Q5_mean_by_gr<-newdf_gr %>% summarise(across(.cols = colapply, mean, .names = "GRmean_{.col}")) 
# column activity subject is not tidy as it represent 2 variables. 
# Create 2 new columns one for activity, one for subject. 
Q5_mean_by_gr <- mutate(Q5_mean_by_gr,activity=floor(Q5_mean_by_gr$activity_subject/100),subject=activity_subject-100*activity) %>% select(-activity_subject)
# Still not tidy because column activity is not descriptive. TRansform the numbers into strings 
# Unselect the column activity (with numbers)
activity_label_fc<-factor(activity_label)
Q5_mean_by_gr <- mutate(Q5_mean_by_gr,activity_name=activity_label_fc[Q5_mean_by_gr$activity])%>% select(-activity)


write.table(Q5_mean_by_gr,"peer_graded_tidyTable.txt")

print("--------------Success!----------------------")
print(paste("The final tidy table has been created at ",getwd(),"/peer_graded_tidyTable.txt",sep = ""))
print("-------------------------------------------")
print("A temporary diretory has been created in your current working directory, called DELETEME_612")
print("Please remove it if you need to rerun the script, and once you do not need it anymore thank you!")
# remove intermediate variables
print("------------------------------------------")
print("----------------------------------------")
print("--------------------------------------")
print("------------------------------------")
print("----------------------------------")
print("--------------------------------")
print("------------------------------")
print("----------------------------")
print("--------------------------")
print("------------------------")

#reset working directory back to the original one
setwd(wdir1)

remove(list=ls()[!ls() %in% c("Q1_mergedf","Q2_selectdf","Q3_selectdf_label","Q4_selectdf_label","Q5_mean_by_gr")])