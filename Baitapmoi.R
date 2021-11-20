rm(list = ls())
PATH <- "https://raw.githubusercontent.com/guru99-edu/R-Programming/master/test.csv"
df <- read.csv(PATH)

df$vfactor <- factor(df$Pclass)
table(df$vfactor)
barplot(table(df$vfactor))
#Tao bien moi
df$New22 <- (df$Age*2)

df$Ngoi <- gsub(".*, | .{1}.*", "", df$Name)
View(df)


library("dplyr")
df %>%
  mutate(new3 = Age*2/4) %>%
  head(6)
View(df)

str(df)

range(df$Age, na.rm = TRUE) 

c <- cut (df$Age,4)
c
cc <- cut (df$Age,c(-Inf, 20, 40, 60, Inf))
cc 

# dung ham cut phan nhom du lieu
s <- df %>%
  mutate(newAge = cut(df$Age,4)) %>%
  head(6)
str(s)

tam1 <- df %>%
  mutate(new3 = cut(df$Age,4))
 head(6)

 #------------------------
 # Ve bieu do
 # 
 
 #Scatter Plot Bieu do tan sa
 View(mtcars)
 plot(mtcars$wt, mtcars$drat)

 str(mtcars)
 install.packages('ggplot2')
 library(ggplot2)
 ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
 
 ggplot(data = NULL, aes(x = mtcars$wt, y = mtcars$mpg)) + geom_point()

 plot(pressure$temperature, pressure$pressure, type = "l")

 plot(pressure$temperature, pressure$pressure, type = "l")
 points(pressure$temperature, pressure$pressure)
 
 lines(pressure$temperature, pressure$pressure/2, col = "red")
 points(pressure$temperature, pressure$pressure/2, col = "blue")

 ggplot(pressure, aes(x = temperature, y = pressure)) +  geom_line()
 
 ggplot(pressure, aes(x = temperature, y = pressure)) + geom_line() +  geom_point() # With points added

#
 BOD <- BOD1  # Make a copy of the data
 BOD1$Time <- factor(BOD1$Time)
 
 str(BOD)
 ggplot(1, aes(x = Time, y = demand, group = 1)) + geom_line()
 dev.off()
 # Map supp to colour

 tg <- ToothGrowth 
 View(ToothGrowth)
 ggplot(tg, aes(x = dose, y = len, colour = supp)) +  geom_line()
 # Map supp to linetype 
 ggplot(tg, aes(x = dose, y = len, linetype = supp)) +  geom_line()
 # Map supp to linetype and colour
 ggplot(tg, aes(x = dose, y = len, linetype = supp, colour = supp)) + geom_line()
 #solution ?
 
 #Bar Graph
 
 barplot(BOD$demand, names.arg = BOD$Time)
 
 # dung table 
 View(mtcars)
 str(mtcars)
 dim(mtcars)
 # table tu dong dem so luong tren mot loai
 table(mtcars$cyl)
 range(mtcars$cyl)
 barplot(table(mtcars$cyl))
 
 
 