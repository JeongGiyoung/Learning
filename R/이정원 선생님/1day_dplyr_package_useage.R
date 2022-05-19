##### dplyr 패키지 : 데이터 전처리에 필요한 함수 모음#####
##########################################################

# View() : 엑셀처럼 보여주는 기능
# dim() : 행과 열 확인하기
# as.data.frame(ggplot2::mpg) : ggplot2 의 mpg 데이터를 데이터 프레임 형태로 불러오기
# install.packages("dplyr") : 데이터 컨트롤 하는 패키지
# 복사본 만드는 방법
# rename() : 컬럼 이름 바꾸기
# 파생변수(새로운 컬럼 만들기)
# mpg데이터 셋을 가지고 실습. 통합연비 구하기
# hist() : 요약 통계랑 산출
# ifelse() : if 문
# table() : 빈도표
# qplot() : 빈도 그래프
# ifelse() : 범주를 만들 때 유용하다
# 실습[1] 1.~5.
#############
# dplyr 패키지 : 데이터 전처리에 필요한 함수 모음
# %>% filter() : 원하는 데이터 추출
# %in% 명령문을 사용해서 여러 조건을 한 번에 처리하기
# 논리 연산자의 기준은 왼쪽이다
# 산술연산자
# 실습[2]
#############
# %>% select() : 특정 컬럼 추출
# %>% select(-) : 특정 컬럼 제외하고 추출
# dplyr 함수 조합하기
# head 를 쓰고 싶을 때
# 실습[3]
############
# %>% arrange() : 오름차순 정렬
# %>% arrange(desc()) : 내림차순 정렬
# %>% arrange( , ) : 복수로 오름차순 정렬
# 실습[4]
############
# %>% mutate( = + ) : 파생 변수 추가
# %>% mutate(  = ifelse( , " ", " ")) : 파생변수를 만들 때 ifelse 쓰기
# 실습[5]
############
# %>% summarise() : 요약
# %>% group_by(): 값을 그룹핑
# group_by() %>% summarise( , , ) : 그룹별 요약을 여러개 하기
# n() : 데이터 수
# median() : 중앙값
# 두 개의 조건이 같은 값끼리 그룹핑
# 실습[6]
# mutate() 함수는 가상 메모리에 저장된 데이터이기 때문에, 실존 데이터를 가지고 계산하는 summarise() 함수의 경우 산술연산을 사용하면 처리하지 못한다. 그래서 summarasie()에 쓸 수 있는 다른 함수를 사용해야 가상 메모리에 저장된 데이터도 연산할 수 있다.
############
# 실습[7]
# 조건으로 먼저 필요한 데이터만 걸러내고(filter) 그룹핑을 해야 한다. 
#   * 왜냐하면 먼저 데이터를 걸러내면
#     이후 연산과정에서 속도가 빨라진다.
############
# left_join(, , , by = " ") : 기준을 두고 합치기
# typeof() : 일반 변수 type을 확인
# mode() : 데이터 컬럼의 tpye을 확인
# bind_rows(,) : 세로로 합치기
# 실습[8]
########################
# is.na() : 결측치 확인
# 결측치가 포함된 상태에서는 함수 분석이 불가능하다
# %>% filter(is.na()) : 결측치를 뽑기
# %>% filter(! s.na()) : 결측치 제거
# na.omit() : 컬럼값 중에 결측치가 있으면 행 전체를 삭제
# 무분별하게 데이터가 사라지면 분석에 영향을 미칠 수 있으니 
# 주로 컬럼별로 결측치를 삭제한다.
# na.rm = T : 결측치를 제외하고 함수 사용
# NA값은 주로 평균값으로 대체하기 때문에 na.rm를 자주 사용한다. 
# 실습[9]
##################
# 이상치(outlier) 확인하기
# 결측치로 대체하기
# 결측치를 제외하고 분석
# boxplot() :극단치 수치 확인
# 실습[10]

################################
################################
library(dplyr)
library(readxl)

getwd()
setwd("C:/Recture/Busan_202202_R/Data")

exam <- read.csv("./csv_exam.csv")

head(exam)

head(exam, 10)

tail(exam)

tail(exam, 10)

# View() : 엑셀처럼 보여주는 기능
View(exam)

# dim() : 행과 열 확인하기
dim(exam)

str(exam)

summary(exam)

# as.data.frame(ggplot2::mpg) : ggplot2 의 mpg 데이터를 데이터 프레임 형태로 불러오기

