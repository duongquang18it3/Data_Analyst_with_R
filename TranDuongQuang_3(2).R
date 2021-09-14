df1 <- read.csv('https://raw.githubusercontent.com/guru99-edu/R-Programming/master/test.csv')
View(d1)
df2 <- read.csv('https://raw.githubusercontent.com/guru99-edu/R-Programming/master/train.csv')
View(d2)
df3 <- select(df2, -Survived)
df3 <- d2[,-2]

dim(df3)
names(df3)

#df1 and df3 same
R.version
ori <- rbin(df1, df3)
View(ori)
edit(ori)
full <- rbind(df1,df3)
dim(full)
library("dplyr")
#Tinh trung binh

mean_d4_age <- mean(d4$Age, na.rm = TRUE)

#total vlue = na 
sum(is.na(ori))

#Tong gia tri thieu
colnames(ori)[ apply(ori, 2, anyNA)]

#delete all NA
df_notNA <- na.omit(ori)

mean(df_notNA$Age)
dim(df_notNA)
dim(ori)
colnames(df_notNA)[apply (df_notNA, 2, anyNa)]

dim(no_na)
dim(full)

#Dung ham khac (khong co du ulieu sai)
s <- ori[complete.cases(ori),]
dim(s)
is.na(ori)

# Sample random rows is dataframe

t1 <- ori[sample(nrow(ori), 15),]
names(t1)
dim(t1)
# rbin two data frame in R/ join 2 dataset
kq <- rbind(ori, t1)
dim(kq)

#get 3 colum (1:3) of dataframe df2
t2 <- ori[1:3]
t3 <- select(ori, "Name", "Sex")
dim(t3)
names(ori)
names(t2)
dim(t2)
name(t2)

#rename all variable/columns
colnames(t2) <- c("name1", "name2", "name3")
dim(t2)
names(t2)
dim(full)

#noi theo chieu ngang

kq2 <- cbind(ori, t2)
dim(kq2)
names(kq2)
edit(kq2)

# Remove duplicate rows of the datanframe,
q1 <- distinct(full)
dim(q1)
full%>% distinct()%>%sumarise()
str(ori)

#remove duplicate rows of the dataframe using NAME variable
distinct(ori,PassengerId, . keep_all = TRUE)
kq %>% distinct(PassengerId, . keep_all = TRUE)

## Apply unique function for data frame in R
unique(ori)

## unique value of the colum in R dataframe 
 r,-ori[!duplicated(ori),]
 dim(r)
 dim(t1)
 
 #Return the colum names containing missing observations'
 list_na <- colnames(df)[apply(df, 2, anyNA)]
 
 list_na
 sum(is.na(df$Age))
 sum(is.na(df$Fare))
 dim(df)
 library(dplyr)
 
 #Exclue the missing observations
 
 
 
 #row have missing value
 sum(completa.cases(ori))
 dim(ori)
 ?str()
 ?dim()
 
 #row no have missing value
 sum(!complete.cases(ori))
 which(is.na(full))
 
 #-----------------------------------------
 ### Replace misss value with zero
 t <- df
 edit(ori)
 
 tam <- ori
 mean(tam$Age, na.rm = TRUE)
 ori$Age[is.na(tam$Age)] <- mean(tam$Age, na.rm = TRUE)
 
 ## repalce missing value of column with mean
 tbAge <- mean(ori$Age, na.rm = TRUE)
 toAge <- sum(ori$Age, na.rm =TRUE)
 toAge
 tbAge
 test <-ori
 edit(test)
 
 #convert one variable to factor
 full$Pclass <-as.factor(ori$Pclass)
 str(ori)
 
 #Lay Cai Mr, Mrs dat vao cot moi
 #Tao ra mot cai cot/bien moi co ten NewVariable
 # trong dataset
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 




















