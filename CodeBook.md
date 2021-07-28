##Description of the data processing
The first section of the run_analysis.R code extracts activity names, subject
codes and feature labels from the respective files.
It also imports the results files that include the data observations (test and 
train sets).

These result files contain multiple columns with different types of signals
collected from a smartphone during 6 different physical activities. Each 
type of measurement contains more than a dozen statistical summaries such as
maximum and minimum.

These tables are connected to the activity names (the activity_labels file shows
how each number is connected to an activity), to the subjects (the subject files
show which subject pertains to which observation) and to the feature labels (the
features file shows what is shown on each column).

The second section manipulates the files, selecting only the columns that show
either mean or standard deviation values, joins both the test and train data
sets and includes labels for columns (based on measurement) and rows (based on
type of activity and the subject). This returns a data frame called dataset1.

The third section creates another data set based on dataset1. It groups the data
based on the activity and the subject and creates a summary with the means for 
each column, returning a data frame called dataset2.