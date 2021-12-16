install.packages("plyr")
install.packages("lubridate")
install.packages("tidyr")
install.packages("ggmap")
install.packages("viridis")
install.packages("plotly")
library(plyr)
library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)
library(ggmap)
library(viridis)
library(plotly)

############# 1. Dataset tong hop cac cuoc goi khan cap den 911 tai My #########
mydata <- read.csv("E:\\Data\\911.csv")
View(mydata)
dim(mydata)
names(mydata)
## 2. Giai thich cac bien va cac tu Tieng anh trong dataset
# EMS (Enhanced 911 Service) : Dich vu y te khan cap (ngat xiu, chan thuong, cao huyet ap, tim mach)
# Traffic: giao thon (tai nan)
# Fire: hoa hoan, chay no, ro ri khi gas

# "lat": (latitude) - kinh do
# "lng": (longitude) - vi do
# "desc": (description) - mo ta noi dung khan cap
# "zip": (zip code) - ma vung (khu vuc)
# "title": noi dung tieu de khan cap
# "Type": loai khan cap chinh
# "SubType: loai khan cap phu
# "timeStamp": moc thoi gian 
# "twp": (township) - thi tran, thanh pho nho
# "addr": (address) - dia chi 
# "e" (Enhanced 911 Service) - phim so dieu huong cuoc goi
# "Date": ngay thang nam duoc tach tu timeStamp
# "Weekday": cac thu trong tuan duoc 
# "Year" : nam
# "Month": thang
# "Day": day
# "Hour": gio
str(mydata)

summary(mydata)

#################### 3. Tien xu ly du lieu ################################
mydata$zip <- factor(mydata$zip)

# Loai bo cot "e" khong can thiet tai vi tri cot thu 9
mydata <- mydata[,-9]

# Dinh dang form thoi gian cho cot "timeStamp"
mydata$timeStamp <- as.POSIXct(mydata$timeStamp)

# Tao cot "Date " nam - thang - ngay tach tu cot timeStamp
mydata$Date <- as.Date(mydata$timeStamp)

# Tach phan loai khan cap cu the tu cot "Type" tao thanh cot moi "SubType" 
mydata <- separate(mydata, col = title, into = c("Type", "SubType"), sep = ":")

# Loai bo dau "-" chua trong "Subtype"
mydata$SubType <- gsub(" -", "", mydata$SubType)

# Tao cot "Year" tu cot "timeStamp"
mydata$Year <- year(mydata$timeStamp)
# Tao cot "Month" tu cot "timeStamp"
mydata$Month <- month(mydata$timeStamp)

# Tao cot "Day" tu cot "timeStamp"
mydata$Day <- day(mydata$timeStamp)

# Tao cot "Hour" tu cot "timeStamp"
mydata$Hour <- hour(mydata$timeStamp)

# Tao cot "Weekday" tu cot "timeStamp"
mydata$Weekday <- weekdays(mydata$timeStamp)

# Chuyen cac tri ve gia tri vector
mydata$Year <- factor(mydata$Year)
mydata$Month <- factor(mydata$Month)
mydata$Day <- factor(mydata$Day)
mydata$Hour <- factor(mydata$Hour)
mydata$Weekday <- factor(mydata$Weekday)

# Loai bo cot "timeStamp" khong can thiet sau khi da tach gio, thu, ngay, thang, nam tu no
mydata <- mydata[,-7]
dim(mydata)
sum(is.na(mydata$zip))



