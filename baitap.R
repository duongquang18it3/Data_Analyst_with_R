df1 <- read.csv('https://raw.githubusercontent.com/guru99-edu/R-Programming/master/test.csv')
View(df1)
df2 <- read.csv('https://raw.githubusercontent.com/guru99-edu/R-Programming/master/train.csv')
View(df2)
df3 <- select(df2, -Survived)
df3 <- df2[,-2]

dim(df3)
names(df3)
library("ggplot2")
#df1 and df3 same
R.version

full <- rbind(df1,df3)
View(full)
dim(full)
library("dplyr")

#---------HOme work 14/09 : Split Mr and Mrs in Name colum.-------------
tachCot <- full$Name
ketQua <- cbind(full, tachCot)

for (i in 1:length(ketQua$Name)) {
  ketQua$tachCot[i] <- unlist(strsplit(
                              unlist(strsplit
                                  (ketQua$Name[i], ", "))[2], ". "))[1]
}
View(full)
View(ketQua)
