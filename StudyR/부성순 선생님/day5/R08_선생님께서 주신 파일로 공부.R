dir()
getwd()
setwd("C:/Sources/StudyR/day5/장바구니 분석")

install.packages("arules")
library(arules)

# 

tr<-read.transactions ("자료_장바구니분석테스트.txt",format="basket",sep=",") 

head(tr)

# 지지도, 향상도 0.1 이상 자료 (0.1은 10%를 의미함 숫자값은 사용자가 임의로 넣음)

rules=apriori(tr,parameter=list(supp=0.1,conf=0.1))
inspect(rules)

# lift(향상도) 높은순으로 10개

inspect(rules[1:10])
inspect(sort(rules,by="lift")[1:10]) 

# lift(향상도) 값이 1이상인값만 추출

연관결과<-inspect(sort(rules,by="lift"))
head(연관결과)
subset(연관결과,subset=(lift>=1)) 

#
install.packages("arulesViz")
library(arulesViz)

# 가로(지지도), 세로(신뢰도), 색상(향상도)
plot(rules)

# 매트릭스차트
# Ihs(가로축)-조건(x아이템)과 rhs(세로축)-결과(y아이템) 으로구성한매트릭스그래프

plot(rules,method="grouped")

# 각규칙별로어떤아이템들이 연관되어묶여있는지 보여주는네트워크그래프
# 네트워크차트
plot(rules,method="graph")