mpg <- as.data.frame(ggplot2::mpg)
head(mpg, 10)

# install.packages("dplyr") : 데이터 컨트롤 하는 패키지

mpg <- as.data.frame(ggplot2::mpg)

df_raw <- data.frame(var1 = c(1,2,1),
                     var2 = c(2,3,2))
df_raw

# 복사본 만드는 방법

df_new <- df_raw

df_new

# rename() : 컬럼 이름 바꾸기

df_new <- rename(df_new, v2 = var2)
df_new

# 파생변수(새로운 컬럼 만들기)

df <- data.frame(var1 = c(4, 3, 8),
                 var2 = c(2, 6, 1))
df

df$var_sum <- 10
df$var_sum <- c(1,2,3)
df$var_sum <- df$var1 + df$var2
df

df$mean <- (df$var1 + df$var2) / 2
df

# mpg데이터 셋을 가지고 실습. 통합연비 구하기

mpg$total <- (mpg$cty + mpg$hwy) / 2
head(mpg)
mean(mpg$total)

summary(mpg$total)

# hist() : 요약 통계랑 산출
hist(mpg$total)

# ifelse() : if 문

mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")
head(mpg)

# table() : 빈도표

table(mpg$test)

# qplot() : 빈도 그래프

library(ggplot2)
qplot(mpg$test)

# ifelse() : 범주를 만들 때 유용하다

mpg$grade <- ifelse(mpg$total >= 30, "A", 
                    ifelse(mpg$total >= 20, "B", "C"))
table(mpg$grade)
qplot(mpg$grade)

# 실습[1]

# 1.

midwest <- as.data.frame(ggplot2::midwest)
head(midwest)
tail(midwest)
View(midwest)
dim(midwest)
str(midwest)
summary(midwest)

# 2.
library(dplyr)

df_midwest <- rename(midwest, total = poptotal, asian = popasian)

View(df_midwest)

# 3.
df_midwest$asian_rate <- df_midwest$asian/df_midwest$total*100
View(df_midwest)

hist(df_midwest$asian_rate)

# 4. 

mean(df_midwest$asian_rate)

df_midwest$asian_amount <- ifelse(df_midwest$asian_rate > mean(df_midwest$asian_rate), "large", "small")
View(df_midwest)

# 5. 
table(df_midwest$asian_amount)
qplot(df_midwest$asian_amount)

#####################################

# dplyr 패키지 : 데이터 전처리에 필요한 함수 모음
library(dplyr)
exam <- read.csv("./csv_exam.csv")

# exam에서 class가 1인 경우만 추출
# %>%(~중에서) 단축키 : ctrl +shift + M 

exam %>% filter(class == 1)

# exam에서 class가 1이 아닌 경우만 추출
exam %>% filter(class != 1)

# 1반이면서 수학 점수가 50점 이상인 경우
exam %>% filter(class == 1 & math >= 50)

# 수학 점수가 90점 이상이거나 영어점수가 90점 이상인 경우
exam %>% filter(math >= 90 | english >=90)

# 또는 조건이 여러개인 경우
exam %>% filter(class == 1 | class == 3 | class == 5)

# %in% 명령문을 사용해서 여러 조건을 한 번에 처리하기
exam %>% filter(class %in% c(1,3,5))

# 추출한 데이터를 새로운 변수에 입력
class1 <- exam %>% filter(class == 1)

mean(class1$math)

# 논리 연산자의 기준은 왼쪽이다
#   * A > B 에서 A가 기준

# 산술연산자
# ^, ** : 제곱
# %/% : 나눗셈의 몫
# %% : 나눗셈의 나머지

### 실습 [2]
# mpg 데이터로 실습
# 1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아본다.
# displ(배기량)이 4이하인 자동차와 
# displ(배기량)이 5이하인 자동차 중
# 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 좋은지 알아본다.

mpg <- as.data.frame(ggplot2::mpg)

View(mpg)
mpg_displ_under4 <- mpg %>% filter(displ <= 4)
mpg_displ_under4$hwy

mpg_displ_under5 <- mpg %>% filter(displ <= 5)
mpg_displ_under5$hwy

mean(mpg_displ_under4$hwy)
mean(mpg_displ_under5$hwy)

# 2. 
# 자동차 제조 회사에 따라 도시 연비가 다른지 알아본다.
# "audi" 와 "toyota" 중 어느 manufacturer(자동차 제조회사)의
# cty(도시 연비)가 평균적으로 더 좋은지 알아본다.

