#read data/dataset in package
data()
iris
CO2
Orange

d<- Orange
dim(d)

str(d)
#xem ten
names(d)
#xem du lieu
View(d)
#Edit data
edit()
rm(list = ls())

#read data on PC
#Create folder dataset
df1 <- read.csv("E:\\Data\\OnlineRetail.csv")
View(df1)
dim(df1)
names(df1)
str(df1)

#option read text file
df2 <- read.table("E:\\Data\\Adult.txt")
View(df2)
dim(df2)

df3 <- read.csv("E:\\Data\\data.csv")
View(df1)
dim(df1)
names(df1)
str(df1)

#N???u có tiêu d??? là T và khong là F(Fale)
df4 <- read.table("E:\\Data\\Adult.txt", sep = ",", header = T)
View(df4)
dim(df4)

#Doc du lieu excel
df5 <- read.csv("E:\\Data\\Diem1.csv")
View(df5)
rm(list = ls())

#Doc du lieu truc ti???p t??? Internet
#using data.table's fread()
install.packages("data.table")
library(data.table)

df7 <- fread('http://www.stats.ox.ac.uk/pub/datasets/csb/ch11b.dat')
View(df7)


df8 <- read.csv('https://raw.githubusercontent.com/PacktPublishing/Big-Data-Analytics-with-Hadoop-3/master/Chapter04/OnlineRetail.csv')
View(df8)
dim(df2)

mydat <- fread('http://www.stats.ox.ac.uk/pub/datasets/csb/ch11b.dat')
head(mydat)

#Viet file csv 
write.csv

#trich mot so bien can thiet
install.packages("dplyr")
library(dplyr)
df9 <- read.csv("https://raw.githubusercontent.com/PacktPublishing/Big-Data-Analytics-with-Hadoop-3/master/Chapter04/OnlineRetail.csv")
View(df9)
rm(list = ls())
names(df9)
sl1 <- select(df9, Quantity, UnitPrice, Country)

sl2 <- select(df9, -Description, -InvoiceNo)
#luu lai cai bo da chon
write.csv(sl2, file = "E:/Data/sel2.csv")

ft1 <- filter(sl1, UnitPrice >= 4.25)







