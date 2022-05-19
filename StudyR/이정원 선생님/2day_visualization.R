# library(ggplot2) : 시각화할 때 쓰는 패키지
## 산점도 그래프
# 첫 번째 레이어 : 배경 설정
# ggplot(data = , aes(x= , y =  ))
# 두 번째 레이어 : 그래프 추가
# + geom_point() : 산점도를 찍는다.
# 그래프가 일정한 모양을 보여야 하는데, 무분별하게 흩어져 있으면 그 데이터는 분석이 불가능한 데이터다.
# + xlim( , ) : x축 범위 조정
# + ylim(10, 30) : y축 범위 조정
# qplot : 전처리 단계 데이터 확인용 문법 간단, 기능 단순
# ggplot : 최종 보고용. 색, 크기, 폰트 등 세부 조작 가능
# 실습[1]
##############
# 10만 단위가 넘는 숫자는 지수 표기법에 따라 표현
# 1e+05 = 10만(1x10의 5승)
# 정수로 표현 : options(scipen = 99)
# 지수 : options(scipen = 0)
# R 스튜디오 재실행시 옵션 원상 복구
##########
## 막대 그래프
# 1. 집단별 평균표 만든다.
# 2. 그래프를 만든다.
# ggplot(data = , aes(x = , y = )) + geom_col()
# 3. 크기 순으로 정렬
# reorder( , - ) : 내림차순

## 빈도 막대 그래프
#  + geom_bar() : 데이터 수량(count)

## 선 그래프 : 시간 흐름에 따라 달라지는 데이터 표현
# + geom_line()
# 실습[2]
###################
# 상자 그림 : 집단 간 분포 차이 표현
# + geom_boxplot()
# 실습[3]
# 상자 크기가 클 수록 데이터가 많다는 뜻
############################################
############################################

# library(ggplot2) : 시각화할 때 쓰는 패키지

library(ggplot2)

# 첫 번째 레이어 : 배경 설정
# ggplot(data = , aes(x= , y =  ))

ggplot(data = mpg, aes(x=displ, y = hwy))

# 두 번째 레이어 : 그래프 추가
# + geom_point() : 산점도를 찍는다.
# 그래프가 일정한 모양을 보여야 하는데, 무분별하게 흩어져 있으면 그 데이터는 분석이 불가능한 데이터다.
ggplot(data = mpg, aes(x=displ, y = hwy)) + geom_point()

# + xlim( , ) : x축 범위 조정
# + ylim(10, 30) : y축 범위 조정

ggplot(data = mpg, aes(x=displ, y = hwy)) +
  geom_point() +
  xlim(3,6) +
  ylim(10, 30)

# qplot : 전처리 단계 데이터 확인용 문법 간단, 기능 단순
# ggplot : 최종 보고용. 색, 크기, 폰트 등 세부 조작 가능

# 실습[1]
mpg <- as.data.frame(ggplot2::mpg)

# 1. mpg 데이터의 cty, hwy 간에 어떤 관계인지 확인
# x축은 cty, y축은 hwy로 된 산점도를 만든다.

library(ggplot2)

ggplot(data = mpg, aes(x=cty, y = hwy)) + geom_point()

# 2. midwest 데이터를 통해
# x축은 poptotal(전체 인구), y축은 popasian(아시아인 인구)로 산점도를 만든다.
# 전체 인구는 50만 명 이하, 아시아 인구는 1만 명 이하인 지역만 산점도를 만든다.

ggplot(data = midwest, aes(x=poptotal, y = popasian)) +
  geom_point() +
  xlim(0,500000) +
  ylim(0, 10000)

# 10만 단위가 넘는 숫자는 지수 표기법에 따라 표현
# 1e+05 = 10만(1x10의 5승)
# 정수로 표현 : options(scipen = 99)
# 지수 : options(scipen = 0)
# R 스튜디오 재실행시 옵션 원상 복구

# 막대 그래프
# 1. 집단별 평균표 만든다.
library(dplyr)

df_mpg <- mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

df_mpg

# 2. 그래프를 만든다.
# ggplot(data = , aes(x = , y = )) + geom_col()

ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()

# 3. 크기 순으로 정렬
# reorder( , - ) : 내림차순

ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()

# 빈도 막대 그래프
#  + geom_bar() : 데이터 수량(count)
ggplot(data = mpg, aes(x=drv)) + geom_bar()

ggplot(data = mpg, aes(x=hwy)) + geom_bar()


# 실습
# mpg 데이터를 이용
# 1. "suv"차종을 대상으로 평균 cty(도시 연비)가 가장 높은 회사 다섯 곳을
# 막대 그래프로 표현
# 막대는 연비 높은 순으로 정렬
mpg <- as.data.frame(ggplot2::mpg)

df <- mpg %>%
  filter(class == "suv") %>%
  group_by(manufacturer)
  summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty)) %>%
  head(5)

df

ggplot(data = df, aes(x = reorder(manufacturer, -mean_cty),
                          y = mean_cty)) + geom_col()

# 2. 자동차 종류별 빈도를 표현한 막대 그래프를 그린다.

ggplot(data = mpg, aes(x = class)) + geom_bar()

# 선 그래프 : 시간 흐름에 따라 달라지는 데이터 표현
# + geom_line()
library(ggplot2)

head(economics)

ggplot(data = economics, aes(x =date, y = unemploy)) + geom_line()

# 실습[2]
# 1. psavert(개인 저축률)가 시간에 따라 어떻게 변하는지 파악
# 시간에 따른 개인 저축률의 변화를 시계열 그래프로 만든다.

ggplot(data = economics, aes(x =date, y = psavert)) + geom_line()

# 상자 그림 : 집단 간 분포 차이 표현
# + geom_boxplot()
mpg <- as.data.frame(ggplot2::mpg)
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()

# 실습[3]
# mpg 데이터를 통해
# "compact", "subcompact", "suv" 자동차의 cty(도시 연비)가 어떻게 다른지
# 상자 그림을 통해 비교.
mpg <- as.data.frame(ggplot2::mpg)

df <- mpg %>%
  filter(class %in% c("compact", "subcompact", "suv"))

ggplot(data = df, aes(x = class, y = cty)) + geom_boxplot()
# 상자 크기가 클 수록 데이터가 많다는 뜻