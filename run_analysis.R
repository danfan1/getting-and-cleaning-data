subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

# 1. Merges the training and the test sets to create one data set.
data_test <- cbind(subject_test, y_test, X_test)
data_train <- cbind(subject_train, y_train, X_train)
data <- rbind(data_test, data_train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("UCI HAR Dataset/features.txt")
names(features) <- c("index", "feature_name")
mean_std_indices <- grep("mean|std", features$feature_name)
indices_to_extact <- c(1, 2, mean_std_indices + 2)
data <- data[, indices_to_extact]

# 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
matching_labels <- merge(data[,2], activity_labels, by.x = 1, by.y = 1, all = TRUE)
data[, 2] <- matching_labels[, 2]

# 4. Appropriately labels the data set with descriptive variable names.
colnames(data)[1:2] <- c("subject", "activity")
feature_names <- features$feature_name[mean_std_indices]
feature_names <- gsub("-", ".", feature_names)
feature_names <- sub("^t([A-Z])", "time\\1", feature_names)
feature_names <- sub("^f([A-Z])", "freq\\1", feature_names)
colnames(data)[-(1:2)] <- feature_names

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
data_mean <-
  data %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))
write.table(data_mean, "data_mean.txt", row.names = FALSE)