mpg_audi <- mpg %>% filter(manufacturer == "audi")
mpg_toyota <- mpg %>% filter(manufacturer == "toyota")

mpg_audi
mpg_toyota

mean(mpg_audi$cty)
mean(mpg_toyota$cty)

3. 
# "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 합니다.
# 이 회사들의 자동차를 추출한 뒤 hwy 전체평균을 구하시오

mpg_new <- mpg %>%
  filter(manufacturer %in% c("chevrolet", "ford", "honda"))

mean(mpg_new$hwy)

####################

# %>% select() : 특정 컬럼 추출

exam %>% select(math, english)

# %>% select(-) : 특정 컬럼 제외하고 추출
exam %>% select(-math, -english)

# dplyr 함수 조합하기

exam %>% filter(class == 1) %>% select(english)

exam %>% 
  filter(class == 1) %>% 
  select(english)

# head 를 쓰고 싶을 때

exam %>% 
  select(id, math) %>%
  head(10)

# 실습[3]
# 1. 
# mpg 데이터에서 class, cty 변수를 추출해 새로운 데이터를 만든다.
# 새로 만든 데이터의 일부를 출력해서 두 변수로만 구성되어 있는지 확인

df <- mpg %>%
  select(class, cty)

head(df)

# 2. 
# 앞에서 추출한 데이터를 이용해서 
# class가 "suv"인 자동차와 "compact"인 자동차 중 
# 어떤 자동차의 cty가 더 높은지 확인

df_suv <- mpg %>%
  select(class, cty) %>%
  filter(class == "suv" )

df_compact <- mpg %>%
  select(class, cty) %>%
  filter(class == "compact")

mean(df_suv$cty)
mean(df_compact$cty)

# %>% arrange() : 오름차순 정렬
library(dplyr)

exam %>% arrange(math) %>% head

# %>% arrange(desc()) : 내림차순 정렬

exam %>% arrange(desc(math)) %>% head

# %>% arrange( , ) : 복수로 오름차순 정렬

exam %>% arrange(class, math) %>% head

# 실습[4]
# mpg 데이터를 불러와서
# "audi"에서 생산한 자동차 중
# hwy(고속도로 연비)가 1~5위에 해당하는 자동차 출력
mpg <- as.data.frame(ggplot2::mpg)

mpg %>%
  filter(manufacturer == "audi") %>%
  arrange(desc(hwy)) %>% head(5)

# %>% mutate( = + ) : 파생 변수 추가
exam <- read.csv("./csv_exam.csv")

exam %>% 
  mutate(total = math + english + science,
         mean = (math + english + science)/3) %>%
  head

# %>% mutate(  = ifelse( , " ", " ")) : 파생변수를 만들 때 ifelse 쓰기
exam %>%
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>%
  head

exam

# 실습[5]
# 1. mpg 데이터 복사본을 만들고, cty와 hwy를 더한 '합산 연비 변수'를 추가한다.

mpg <- as.data.frame(ggplot2::mpg)

mpg_new <- mpg

mpg_new <- mpg_new %>% 
  mutate(total = cty+hwy) %>%
  head

# 2. 앞에서 만든 '합산 연비 변수'를
# 2로 나눠 '평균 연비 변수'를 추가한다.

mpg_new <- mpg_new %>% 
  mutate(mean = total/2) %>%
  head

# 3. '평균 연비 변수'가 가장 높은 자동차 3종 데이터 출력

mpg_new %>% 
  arrange(desc(mean)) %>%
  head(3)

# 4. 1~3번 문제를 해결할 수 있는 하나로 연결된 dplyr 구문을 만들어 출력한다.
# 데이터는 복사본 대신 mpg 원본을 이용한다.

mpg %>% 
  mutate(total = cty + hwy,
         mean = total/2) %>%
  arrange(desc(mean)) %>%
  head(3)

# %>% summarise() : 요약

exam <- read.csv("./csv_exam.csv")
exam

exam %>% summarise(mean_math = mean(math))

# %>% group_by(): 값을 그룹핑

# 반별 수학점수의 평균값
exam %>%
  group_by(class) %>%
  summarise(mean_math = mean(math))


# group_by() %>% summarise( , , ) : 그룹별 요약을 여러개 하기
# n() : 데이터 수
# median() : 중앙값
exam %>%
  group_by(class) %>%
  summarise(mean_math = mean(math),
            sum_math = sum(math),
            median_math = median(math),
            n= n())

