# 인터랙티브 그래프 설치

install.packages("plotly")
library(plotly)

library(ggplot2)

p <- ggplot(data = mpg, aes(x = displ, y = hwy,
                            col = drv)) +
  geom_point()

p

# 인터랙티브 그래프 만들기

ggplotly(p)

# 인터랙티브 막대 그래프 만들기

p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) +
  geom_bar(position = "dodge")

ggplotly(p)

# dygraphs 패키지 설치

install.packages("dygraphs")
library(dygraphs)

economics <- ggplot2::economics
head(economics)

# 시간 순서 속성을 지니는 xts 데이터 타입으로 변경
# xts 데이터 타입 : 시간 데이터가 인덱스로 바뀐다.

library(xts)

eco <- xts(economics$unemploy, order.by = economics$date)
head(eco)

# 그래프

dygraph(eco)

# 날짜 범위 선택 기능

dygraph(eco) %>% dyRangeSelector()

# 여러 값 표현

# 저축률

eco_a <- xts(economics$psavert, order.by = economics$date)

# 실업자 수

eco_b <- xts(economics$unemploy/1000, order.by = economics$date)

# 합치기
# 데이터 결합
eco2 <- cbind(eco_a, eco_b)

# 변수명 바꾸기
colnames(eco2) <- c("psavert", "unemploy")

head(eco2)

# 그래프 만들기

dygraph(eco2) %>% dyRangeSelector()