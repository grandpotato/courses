library(dplyr)
library(stringr)

#set the working path to where the test and training files are stored
workingpath<- "Getting and Cleaning Data/Peer Assignment/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset"

Xtest <- read.delim(str_c(workingpath, "/test/X_test.txt"),header= FALSE, sep="" ,strip.white= TRUE)
Xtrain <- read.delim(str_c(workingpath,"/train/X_train.txt"),header= FALSE, sep="" ,strip.white= TRUE)
Xall <- rbind(Xtrain,Xtest)

features <- read.delim(str_c(workingpath,"/features.txt"),header= FALSE, sep="" ,strip.white= TRUE)
varsmeanstd <-grep(".*(mean|std).*",features$V2,ignore.case = TRUE)
Xmeanstd <- select(Xall,varsmeanstd)

Ytest <- read.delim(str_c(workingpath,"/test/y_test.txt"),header= FALSE, sep="" ,strip.white= TRUE)
Ytrain <- read.delim(str_c(workingpath, "/train/y_train.txt"),header= FALSE, sep="" ,strip.white= TRUE)
Yall <- rbind(Ytrain,Ytest)
activitylabels <- read.delim(str_c(workingpath,"/activity_labels.txt"),header= FALSE, sep="" ,strip.white= TRUE)
Yallwidlabels <- inner_join(Yall,activitylabels)
names(Yallwidlabels) = c("activityid","activity")
names(Xmeanstd) = slice(features,varsmeanstd)$V2

Finishedset <- bind_cols(Xmeanstd,select(Yallwidlabels,2))

subjects <- bind_rows(read.delim(str_c(workingpath,"/test/subject_test.txt"),header= FALSE, sep="" ,strip.white= TRUE),read.delim(str_c(workingpath,"/train/subject_train.txt"),header= FALSE, sep="" ,strip.white= TRUE))

names(subjects) = "subjects"
tidyset <- bind_cols(Finishedset,subjects)

tidyset <- tidyset %>% group_by(subjects,activity) %>% summarise_each((funs(mean)))

write.table(tidyset, file="submission.csv" ,row.name=FALSE)

