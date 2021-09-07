x <- 30
if(is.integer(x)){
  #print( x + "X is Integer")
  cat(x, 'is an Integer')
}

x <- c("What","is","truth")
if("Truth" %in% x){
  print("Truth is found the fisrt time")
} else if ("truth" %in% x){
  print("Truth is found the second time")
} else{
  print("No truth found")
}

x <- switch (2,"fisrt","second", "third","fourth")
print(x)
#-------loop------
v <- c("hello","loop")
d <- 3
repeat {
  print(v)
  d <- d+1
  if( d > 5){
    break
  }
}
#-------while loop ------
v <-c("Hello","while loop","addtion")
cnt <-2
while (cnt <7){
  print(v)
  cnt = cnt +1
}

#---------for loop -----
v <- LETTERS[1:10]
for (i in v){
  print(i)
}

#------function-----------
a <- "Hello"
b <- "data analysis"
c <- "with R"
print(paste(a,b,c))
print(paste(a,b,c, sep = "-"))
print(paste(a,b,c, sep ="", collapse = ""))

#-----format functuion -----

#----nachr() function---
result <- nchar("Count the number of characters")
print(result)

#------touper() & tolower()----- chu thuong chu in
#Changing to Upper case.
result <- toupper("Changing To Upper")
print(result)
#Changing to lower case.
result <- tolower("Changing To Lower")
print(result)
#-----trich ra mot phan cua chuoi substring() function----
#----syntax ----substring(x,first, last)
result <- substring("Extract string",2,4)
print(result)

#----- Multiple Element Vector ----
#Creating a sequence from 5 to 13
v <- 5:13
print(v)
#Creating a sequence from 6.6 to 12.6
v <- 6.6:12.6
print(v)
# If the final element  specified does not belong to the 
# squence the it is discarded
v <- 3.8:11.4
print(v)
# Using sequence (Seq.) operator
#Create vector with element form 5 to 9 incrementing by 0.4
print(seq(1,10, by = 0.25))

# C() function----character
s <-c('apple','red',5,TRUE)
print(s)

#-------- Accessing Vector Elements
# using indexing (ch??? m???c) 
#----- using position/index
t <-c("Sun","Mon","Tue","Wed","Thur","Fri","Sat")
t[2]
u <-t[c(2,3,6)]
print(u)
v <- t[c(TRUE, FALSE,FALSE,TRUE, FALSE,FALSE,TRUE, FALSE,FALSE)]
print(v)
#----- Tinh toan so hoc tren vector--- Vector arithmetic
#Crerate two vectors.
v1 <- c(3,8,6,4,0,11)
v2 <- c(4,5,6,7,6,6)
#vector addtion
add.result <- v1+v2
print(add.result)
# Vector Element Recycling
v1 <- c(3,8,4,5,0,11)
v2 <-c(4,11)
add.result <- v1+v2
print(add.result)

#Vector Element Sorting using sort() function
#Creating a List
#Create a list containing strings, numbers, vectors, an da logiacl
#values.
list_data <- list("red","green",c(21,32,11), TRUE, 51.23,119.1)
print(list_data)
#Accessing List Elements
#create list containing a vector , a matrix and a list
list_data <- list(c("Jan","Ferb","Mar"), matrix(c(3,5,6,7),nrow = 2),
                  list("green,12.3"))
#Gie names to the elements in the list.
names(list_data) <- c("lst Quarter","A_matrix", "A inner List")

#Access the fisrt element of the list.
print(list_data[1])
#Access the thrid element. As it is also a list, all
#its elements will be printer.
print(list_data[3])
#Access the list element using the name of the element
print(list_data$A_matrix)


