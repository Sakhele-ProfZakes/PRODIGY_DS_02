install.packages("tidyverse")
install.packages("GGally")

library(tidyverse)
library(GGally)

train_data = read.csv("train.csv")

#Data Cleaning
#Checking the structure and getting a summary of the train_data
glimpse(train_data)
summary(train_data)

#Identifying and filling missing values in the data
train_data$Age[is.na(train_data$Age)] = median(train_data$Age, na.rm = TRUE)
train_data$Embarked[is.na(train_data$Embarked)] = mode(train_data$Embarked)

#Converting categorical variables to factors
train_data$Sex = as.factor(train_data$Sex)
train_data$Embarked = as.factor(train_data$Embarked)

#Removing any duplicates in the data
train_data = train_data %>% distinct()

#Performing EDA
#Univariate Analysis
ggplot(train_data, aes(x=Age)) + geom_histogram(binwidth = 5) + theme_minimal()
ggplot(train_data, aes(x=factor(Survived))) + geom_bar() + theme_minimal()

#Bivariate Analysis
ggplot(train_data, aes(x = factor(Sex), y = Survived)) + geom_bar(stat = "identity")
ggplot(train_data, aes(x = factor(Pclass), y = Age)) + geom_boxplot()
ggcorr(train_data)

#Multivariate Analysis
ggpairs(train_data, columns = c("Survived", "Pclass", "Age", "Fare", "Sex"))
