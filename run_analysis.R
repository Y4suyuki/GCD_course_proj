library(plyr)

# read data from files
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
sub_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
sub_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
act_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

# mask for measurements on the mean and standard deviation
feature_seq <- grepl("(std|mean)", features$V2, perl=TRUE)

# extract only the measurements on the mean and standard deviation
new_x_test <- x_test[, feature_seq]
new_x_train <- x_train[, feature_seq]

# merge y and x cols 
test_data <- cbind(y_test, sub_test, new_x_test)
train_data <- cbind(y_train, sub_train, new_x_train)

# merge training and test datasets
data_set <- rbind(test_data, train_data)

# label the data set
names(data_set) <- c("Activity", "Subject", as.character(features$V2[feature_seq]))
data_set$Activity <- as.factor(data_set$Activity)
data_set$Activity <- mapvalues(data_set$Activity, from=levels(data_set$Activity), to = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
# subset data set by each activity and take means
new_data_set <- ddply(data_set, .(Activity, Subject), function(x) {
    colMeans(x[3:dim(x)[2]])
})

write.csv(new_data_set, 'result.txt', row.names=FALSE)
