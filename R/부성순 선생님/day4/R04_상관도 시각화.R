# cor()
  * 피어슨 상관계수(기울기)
# plot()
  * 피어슨 상관계수 시각화
# 다중공선성
# plot( , main=' ', pch= ,col= ) 
  * plot(데이터, 차트 제목, 점 모양 , 색깔 )
  * 패키지를 이용하지 않고 plot으로 시각화 꾸미기
    - 문자열을 숫자값으로 변환
# chart.Correlation(mtcars, histogram=TRUE, pch=19)
  * PerformanceAnalytics 패키지를 이용한 상관도 시각화
    - mtcars 상관도 시각화
    - tips 자료 상관도 시각화

##############################
##############################
mtcars

str(mtcars)
plot(mtcars)

cor(mtcars[,c(1,3,5,6)])

plot(mtcars[,c(1,3,5,6)])

iris

iris.2 <- iris[,3:4]
levels(iris$Species)

iris$Species

group <- as.numeric(iris$Species)

group

color <-c('red','green','blue')

plot(iris.2,
	main = 'Iris plot',
	pch=c(group),
	col=color[group])
##############################
install.packages("PerformanceAnalytics")
##############################
library(PerformanceAnalytics)

chart.Correlation(mtcars, histogram=TRUE, pch=19)

tmp=tips[,c(1,2,7)]
chart.Correlation(tmp, histogram=TRUE, pch=19)
##############################
##############################
mtcars

str(mtcars)
plot(mtcars)

# 피어슨 상관계수(기울기)
cor(mtcars[,c(1,3,5,6)])

# 시각화
plot(mtcars[,c(1,3,5,6)])

# 독립변수(x)끼리는 상관도가 너무 높으면 안된다.
  * 상관도가 너무 높은 경우를 다중공선성이라고 한다.
     - 독립변수들 중 1개(x1)를 바꾸면 다른 독립변수(x2)에도 영향을 미친다.
     - 그 말은 서로 상관도 높은 상대 독립변수(x2)의 값에도 영향을 줘서 다시 종속변수 Y에도 영향을 미치기 때문에 오롯이 x1 변수에 따른 Y의 변화를 안정적으로 설명할 수 없다..
  * 다중공선성 VIF(분산팽창지수)로 10이상 나오면
    - 이런 경우 x2 변수를 제거하고, VIF 보고, x1을 제거하고 VIF을 보는 방식으로 파악한다.

# 패키지를 이용하지 않고 plot으로 시각화 꾸미기
  * 문자열을 숫자값으로 변환
  * plot( , main=' ', pch= ,col= )
    -  plot(데이터, 차트 제목, 점 모양 , 색깔 )
iris

iris.2 <- iris[,3:4]
levels(iris$Species)

iris$Species

group <- as.numeric(iris$Species)

group

color <-c('red','green','blue')

plot(iris.2,
	main = 'Iris plot',
	pch=c(group),
	col=color[group])

# PerformanceAnalytics 패키지를 이용한 상관도 시각화

# mtcars 상관도 시각화

install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)

chart.Correlation(mtcars, histogram=TRUE, pch=19)

# tips 자료 상관도 시각화

tmp=tips[,c(1,2,7)]
chart.Correlation(tmp, histogram=TRUE, pch=19)

