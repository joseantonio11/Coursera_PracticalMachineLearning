library(caret)
library(dplyr)
library(rpart)
library(kernlab)
library(reshape2)

set.seed(8675309)

strings.na <- c("NA","#DIV/0!","")
testing <- read.csv("pml-testing.csv", na.strings=strings.na)

# Remove unnecesary columns
cols.to.remove <- grepl("^X|timestamp|window|user_name", names(testing)) #Select which columns to remove
testing  <- testing[, !cols.to.remove] #Removed identified columns
testing <- testing[, colSums(is.na(testing)) == 0]  #Remove columns with N/A

randomForest.model <- readRDS("randomForest-final-model.rds")
randomForest.test <- predict(randomForest.model, newdata = testing)


# Coursera Submission
pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}



answers = randomForest.test
pml_write_files(answers)
