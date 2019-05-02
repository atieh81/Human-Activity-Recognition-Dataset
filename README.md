# Human-Activity-Recognition-Dataset
Human Activity Recognition dataset

The repo contains files and scrip regarding the project of Getting and Cleaning Data Course.

The output data file stored in file: project_output.txt
The scrip run_analysis.R loads the data set and perform the following activities:
1. Union Training and Testing datasets x,y and subjects using base command "rbind"
2. Assigning names to x datasets variables from "features" file.
3. Selecting all columns of measures average and standard deviation by selecting columns that contains the string mean() and std()
4. Calculates the average of each column grouping by subject and activity 
