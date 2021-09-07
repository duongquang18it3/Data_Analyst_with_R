#test function
.libPaths() 
#check library
library()
search()
#install new package
#install.packages("Package Name")  
install.packages("XML")

#load package

library("XML")  

#R syntax
#My First program in R programming  
string <-"Hello World!"  
print(string) 
#assigment
#gán 
#cách 1 (recommend)
bien <- 10
bien
#cách 2
b = 4.5
b
#cách 3
10 -> y
y

#=========================================
#Logical Data type  
variable_logical<- TRUE  
cat(variable_logical,"\n")  
cat("The data type of variable_logical is ",class(variable_logical),"\n\n")  

#Numeric Data type  
variable_numeric<- 3532  
cat(variable_numeric,"\n")     
cat("The data type of variable_numeric is ",class(variable_numeric),"\n\n")  

#Integer Data type  
variable_integer<- 133L  
cat(variable_integer,"\n")   
cat("The data type of variable_integer is ",class(variable_integer),"\n\n")  

#Complex Data type  
variable_complex<- 3+2i  
cat(variable_complex,"\n")  
cat("The data type of variable_complex is ",class(variable_complex),"\n\n")  

#Character Data type  
variable_char<- "Learning r programming"  
cat(variable_char,"\n")  
cat("The data type of variable_char is ",class(variable_char),"\n\n")  

#Raw Data type  
variable_raw<- charToRaw("Learning r programming")  
cat(variable_raw,"\n")  
cat("The data type of variable_char is ",class(variable_raw),"\n\n") 

# Assignment using equal operator.  
variable.1 = 124             

# Assignment using leftward operator.  
variable.2 <- "Learn R Programming"     

# Assignment using rightward operator.     
133L -> variable.3             

print(variable.1)  
cat ("variable.1 is ", variable.1 ,"\n")  
cat ("variable.2 is ", variable.2 ,"\n")  
cat ("variable.3 is ", variable.3 ,"\n")  

variable_y<- 124  
cat("The data type of variable_y is ",class(variable_y),"\n")  

variable_y<- "Learn R Programming"     
cat("  Now the data type of variable_y is ",class(variable_y),"\n")  

variable_y<- 133L   
cat("   Next the data type of variable_y becomes ",class(variable_y),"\n") 

a<-11  
if(a<15)  
print("I am lesser than 15")  
a<-22  
if(a<20){  
  cat("I am lesser than 20")  
}else{   
  cat("I am larger than 20")  
}

x <- 1  
repeat {  
  cat(x)  
  x = x+1  
  if (x == 6){  
    break  
  }  
}
#while
a <- 20  
while(a!=0){  
  cat(a)  
  a = a-2  
}

#function
new.function<- function(n) {  
  for(i in 1:n) {  
    a <- i^2  
    print(a)  
  }  
}  
new.function(6)  
#next
v <- LETTERS[1:6]  
for ( i in v) {  
  if (i == "D") {  
    next  
  }  
  print(i)  
}