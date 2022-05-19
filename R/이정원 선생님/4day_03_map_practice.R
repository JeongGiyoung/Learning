# korpop1 데이터와 tbc 데이터를 사용해 최소 4가지 인사이트를 시각화 
# 구글 드라이브 - 05_결과물 - 01_R_산출물제출

# 1. 지역별 외국인 분포

library(kormaps2014)

korpop1_korean <- changeCode(korpop1)

str(korpop1_korean)

View(korpop1_korean)

## 전처리

library(dplyr)

summary(korpop1_korean)

korpop1 <- rename(korpop1,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동,
                  tot_foriegn = 외국인_계_명,
                  nhouse_foriegn = 외국인가구_가구)

is.na(korpop1$tot_foriegn)

#
library(ggiraphExtra)
library(ggplot2)

# 
library(kormaps2014)
str(changeCode(korpop1))
str(changeCode(kormap1))

#
ggChoropleth(data = korpop1, # 지도에 표현할 데이터
             aes(fill = tot_foriegn, # 색깔로 표현할 변수
                 map_id = code, # 지역 기준 변수
                 tooltip = name), # 지도 위에 표시할 지역명
             map = kormap1, # 지도 데이터 
             interactive = T) # 인터랙티브

## 2. 지역별 외국인 가구수

korpop1 <- rename(korpop1,
                  nhouse_foriegn = 외국인가구_가구)


## 

df <- changeCode(korpop1)

str(df)
head(df)

df <- df %>%
  select(name, nhouse_foriegn) %>%
  arrange(desc(nhouse_foriegn)) %>%
  head(10)

head(df)

ggplot(data = df, aes(x = name, y = nhouse_foriegn)) +
  geom_col() +
    coord_flip()

### 3. tbs 파일 이용
tbc_korean <- changeCode(tbc)

str(tbc_korean)

View(tbc_korean)

## 연도별 결핵 환자수

tbc_korean <- rename(tbc_korean,
                  newpts = NewPts)

tk <- tbc_korean

View(tk)

head(tk)

tk <- tk %>%
  select(code, name, year, newpts)

table(head(tk))

#
table(is.na(tk$year))