# 두 개의 조건이 같은 값끼리 그룹핑

mpg %>%
  group_by(manufacturer, drv) %>%
  summarise(mean_cty = mean(cty)) %>%
  head(10)

# 실습[6]
# 회사별로 "suv" 자동차의 도시 및 고속도로 통합 연비 평균을 구해
# 내림차순으로 정렬하고
# 1~5위까지 출력

mpg <- as.data.frame(ggplot2::mpg)

View(mpg)

mpg_new <- mpg %>%
  group_by(manufacturer) %>%
  filter(class == "suv") %>%
  mutate(total = (cty+hwy)/2) %>%
  summarise(mean_suv = mean(total),
            n_suv = n()) %>%
  arrange(desc(mean_suv)) %>%
  head(5)

View(mpg_new)

# mutate() 함수는 가상 메모리에 저장된 데이터이기 때문에, 실존 데이터를 가지고 계산하는 summarise() 함수의 경우 산술연산을 사용하면 처리하지 못한다. 그래서 summarasie()에 쓸 수 있는 다른 함수를 사용해야 가상 메모리에 저장된 데이터도 연산할 수 있다.

mpg_new <- mpg %>%
  group_by(manufacturer) %>%
  filter(class == "suv") %>%
  mutate(total = (cty+hwy)/2) %>%
  summarise(mean_suv = total /2 ,
            n_suv = n()) %>%
  arrange(desc(mean_suv)) %>%
  head(5)

View(mpg_new)

# 실습[7]
# 1. mpg 데이터를 토대로 어떤 차종의 연비가 높은지 비교한다.
# class 별 cty 평균을 구한다.

mpg <- as.data.frame(ggplot2::mpg)

mpg_test <- mpg %>%
  group_by(class) %>%
  summarise(mean_cty = mean(cty))
  
View(mpg_test)

# 2. 어떤 차종의 도시 연비가 높은지 쉽게 볼 수 있도록
# cty 평균이 높은 순으로 정렬해 출력

mpg_test %>% 
  arrange(desc(mean_cty))

# 3. hwy 평균이 가장 높은 회사 세 곳을 출력

mpg_test3 <- mpg %>%
  group_by(manufacturer) %>%
  summarise(mean_hwy = mean(hwy)) %>%
  arrange(desc(mean_hwy))%>%
  head(3)

View(mpg_test3)

# 4. 각 회사별 "compact" 차종 수를 내림차순으로 정렬
# 조건으로 먼저 필요한 데이터만 걸러내고(filter) 그룹핑을 해야 한다. 
#   * 왜냐하면 먼저 데이터를 걸러내면
#     이후 연산과정에서 속도가 빨라진다.

mpg_test4 <- mpg %>%
  filter(class == "compact") %>%
  group_by(manufacturer) %>%
  summarise(n_compact = n()) %>%
  arrange(desc(n_compact))

View(mpg_test4)

# left_join(, , , by = " ") : 기준을 두고 합치기

test1 <- data.frame(id = c(1,2,3,4,5),
                    midterm = c(60,80,70,90,85))

test2 <- data.frame(id = c(1,2,3,4,5),
                    final = c(70,83,65,95,80))

total <- left_join(test1, test2, by = "id")
total

# typeof() : 일반 변수 type을 확인
# mode() : 데이터 컬럼의 tpye을 확인

#

name <- data.frame(class = c(1,2,3,4,5),
                   teacher = c("kim", "lee", "park", "choi", "jung"))
name

# 
exam_new <- left_join(exam, name, by = "class")
exam_new

# bind_rows(,) : 세로로 합치기
group_a <- data.frame(id = c(1,2,3,4,5),
                      test = c(60,80,70,90,85))
group_b <- data.frame(id = c(1,2,3,4,5),
                      test = c(70,83,65,95,80))

group_a
group_b

group_all <- bind_rows(group_a, group_b)
group_all

# 실습[8]

fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = F)
fuel

# 1. 위에서 만든 fuel 데이터를 이용해서 mpg데이터에 price_fl 변수를 추가한다.

mpg_new <- left_join(mpg, fuel, by = "fl")
View(mpg_new)

# 2. model, fl, price_fl 변수를 추출해 앞부분 5행 출력

mpg_new %>%
  select(model, fl, price_fl) %>%
  head(5)