############ 4. Dat cau hoi phan tich (CH), bieu do (BD) va giai thich (GT) ########
### CH-1: Tong so luong cuoc goi theo thoi gian nhu the nao ?  
### CH-2: So luong cuoc goi phan theo loai trong cac khoang thoi gian nhu the nao ?
### CH-3: Co bao nhieu cuoc goi hang thang vao nam 2016 ?
### CH-4: Co bao nhieu cuoc goi hang ngay trong cac thang vao nam 2016 ?  
### CH-5: Co bao nhieu cuoc goi hang ngay trong tuan vao nam 2016 ?
### CH-6: Co bao nhieu cuoc goi dua tren loai (EMS, Traffic, Fire) ?
### CH-7: Phan tram tu cac loai cuoc goi nhu the nao ?
### CH-8: Tong so cac cuoc goi trong Top 10 cac cuoc khoi khan cap den 911 cu the nhu the nao ?
### CH-9: Phan tram cac cuoc goi khan cap cu the nhu the nao ?
### CH-10: So luong cuoc goi khan cap cu the cua loai EMS nhu the nao ?
### CH-11 Phan tram so luong cuoc goi khan cap cu the cua loai EMS nhu the nao ?
### CH-12: So luong cuoc goi khan cap cu the cua loai Fire nhu the nao ?
### CH-13: Phan tram cuoc goi khan cap cu the cua loai Fire nhu the nao ?
### CH-14: So luong cuoc goi khan cap cu the cua loai Trafic nhu the nao ?
### CH-15: Phan tram cuoc goi khan cap cu the cua loai Trafic nhu the nao ?
### CH-16: Top 10 Khu vuc Zip code nao co so luong cuoc goi nhu the nao ?
### CH-17: Top 10 Khu vuc Zip code nao co phan tram so luong cuoc goi nhu the nao ?
### CH-18: Top 10 nhung thi tran, thanh pho nao co so cuoc goi nhieu nhat ?
### Ch-19: Phan tram top 10 nhung thi tran, thanh pho nhu the nao ?
### CH-20: Su tuong quan giua cac Ngay trong thang va Gio cua cac cuoc goi khan cap 911
### CH-21: Su tuong quan giua cac Ngay va Thang cua cac cuoc goi khan cap 911 ?
### CH-22: Cac loai cuoc goi khan cap khac nhau nhu the o cac thi tran, thanh pho ?
### CH-23: Top 5 loai cuoc goi cu the khac nhau nhu the nao trong Top 10 tri tran, thanh pho ?
### CH-24: Tai nan giao thong theo gio cua cac loai cuoc goi nhu the nao ?
### CH-25: Tai nan giao thong theo gio cua cac ngay nhu the nao ?
### CH-26: Cac cuoc goi khan cap Tim mach nhu the nao ?


### CH-1: Tong so luong cuoc goi theo thoi gian nhu the nao ?  
by_date <- mydata %>% group_by(Date) %>% summarise(Total = n())

head(by_date)

# BD-1
ggplot(by_date, aes(Date, Total)) + geom_line(color = "blue", size = 1)

### CH-2: So luong cuoc goi phan theo loai trong cac khoang thoi gian nhu the nao ?
by_date_type <- mydata %>% group_by(Date, Type) %>% summarise(Total = n())

by_date_type$Type <- factor(by_date_type$Type)

# BD-2
ggplot(by_date_type, aes(Date, Total)) + geom_line( aes(color = Type), size = 0.6)

ggplot(by_date_type, aes(Date, Total)) + geom_line( aes(color = Type), size = 0.6) + facet_wrap(~Type) + theme(legend.position="none")

# GT: Chi co vai cuoc goi Giao thong vuot qua EMS
# Chi rieng trong ngay 23/01/2016 so cuoc goi Giao thong da tang len 3-4 la

### CH-3: Co bao nhieu cuoc goi hang thang vao nam 2016 ?
table(mydata$Year)

table(mydata[mydata$Year==2016,]$Month)

# BD-3
ggplot(mydata[mydata$Year==2016,], aes(Month, fill = Month)) + geom_bar() + theme(legend.position = "none") + ggtitle("911 Emergency Calls for 2016 - Monthly ")

### CH-4: Co bao nhieu cuoc goi hang ngay trong cac thang vao nam 2016 ?  
table(mydata[mydata$Year==2016,]$Hour)

# BD-4 
ggplot(mydata, aes(Hour, fill = Hour)) + geom_bar() + theme(legend.position = "none") + ggtitle("911 Emergency Calls - Hourly")

### CH-5: Co bao nhieu cuoc goi hang ngay trong tuan vao nam 2016 ?
table(mydata[mydata$Year==2016,]$Weekday)

# BD-5
ggplot(mydata, aes(Weekday, fill = Weekday)) + geom_bar() + theme(legend.position = "none") + ggtitle("911 Emergency Calls - Weekday")


### CH-6: Co bao nhieu cuoc goi dua tren loai (EMS, Traffic, Fire) ?
table(mydata$Type)

# BD-6
ggplot(mydata, aes(Type, fill = Type)) + geom_bar() + theme(legend.position = "none") + ggtitle("911 Emergency Calls for 2016 - Type")

### CH-7: Phan tram tu cac loai cuoc goi nhu the nao ?
prop.table(table(mydata$Type))

