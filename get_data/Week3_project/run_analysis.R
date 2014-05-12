## Coursera Data Science
## Getting Data
## Week 3 Project

#setwd("/home/tom/scripts/gnuR/coursera/get_data/project")
if(!file.exists('data')){
    dir.create('data')
}

file_url <- 
    paste("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles",
          "%2FUCI%20HAR%20Dataset.zip", sep="")
download.file(file_url, destfile = 
                  "./data/Human_Activity_Recognition_Using_Smartphones.zip", 
              method="curl")
unzip("./data/Human_Activity_Recognition_Using_Smartphones.zip", 
      exdir="./data")

# IMPORT DATA
Xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header=FALSE)
ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header=FALSE)
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

Xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header=FALSE)
ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header=FALSE)
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

features <- read.table("./data/UCI HAR Dataset/features.txt")
features_indices <- sort(c(grep("mean", features$V2),
                               grep("std", features$V2)))

activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

# ORGANIZE DATA
subject <- rbind(subject_test, subject_train)
activity_vals <- rbind(ytest, ytrain)
activity <- factor(activity_vals[ ,1], labels = activity_labels[ , 2])
X <- data.frame(rbind(Xtest[, features_indices], Xtrain[, features_indices]))
names(X) <- features[features_indices, 2]
X <- cbind(subject, activity, X)
names(X)[1] <- "subject"

# free memory
rm(Xtrain, Xtest, subject_test, subject_train, ytest, ytrain)

# calculate means for each subject/activity pair
X_means <- aggregate(x=X[, 3:dim(X)[2]], by = list(X$subject, X$activity), 
                     FUN = "mean")
names(X_means)[1:2] <- c("subject", "activity")

# OUTPUT
write.table(X_means, file="subject_activity_means.txt")

