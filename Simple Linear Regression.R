library(ggplot2)
library(dplyr)
df <- data.frame(hours=c(1, 2, 4, 5, 5, 6, 6, 7, 8, 10, 11, 11, 12, 12, 14),
score=c(64, 66, 76, 73, 74, 81, 83, 82, 80, 88, 84, 82, 91, 93, 89)) 
View(df)
plot(df$hours, df$score, type = "p" , main = "Bieu do tan xa" ,
     xlab  ="Gio hoc" , ylab= "Diem" , col = "black", pch = 21)
scatter.smooth(hours, score, main='Hours studied vs. Exam Score')
boxplot(df$hours,df$score)
#fit simple linear regression model 
model <- lm(df$hours~df$score)

#view model summary 
summary(model)
  

df1 <- data.frame(Weight=c(140, 155, 159, 179, 192, 200, 212), Height=c(60, 62, 67, 70, 71, 72, 75)) 
model1 <- lm(df1$Height~df1$Weight)
summary(model1)

# y = 32.78301 + 0.20010*x
plot(df1$Weight, df1$Height, type = "p" , main = "Bieu do tan xa" ,xlab  ="Weight" , ylab= "Height" , col = "black", pch = 21)


dt2 <- read.csv("E:\\Data\\dataset1.csv")
plot(dt2$happiness ~ dt2$income, data = dt2 ,main = "Bieu do hoi quy tuyen tinh")
summary(model1)
model1 <- lm(dt2$happiness ~ dt2$income, data = dataset)
abline(model1, col = 'blue')
Viet pt nhap theo dt y = 0.2 + 1.7*x
doc theo duong thang