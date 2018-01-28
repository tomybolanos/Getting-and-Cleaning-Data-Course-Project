
## About source data
As sourse data for work was used Human Activity Recognition Using Smartphones Data Set. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## About R script
 The script contains two funciton : 
    - downloadFiles : Downloads the files to the working directory/
    - process_ds : process the test and training set.  The output  us the file  `ds_TidySet.txt`,  uploaded in the course project's form.



## About variables:   
* `ds_x_train`, `ds_y_train`, `ds_x_test`, `ds_y_test`, `ds_subj_train` and `ds_subj_test` contain the data from the downloaded  files.
* `ds_merged_train`, `ds_merged_test` and `combinedSet` merge the previous datasets.
* `ds_newNames` contains the correct names for the `combinedSet` dataset, which are applied to the column names stored in


 