ggplot(as.data.frame(prop.table(table(mydata$Type))), aes(Var1, Freq, fill = Var1)) + geom_bar(stat = "identity") + theme(legend.position = "none") + ggtitle("911 Emergency Calls for 2016 - Type Percentage") + xlab("Type") + ylab("Percentage of Calls")

## GT-7: Gan 50% cac cuoc goi lien quan den EMS va xep thu hai la giao thong

### CH-8: Tong so cac cuoc goi trong Top 10 cac cuoc khoi khan cap den 911 cu the nhu the nao ?
top_subtypes <- as.data.frame(table(mydata$SubType))
top_subtypes <- top_subtypes[order(-top_subtypes$Freq),]
top10_subtypes <- top_subtypes[1:10,]

### CH-9: Phan tram cac cuoc goi khan cap cu the nhu the nao ?
top10_subtypes$Perc <- top10_subtypes$Freq/sum(top_subtypes$Freq) * 100
top10_subtypes

# BD-8
ggplot(top10_subtypes, aes(reorder(Var1, Freq), Freq, fill = Var1)) + geom_bar(stat = "identity") + theme(legend.position = "none") + ggtitle("911 Emergency Calls") + xlab("Subtype") + ylab("Number of 911 Calls")  + coord_flip()

# BD-9
ggplot(top10_subtypes, aes(reorder(Var1, Perc), Perc, fill = Var1)) + geom_bar(stat = "identity") + theme(legend.position = "none") + ggtitle("911 Emergency Calls") + xlab("Subtype") + ylab("Percentage of 911 Calls")  + coord_flip()


gettop10subtypes <- function(type) {
  mytype <- subset(mydata, Type == type)
  mytype$SubType <- factor(mytype$SubType)
  mytype_subtypes <- as.data.frame(table(mytype$SubType))
  mytype_subtypes <- mytype_subtypes[order(-mytype_subtypes$Freq),]
  top10_types_substype <- mytype_subtypes[1:10,]
  top10_types_substype$Perc <- top10_types_substype$Freq/sum(mytype_subtypes$Freq) * 100
  return(top10_types_substype)
}

### CH-10: So luong cuoc goi khan cap cu the cua loai EMS nhu the nao ?
gettop10subtypes("EMS")
# BD-10
ggplot(gettop10subtypes("EMS"), aes(reorder(Var1, Freq), Freq, fill = Var1)) + geom_bar(stat = "identity") + theme(legend.position = "none") + ggtitle("911 Emergency Calls for 2016") + xlab("Subtype") + ylab("Number of EMS Calls")  + coord_flip()
### CH-11 Phan tram so luong cuoc goi khan cap cu the cua loai EMS nhu the nao ?
# BD-11
ggplot(gettop10subtypes("EMS"), aes(reorder(Var1, Perc), Perc, fill = Var1)) + geom_bar(stat = "identity") + theme(legend.position = "none") + ggtitle("911 Emergency Calls for 2016") + xlab("Subtype") + ylab("Percentage of EMS Calls")  + coord_flip()

### CH-12: So luong cuoc goi khan cap cu the cua loai Fire nhu the nao ?
gettop10subtypes("Fire")

# BD-12
ggplot(gettop10subtypes("Fire"), aes(reorder(Var1, Freq), Freq, fill = Var1)) + geom_bar(stat = "identity") + theme(legend.position = "none") + ggtitle("911 Emergency Calls for 2016 ") + xlab("Subtype") + ylab("Number of Fire Calls")  + coord_flip()
### CH-13: Phan tram cuoc goi khan cap cu the cua loai Fire nhu the nao ?
# BD-13
ggplot(gettop10subtypes("Fire"), aes(reorder(Var1, Perc), Perc, fill = Var1)) + geom_bar(stat = "identity") + theme(legend.position = "none") + ggtitle("911 Emergency Calls for 2016 ") + xlab("Subtype") + ylab("Percentage of Fire Calls")  + coord_flip()

### CH-14: So luong cuoc goi khan cap cu the cua loai Trafic nhu the nao ?
gettop10subtypes("Traffic")[1:7,]

# BD-14
ggplot(gettop10subtypes("Traffic")[1:7,], aes(reorder(Var1, Freq), Freq, fill = Var1)) + geom_bar(stat = "identity") + theme(legend.position = "none") + ggtitle("911 Emergency Calls for 2016") + xlab("Subtype") + ylab("Number of Traffic Calls")  + coord_flip()

