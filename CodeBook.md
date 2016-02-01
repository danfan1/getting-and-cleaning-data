# Codebook
The following are the steps I've taken to generate the data.

1. Download the data set from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Description of the data set is available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
1. Unzip the file and you will find a "UCI HAR Dataset" directory. In that directory you will find some files and subdirectories. Let me explain those files used to generate the data set.
  * **activity_labels.txt** contains a mapping from activity id to acitivy name.
  * **features.txt** contains a list of feature names that correspond to the columns in X_test.txt and X_train.txt.
  * **test/X_test.txt** and **train/X_train.txt** contains the phone accelarator measurements.
  * **test/subject_test.txt** and **train/subject_train.txt** contains the subject ids for each row of test/x_test.txt and train/X_train.txt respectively.
  * **test/y_test.txt** and **train/y_train.txt** contains the activity ids for each row of test/x_test.txt and train/X_train.txt respectively.
1. Read test/subject_test.txt, test/y_test.txt and test/X_test.txt into R and concatenate them by columns, so that the first column contains subject ids, second column contains activity ids, and the remaining columns contains the phone accelerator measurment (which we refer as features).
1. Do the same step with train/subject_train.txt, train/y_train.txt and train/X_train.txt.
1. Combine the test data and train data by rows, so that test data comes before train data.
1. Read the feature names from features.txt. Use them to find the positions of features with "mean" or "std" in the name, then use the positions to keep those "mean" and "std" features in the data.
1. Read activity_labels.txt, and use the activity id to activity name mapping  to convert the activity id colum to an activiy name column.
1. Rename the first column "subject" and second column "activity". For the remaining columns, I use the correspoinding feature names from features.txt. For these feature column names, I replace all "_" to ".", "t" prefix to "time", and "f" prefix to "freq".
1. From this data set, I group by first two columns ("subject" and "activity") and take the mean of the feature columns to generate a new data set.
1. Writes the new data set to a file "data_mean.txt".