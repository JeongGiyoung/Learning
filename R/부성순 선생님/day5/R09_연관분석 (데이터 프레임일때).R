# 데이터 형식이 data.frame 형식일 때 연관분석을 위해 파일 형태를 바꾸는 방법
# https://blog.daum.net/sys4ppl/6

dir()
getwd()
setwd("C:/Sources/StudyR/day5/장바구니 분석")

dvd <- read.csv("dvdtrans.csv", header = TRUE, as.is = TRUE)
dvd

dvd$Item[dvd$ID == 1]

# 데이터의 변환 - transactions 클래스로 변환
# arules 패키지를 이용하여 연관규칙을 분석하기 위해서 arules 패키지가 사용하는 데이터 형태로 변화을 해주어야 한다.

dvd.list <- split(dvd$Item, dvd$ID)
dvd.list

# arules 패키지 불러오기(연관분석 패키지)
install.packages("arules") 
library(arules)

# 거래별로 항목 정보가 정리되었으면 arules에서 사용하는 “transaction” 클래스로 데이터를 변환해 준다.
# as() 함수를 이용하면 해당 데이터 구조를 정해진 클래스 데이터로 변환할 수 있다.

dvd.trans <- as(dvd.list, "transactions")
dvd.trans

# 위의 결과에서 알 수 있듯이 거래 정보가 10개의 거래와 총 10개의 물품으로 구성된 데이터임을 보여준다.
# 좀 더 자세한 정보를 알고자 하면 summary() 함수를 이용한다.

summary(dvd.trans)

# arules 패키지가 제공하는 image() 함수를 이용하면 데이터에 대하여 시각적으로 확인해 볼 수 있다. 
image(dvd.trans)

# 연관규칙의 생성
dvd.rules <- apriori(dvd.trans)

# 좀 더 유용한 연관규칙을 확인하기 위해 최소 지지도를 0.2, 
# 그러니까 2번 이상 거래에 나타나는 연관규칙을 찾도록 한다. 
# 대신 신뢰도는 0.6으로 낮추어 실행해 본다. 
# 그러면 총 15개의 연관규칙을 발견하는 데, 
# 한 물품으로 된 규칙도 3개 발견됨을 볼 수 있다.

dvd.rules <- apriori(dvd.trans, parameter = list(support = 0.2, confidence = 0.6))

# 연관규칙의 시각화

install.packages("arulesViz")
library(arulesViz)

# plot() 함수에 method 인자를 “grouped"로 주게 되면 연관규칙의 조건(LHS)과 결과(RHS)을 기준으로 그래프를 보여준다. 원의 크기는 각 규칙의 지지도를 색상의 진하기는 향상도(lift)를 보여준다. 조건(LHS) 이름 앞의 숫자는 그 조건으로 되어 있는 연관규칙의 수를 의미한다. 조건(LHS)에 ”+“와 함께 표시된 숫자는 표시가 생략된 물품 수를 의미한다.

plot(dvd.rules, method = "grouped")

# 앞의 그래프에서 노드는 물품 집합이다. 그래프의 노드를 물품만으로 제한하고 싶으면 다음과 같이 control 인수의 type을 "items"로 설정한다 (앞의 예는 "itemsets"의 경우이다). 그러면 텍스트로 된 노드들은 모두 물품만을 나타내고, 물품들의 관계를 나타내기 위해 원이 이용되었음을 볼 수 있다. 조건이 두개의 물품의 경우 원에 두개의 입력 화살표가 있음을 확인할 수 있다.
# 원의 크기는 규칙의 지지도를 색상은 향상도(lift)를 나타낸다.

plot(dvd.rules, method = "graph", control = list(type = "items"))