### CH-15: Phan tram cuoc goi khan cap cu the cua loai Trafic nhu the nao ?
# BD-15
ggplot(gettop10subtypes("Traffic")[1:7,], aes(reorder(Var1, Perc), Perc, fill = Var1)) + geom_bar(stat = "identity") + theme(legend.position = "none") + ggtitle("911 Emergency Calls for 2016 ") + xlab("Subtype") + ylab("Percentage of Traffic Calls")  + coord_flip()


### CH-16: Top 10 Khu vuc Zip code nao co so luong cuoc goi nhu the nao ?
top_zip <- as.data.frame(table(mydata$zip))
top_zip <- top_zip[order(-top_zip$Freq),]
top10_zip <- top_zip[1:10,]

names(top10_zip) <- c("Zip", "Total")

### CH-17: Top 10 Khu vuc Zip code nao co phan tram so luong cuoc goi nhu the nao ?
top10_zip$Perc <- top10_zip$Total/sum(top_zip$Freq) * 100
top10_zip$Zip <- factor(top10_zip$Zip)

top10_zip

# BD-16
ggplot(top10_zip, aes(reorder(Zip, -Total), Total, fill = Zip)) + geom_bar(stat = "identity") + theme(legend.position = "none") + ggtitle("911 Emergency Calls for 2016 - Top 10 Zip ") + xlab("Zip codes with most number of calls")

# BD-17
ggplot(top10_zip, aes(reorder(Zip, -Perc), Perc, fill = Zip)) + geom_bar(stat = "identity") + theme(legend.position = "none") + ggtitle("911 Emergency Calls for 2016 - Top 10 Zip ") + xlab("Zip codes  Percentage of calls")


### CH-18: Top 10 nhung thi tran, thanh pho nao co so cuoc goi nhieu nhat ?

length(unique(mydata$twp))

top_twp <- as.data.frame(table(mydata$twp))
top_twp <- top_twp[order(-top_twp$Freq),]
top10_twp <- top_twp[1:10,]

names(top10_twp) <- c("Twp", "Total")

### Ch-19: Phan tram top 10 nhung thi tran, thanh pho nhu the nao ?
top10_twp$Perc <- top10_twp$Total/sum(top_twp$Freq) * 100
top10_twp$Twp <- factor(top10_twp$Twp)

top10_twp

# BD-18
ggplot(top10_twp, aes(reorder(Twp, -Total), Total, fill = Twp)) + geom_bar(stat = "identity") + theme(legend.position = "none") + ggtitle("911 Emergency Calls for 2016 - Top 10 Townships ") + xlab("Townships with most number of calls")  + theme(axis.text.x=element_text(angle=45,hjust=0.5,vjust=0.5)) 

# BD-19
ggplot(top10_twp, aes(reorder(Twp, -Perc), Perc, fill = Twp)) + geom_bar(stat = "identity") + theme(legend.position = "none") + ggtitle("911 Emergency Calls for 2016 - Top 10 Townships ") + xlab("Townships Percentage of calls")  + theme(axis.text.x=element_text(angle=45,hjust=0.5,vjust=0.5)) 


# Su dung bieu do nhiet (HeatMaps)
### CH-20: Su tuong quan giua cac Ngay trong thang va Gio cua cac cuoc goi khan cap 911
## Lay tong so cuoc goi theo Thang va Gio
day_hour <- mydata[mydata$Year == "2016", c("Day", "Hour")] %>% group_by(Day, Hour) %>% summarise(Count = n())
day_hour <- as.data.frame(day_hour)

## Thay doi kieu cua cac bien
day_hour$Day <- as.factor(day_hour$Day)
day_hour$Hour <- as.factor(day_hour$Hour)

## BD-20: Xay dung bieu do nhiet bang ggplot2
ggplot(day_hour, aes(Day, Hour, fill = Count)) + geom_tile(color = "white", size = 0.1) + scale_fill_viridis(name="#Calls") + coord_equal() + labs(title="911 Calls by Day and Hour") 

### CH-21: Su tuong quan giua cac Ngay va Thang cua cac cuoc goi khan cap 911 ?
## Lay tong so cuoc goi theo thang va ngay
month_day <- mydata[mydata$Year == "2016", c("Month", "Day")] %>% group_by(Month, Day) %>% summarise(Count = n())
month_day <- as.data.frame(month_day)