# is.na() : 결측치 확인
# 결측치가 포함된 상태에서는 함수 분석이 불가능하다

df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                  score = c(5,4,3,4, NA))
df

is.na(df)

table(is.na(df$sex))

# %>% filter(is.na()) : 결측치를 뽑기
# %>% filter(! s.na()) : 결측치 제거

library(dplyr)

df %>% filter(is.na(score))

df %>% filter(!is.na(score))

# 성별 결측치 제거

df %>% filter(!is.na(sex))

df_nomiss <- df%>% filter(!is.na(score) & !is.na(sex))
df_nomiss

# na.omit() : 컬럼값 중에 결측치가 있으면 행 전체를 삭제
# 무분별하게 데이터가 사라지면 분석에 영향을 미칠 수 있으니 
# 주로 컬럼별로 결측치를 삭제한다.
df_nomiss2 <- na.omit(df)
df_nomiss2

# na.rm = T : 결측치를 제외하고 함수 사용
# NA값은 주로 평균값으로 대체하기 때문에 na.rm를 자주 사용한다. 

mean(df$score, na.rm = T)

# 

exam <- read.csv("csv_exam.csv")
exam[c(3,8,15), "math"] <- NA

exam %>% summarise(mean_math = mean(math, na.rm = T))


# 평균값으로 결측치 대체하기

exam <- read.csv("csv_exam.csv")
exam[c(3,8,15), "math"] <- NA
exam

exam$math <- ifelse(is.na(exam$math), 55, exam$math)
table(is.na(exam$math))

exam


# 실습[9]
mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA

# 1. mpg 데이터에 drv 변수와 hwy 변수에 결측치가 몇 개 있는 확인

mpg <- as.data.frame(ggplot2::mpg)

table(is.na(mpg$drv))
table(is.na(mpg$hwy))

# 2. filter() 를 이용해 hwy 변수의 결측치를 제외하고
# 어떤 구동방식의 hwy 평균이 높은지 확인
# 하나의 dplyr 구문으로 만든다.

mpg %>% filter(!is.na(hwy)) %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

# 이상치(outlier) 확인하기

outlier <- data.frame(sex = c(1,2,1,3,2,1),
                      score = c(5,4,3,4,2,6))
outlier

table(outlier$sex)

# 결측치로 대체하기

outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier

outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier

# 결측치를 제외하고 분석
outlier %>%
  filter(!is.na(sex) & !is.na(score)) %>%
  group_by(sex) %>%
  summarise(mean_score = mean(score),
            n = n())

# boxplot() :극단치 수치 확인
mpg <- as.data.frame(ggplot2::mpg)

boxplot(mpg$hwy)

boxplot(mpg$hwy)$stats

# 결측 처리하기

mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)

table(is.na(mpg$hwy))

mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy, na.rm = T))

# 실습[10]
# 이상치 데이터 생성
mpg <- as.data.frame(ggplot2::mpg)
mpg[c(10,14,58,92), "drv"] <- "k"
mpg[c(29,43,129,203), "cty"] <- c(3,4,39,42)
View(mpg)

# 1. drv에 이상치가 있는 확인
# 이상치를 결측 처리한 다음 
# 이상치가 사라졌는지 확인
# 결측 처리할 때는 %in% 기호를 활용하세요

table(mpg$drv)

mpg$drv <- ifelse(mpg$drv %in% "k", NA, mpg$drv)
# 혹은
mpg$drv <- ifelse(mpg$drv %in% c(4, "f", "r"), mpg$drv, NA)

table(mpg$drv)

# 2. 상자그림을 이용해 cty에 이상치가 있는지 확인
# 상자 그림 통계치를 이용해 정상 범위를 벗어난 값을 결측 처리
# 상자 그림을 만들어 이상치가 사라졌는지 확인

boxplot(mpg$cty)

boxplot(mpg$cty)$stats

mpg$cty <- ifelse(mpg$cty < 9 | mpg$cty > 26, NA, mpg$cty)

boxplot(mpg$cty)

# 3. drv 별로 cty 평균이 어떻게 다른지 확인
# 하나의 dplyr 구문으로 만든다.

mpg %>%
  filter(!is.na(drv)) %>%
  group_by(drv) %>%
  summarise(mean_cty = mean(cty, na.rm = T))

# 혹은

mpg %>%
  filter(!is.na(drv) & !is.na(cty)) %>%
  group_by(drv) %>%
  summarise(mean_cty = mean(cty))