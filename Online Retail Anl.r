
# Read CSV data file
mydata = read.csv(file = "D:\\Dataset\\OnlineRetail\\OnlineRetail.csv")
#mydata = read.csv("D:\\Dataset\\MBA.csv")
dim(mydata)
# See first 10 observations
head(mydata, n=10)

# chia du lieu khach hang mua gi
dt <- split(mydata$Description, mydata$CustomerID)

# Loading arules package
if(!require(arules)) install.packages("arules")

# Convert data to transaction level
dt2 = as(dt,"transactions")
summary(dt2)
inspect(dt2)

# Most Frequent Items
itemFrequency(dt2, type = "relative")
itemFrequencyPlot(dt2,topN = 5)

# aggregated data
rules = apriori(dt2, parameter=list(support=0.005, confidence=0.8))
rules = apriori(dt2, parameter=list(support=0.005, confidence=0.8, minlen = 3))
rules = apriori(dt2, parameter=list(support=0.005, confidence=0.8, maxlen = 4))

#Convert rules into data frame
rules3 = as(rules, "data.frame")
write(rules, "F:/study/dataset/rule.csv", sep=",")

# Show only particular product rules
inspect( subset( rules, subset = rhs %pin% "Product H" ))

# Show the top 10 rules
options(digits=2)
inspect(rules[1:10])

# Get Summary Information
summary(rules)

# Sort by Lift
rules<-sort(rules, by="lift", decreasing=TRUE)

# Remove Unnecessary Rules
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

# What are customers likely to buy before they purchase "WHITE HANGING HEART T-LIGHT HOLDER"
rules<-apriori(data=dt, parameter=list(supp=0.001,conf = 0.8), 
               appearance = list(default="lhs",rhs="WHITE HANGING HEART T-LIGHT HOLDER"),
               control = list(verbose=F))
rules<-sort(rules, decreasing=TRUE,by="confidence")
inspect(rules[1:5])

# What are customers likely to buy if they purchased "WHITE HANGING HEART T-LIGHT HOLDER"
rules<-apriori(data=dt, parameter=list(supp=0.001,conf = 0.8), 
               appearance = list(default="rhs",lhs="WHITE HANGING HEART T-LIGHT HOLDER"),
               control = list(verbose=F))
rules<-sort(rules, decreasing=TRUE,by="confidence")
inspect(rules[1:5])
summary(rules)