## Thay doi kieu du lieu cho bien
month_day$Month <- as.factor(month_day$Month)
month_day$Day <- as.factor(month_day$Day)

## Thay doi cac cap do cua thang
levels(month_day$Month) <- c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")

## BD-21: Xay dung bieu do tuong quan Ngay va Thang cua cac cuoc goi
ggplot(month_day, aes(Day, Month, fill = Count)) + geom_tile(color = "white", size = 0.1) + scale_fill_viridis(name="#Calls") + coord_equal() + labs(title="911 Calls by Month and Day") 

## Hhau het cac cu goi deu vao ban ngay
## Rieng ngay 23/1 co so cuoc goi cao nhat
## Cac cuoc goi thuong dien ra vao 4-5 gio chieu

### CH-22: Cac loai cuoc goi khan cap khac nhau nhu the o cac thi tran, thanh pho ?
## BD-22
ggplot(mydata[mydata$twp %in% top10_twp$Twp, ], aes(twp, fill = Type )) + geom_bar(position = "dodge")  + theme(axis.text.x=element_text(angle=45,hjust=0.5,vjust=0.5))  + xlab("Township") + ggtitle("Type of calls among Top 10 Townships")

ggplot(mydata[mydata$twp %in% top10_twp$Twp, ], aes(twp, fill = Type)) + geom_bar()  + theme(axis.text.x=element_text(angle=45,hjust=0.5,vjust=0.5))  + xlab("Township") + ggtitle("Type of calls among Top 10 Townships") + facet_wrap(~Type) + theme(legend.position="none")


### CH-23: Top 5 loai cuoc goi cu the khac nhau nhu the nao trong Top 10 tri tran, thanh pho ?
top5 <- top10_subtypes[1:5,]$Var1

sample <- mydata[mydata$twp %in% top10_twp$Twp,]
sample <- sample[sample$SubType %in% top5, ]
dim(sample)

### BD-23
ggplot(sample, aes(twp, fill = SubType )) + geom_bar(position = "dodge")  + theme(axis.text.x=element_text(angle=45,hjust=0.5,vjust=0.5))  + xlab("Township") + ggtitle("Subtype distribution among Top 10 Townships")
##Tai nan giao thong dien ra rat nhieu tai cac thi tran

### CH-24: Tai nan giao thong theo gio cua cac loai cuoc goi nhu the nao ?

vehicle <- mydata[mydata$SubType ==" VEHICLE ACCIDENT", ]

table(vehicle$Type)
# BD-24
ggplot(vehicle, aes(Hour, fill = Type)) + geom_bar(position = "dodge") + ggtitle("Vehicle Accidents by Hours")

### CH-25: Tai nan giao thong theo gio cua cac ngay nhu the nao ?
day_hour <- vehicle[vehicle$Year == "2016", c("Day", "Hour")] %>% group_by(Day, Hour) %>% dplyr::summarise(Count = n())
day_hour <- as.data.frame(day_hour)

day_hour$Day <- as.factor(day_hour$Day)
day_hour$Hour <- as.factor(day_hour$Hour)

# BD-25
ggplot(day_hour, aes(Day, Hour, fill = Count)) + geom_tile(color = "white", size = 0.1) + scale_fill_viridis(name="#Calls") + coord_equal() + labs(title="Vehicle Accident Calls by Day and Hour - 2016")

# Phan lan cac cuoc tai nan giao thong dien ra vao gio cao diem buoi toi

### CH-26: Cac cuoc goi khan cap Tim mach nhu the nao ?
cardiac <- mydata[mydata$SubType ==" CARDIAC EMERGENCY", ]

day_hour <- cardiac[cardiac$Year == "2016", c("Day", "Hour")] %>% group_by(Day, Hour) %>% dplyr::summarise(Count = n())
day_hour <- as.data.frame(day_hour)

day_hour$Day <- as.factor(day_hour$Day)
day_hour$Hour <- as.factor(day_hour$Hour)

# BD-26
ggplot(day_hour, aes(Day, Hour, fill = Count)) + geom_tile(color = "white", size = 0.1) + scale_fill_viridis(name="#Calls") + coord_equal() + labs(title="CARDIAC EMERGENCY Calls by Day and Hour - 2016") 

## Phan lon cac cuoc goi tim mach vao ban ngay
## Chac la do ban ngay lam viec cang thang met moi nen de bi tim mach huyet ap 

#################################### -------- ############################################




