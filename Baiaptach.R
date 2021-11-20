#-------------------------------
data <- read.csv("https://raw.githubusercontent.com/guru99-edu/R-Programming/master/test.csv")

data$NameVariable <- gsub(".*, | .{1}.*", "", data$Name)

#ABC -> A1C
#-----------------------------
data <- read.csv("https://raw.githubusercontent.com/guru99-edu/R-Programming/master/test.csv")

library(stringr)
data$NameVariable <- str_trim(str_sub(str_extract(data$Name, ",[^\\.]*"), 2))

str_extract(data$Name, ",[^\\.]*")
str_sub(str_extract(data$Name, ",[^\\.]*"))