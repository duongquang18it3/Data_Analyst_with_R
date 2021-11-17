# Read data
mydt = read.csv(file = "E:\\Data\\OnlineRetail.csv")
#mydt = read.csv("D:\\Dataset\\MBA.csv")
dim(mydt)
# See first 10 observations
head(mydt, n=10)

# chia du lieu khach hang mua gi
dt <- split(mydt$Description, mydt$CustomerID)

# Tai arules packages
if(!require(arules)) install.packages("arules")

# Chuyen doi du lieu sang cap do giao dich
dt2 = as(dt,"transactions")
summary(dt2)
inspect(dt2)

# Mat hang thuong xuyen xaut hien tan xuat nhieu nhat
itemFrequency(dt2, type = "relative")
itemFrequencyPlot(dt2,topN = 5)

# Du lieu tong hong
rules = apriori(dt2, parameter=list(support=0.005, confidence=0.8))
rules = apriori(dt2, parameter=list(support=0.005, confidence=0.8, minlen = 3))
rules = apriori(dt2, parameter=list(support=0.005, confidence=0.8, maxlen = 4))

#Chuyen doi cai quy tac thanh data frame
rules3 = as(rules, "data.frame")
write(rules, "F:/study/dataset/rule.csv", sep=",")

# Chi hien thi cac quy tac san pham cu the
inspect( subset( rules, subset = rhs %pin% "Product H" ))

# Hien thi top 10 rule
options(digits=2)
inspect(rules[1:10])

# Tom tam rule
summary(rules)

# Sap xep theo muc tang
rules<-sort(rules, by="lift", decreasing=TRUE)

# Bo cac rule ko can thiet
subset.matrix <- is.subset(rules, rules)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- rules[!redundant]
rules<-rules.pruned

#Clean Rules
rules3$rules=gsub("\\{", "", rules3$rules)
rules3$rules=gsub("\\}", "", rules3$rules)
rules3$rules=gsub("\"", "", rules3$rules)

#Split the rule
library(splitstackshape)
Rules4=cSplit(rules3, "rules","=>")
names(Rules4)[names(Rules4) == 'rules_1'] <- 'LHS'
Rules5=cSplit(Rules4, "LHS",",")
Rules6=subset(Rules5, select= -c(rules_2))
names(Rules6)[names(Rules6) == 'rules_3'] <- 'RHS'

# Khach hang co kha nang mua gi truoc mua "Bo den giu nhiet tim trang"
rules<-apriori(data=dt, parameter=list(supp=0.001,conf = 0.8), 
               appearance = list(default="lhs",rhs="WHITE HANGING HEART T-LIGHT HOLDER"),
               control = list(verbose=F))
rules<-sort(rules, decreasing=TRUE,by="confidence")
inspect(rules[1:5])

# Khach hang co kha nang mua gi neu ho da mua Bo den 
rules<-apriori(data=dt, parameter=list(supp=0.001,conf = 0.8), 
               appearance = list(default="rhs",lhs="WHITE HANGING HEART T-LIGHT HOLDER"),
               control = list(verbose=F))
rules<-sort(rules, decreasing=TRUE,by="confidence")
inspect(rules[1:5])
summary(rules)

