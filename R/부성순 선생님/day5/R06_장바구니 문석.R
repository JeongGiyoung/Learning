install.packages('arules')
library(arules)

dir()
tran = read.transactions("train.txt", format="basket", sep=',')
head(tran)
str(tran)
class(tran)

tran@itemInfo
tran@data@i

# 행렬 개수 보여주는 명령어
 
tran

#
inspect(tran)
str(inspect(tran))

# 규칙(rule) 발견

apriori(tran, parameter=list(supp=0.3, conf=0.1))

rule=apriori(tran, parameter=list(supp=0.3, conf=0.1))

str(rule)

inspect(rule)

# 이 중에 lift(향상도)가 높은 값을 본다.

# 지갑은 구매수가 가장 적지만 지난 

# 넥타이, 셔츠 신뢰도
	* 넥타이어와 셔츠의 지지도 / 넥타이의 지지도
      * 셔츠와 넥타의 지지도 / 셔츠의 진진도
      # 0.5/0.75 => 0.6666...

