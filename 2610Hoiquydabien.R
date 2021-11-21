library(ggplot2)
library(dplyr)
mydata <- read.csv("E:\\Data\\data3.csv")
View(mydata)
dim(mydata)
names(mydata)
attach(mydata)
model <- lm(y~x1+x2+x3+x4+x5+x6+x7, data=mydata)
summary(model)

modelx6 <-lm(y~x6, data=mydata)
summary(modelx6)
pairs(mydata)
model07 <-lm(y~., data=mydata)
summary(model07)

step(mydata)

coefficient
y = 2.526460 + 0.018522.x6 + 2.185753.x7