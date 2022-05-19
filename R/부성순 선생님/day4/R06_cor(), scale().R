# cor() 
  * 피어슨 상관계수 구하기
# scale()
  * raw 데이터값을 컬럼별로 표준화(비율 형태로 출력)
  * 보통 컬럼별 분포도를 한 번에 비교하면서 보고 싶을 때 쓴다.


##############################
##############################
##############################
mtcars

# cor() 

par(mfrow=c(2,1))

boxplot(mtcars$mpg~mtcars$gear)
plot(mtcars$mpg, mtcars$gear)
cor(mtcars$mpg, mtcars$gear)

# scale()

par(mfrow=c(1,1))

boxplot(mtcars)

tmp=scale(mtcars)
summary(tmp)
boxplot(tmp)

##############################
##############################
##############################
[박스플롯을 이용해 자동차 데이터 분석]

# 

mtcars

par(mfrow=c(2,1))

# cor() 
  * 피어슨 상관계수 구하기

# 

boxplot(mtcars$mpg~mtcars$gear)
plot(mtcars$mpg, mtcars$gear)
cor(mtcars$mpg, mtcars$gear)

# 엔진 종류에 따라 

boxplot(mtcars$mpg~mtcars$vs)
plot(mtcars$mpg, mtcars$vs)
cor(mtcars$mpg, mtcars$vs)

# 변속기 종류에 따라

boxplot(mtcars$mpg~mtcars$am)
plot(mtcars$mpg, mtcars$am)
cor(mtcars$mpg, mtcars$am)

# scale()
  * raw 데이터값을 컬럼별로 표준화(비율 형태로 출력)
  * 보통 컬럼별 분포도를 한 번에 비교하면서 보고 싶을 때 쓴다.

boxplot(mtcars)

tmp=scale(mtcars)
summary(tmp)
boxplot(tmp)