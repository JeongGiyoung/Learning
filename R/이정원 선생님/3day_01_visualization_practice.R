# [실제 데이터를 가지고 실습습]
##### 필요한 라이브러리 미리 설치 및 장착
# 복사본 만들기
# 데이터 확인
# rename() : 변수명 바꾸기
# 메타 데이터(원본 데이터)+메타 정의서(컬럼별 뜻) = 데이터 set
# 메타 정의서를 보고 메타 데이터 컬럼명을 바꿔서 작업할 때 직관도를 높이는 작업
#########
# 성별에 따른 월급 차이
# class(), table() :  변수 검토
# 데이터 타입
# 컬럼에 있는 데이터 종류와 데이터값 수 확인 및 이상치 확인
# 이상치 결측 처리
# 결측치 확인
# 성별 항목 이름 부여
# 빈도표 확인
################
# 월급 변수 검토 및 전처리
# 이상치 결측 처리
###############
# 성별 월급 평균표 만들기
# 그래프 만들기 
#################
# 나이와 월급 관계 
# 기본 전처리
# 파생 변수 만들기 - 나이
# 나이에 따른 월급 평균표 만들기
# 그래프로 보기
################
# 어떤 연령대의 월급이 가장 많을까?
# 파생 변수 만들기 - 연령대
# 연령대별 월급 평균표
# + scale_x_discrete(limits = c(" ", " ", " ")) : 그래프에서 x 축 항목 순서 변경
################
# 성별 월급 차이는 연령대별로 다를까?
# 연령대 및 성별 월급 평균표 만들기
# 그래프 만들기
# fill = : 색깔로 항목 구분
# 성별 막대 분리
# geom_col(position = "dodge")
# 성별 연령별 월급 평균표 만들기
# 그래프 만들기
# col =  : 선그래프에서 항목 분리

# 직업별 다를까?
# 직업분류코드 목록 불러오기
# welfare에 직업명 결합
# 직업별 월급 평균표 만들기
# 그래프 만들기
# coord_flip() : x,y 축 바꾸기 
# 하위 10위 추출
# 그래프 그리기

# 성별로 어떤 직업이 많을까?
# 성별 빈도표 만들기
# 남성 직업 빈도 상위 10개 추출
# 여성 직업 빈도 상위 10개 추출
# 그래프 만들기
# 남성 직업 빈도 상위 10개
# 여성 직업 빈도 상위 10개

# 종교가 있는 사람들이 이혼을 덜 할까?
# 변수 검토
# 종교 유무 이름 부여
# 이혼 여부 변수 만들기
# 종교 유무에 따른 이혼율 분석

# 종교 유무에 따른 이혼율 표 만들기
# count() 활용
# 이혼율 표 만들기
# 이혼 추출

# 연령대 및 종교 유무에 따른 이혼율 분석
# 연령대별 이혼율 표 만들기
# 초년 제외, 이혼 추출
# 연령대, 종교유무, 결혼상태별 비율표 만들기
# 연령대 및 종교 유무별 이혼율 표 만들기

# 노년층이 많은 지역은 어디일까?
# 지역 코드 목록 만들기
# welfare 지역명 변수 추가
# 지역별 연령대 비율표 만들기
# 그래프
# 막대 정렬 : 노년층 비율 높은 순
# 그래프 
# 연령대 순으로 막대 색깔 나열

##################################
##################################
##### 필요한 라이브러리 미리 설치 및 장착
# spss 파일 로드
install.packages("foreign")
library(foreign) 

# 전처리
library(dplyr)

# 시각화
library(ggplot2)

# 엑셀파일 로드
library(readxl)

getwd()

raw_welfare <- read.spss(file = "./Data/Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = T)
# 복사본 만들기
welfare <- raw_welfare

welfare

# 데이터 확인
head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)

# rename() : 변수명 바꾸기
# 메타 데이터(원본 데이터)+메타 정의서(컬럼별 뜻) = 데이터 set
# 메타 정의서를 보고 메타 데이터 컬럼명을 바꿔서 작업할 때 직관도를 높이는 작업

welfare <- rename(welfare,
                  sex = h10_g3,
                  birth = h10_g4,
                  marriage = h10_g10,
                  religion = h10_g11,
                  income = p1002_8aq1,
                  code_job = h10_eco9,
                  code_region = h10_reg7)

# 성별에 따른 월급 차이
# class(), table() :  변수 검토

# 데이터 타입
class(welfare$sex)

# 컬럼에 있는 데이터 종류와 데이터값 수 확인 및 이상치 확인
table(welfare$sex)

# 이상치 결측 처리

welfare$sex <- ifelse(welfare$sex == 9, NA, welfare$sex)

# 결측치 확인
table(is.na(welfare$sex))

# 성별 항목 이름 부여
welfare$sex <- ifelse(welfare$sex == 1, "male", "female")
table(welfare$sex)

# 빈도표 확인
qplot(welfare$sex)

# 월급 변수 검토 및 전처리

class(welfare$income)
summary(welfare$income)

qplot(welfare$income)

qplot(welfare$income) + xlim(0, 1000)

# 이상치 결측 처리

boxplot(welfare$income)$stats

welfare$income <- ifelse(welfare$income %in% c(0, 9999), NA, welfare$income)

table(is.na(welfare$income))

boxplot(welfare$income)$stats

# 성별 월급 평균표 만들기
sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(sex) %>%
  summarise(mean_income = mean(income))

sex_income

# 그래프 만들기 
ggplot(data = sex_income, aes(x = sex, y = mean_income)) + geom_col()

## 나이와 월급 관계

# 변수 검토
class(welfare$birth)

summary(welfare$birth)

qplot(welfare$birth)

# 이상치 확인
summary(welfare$birth)

# 결측치 확인
table(is.na(welfare$birth))

# 이상치 결측 처리
welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)
table(welfare$birth)

# 파생 변수 만들기 - 나이

welfare$age <- 2015 - welfare$birth +1
summary(welfare$age)

# 나이에 따른 월급 평균표 만들기
age_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age) %>%
  summarise(mean_income = mean(income))

head(age_income)

# 그래프로 보기
ggplot(data = age_income, aes(x = age, y= mean_income)) + geom_line()

# 어떤 연령대의 월급이 가장 많을까?

# 파생 변수 만들기 - 연령대
welfare <- welfare %>%
  mutate(ageg = ifelse(age < 30, "young",
                        ifelse(age <= 59, "middle", "old")))

table(welfare$ageg)

qplot(welfare$ageg)

# 연령대별 월급 평균표
ageg_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg) %>%
  summarise(mean_income = mean(income))

ageg_income

# 그래프 만들기
# + scale_x_discrete(limits = c(" ", " ", " ")) : 그래프에서 x 축 항목 순서 변경
ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) + geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))


# 성별 월급 차이는 연령대별로 다를까?

# 연령대 및 성별 월급 평균표 만들기

sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg, sex) %>%
  summarise(mean_income = mean(income))

sex_income

# 그래프 만들기
# fill = : 색깔로 항목 구분

ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))

# 성별 막대 분리
# geom_col(position = "dodge")

ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col(position = "dodge") +
  scale_x_discrete(limits = c("young", "middle", "old"))

# 성별 연령별 월급 평균표 만들기
sex_age <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age, sex) %>%
  summarise(mean_income = mean(income))

head(sex_age)

# 그래프 만들기
# col =  : 선그래프에서 항목 분리

ggplot(data = sex_age, aes(x = age, y = mean_income, col = sex)) +
  geom_line()

# 직업별 다를까?
# 변수 만들기
class(welfare$code_job)

table(welfare$code_job)

# 직업분류코드 목록 불러오기
library(readxl)

list_job <- read_excel("./Data/Koweps_Codebook.xlsx", col_names = T, sheet = 2)

head(list_job)

# welfare에 직업명 결합
welfare <- left_join(welfare, list_job, id = "code_job")

welfare %>%
  filter(!is.na(code_job)) %>%
  select(code_job, job) %>%
  head(10)

# 직업별 월급 평균표 만들기
job_income <- welfare %>%
  filter(!is.na(job) & !is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income))

head(job_income)

# 상위 10개 추출

top10 <- job_income %>%
  arrange(desc(mean_income)) %>%
  head(10)

top10

# 그래프 만들기
# coord_flip() : x,y 축 바꾸기 
ggplot(data = top10, aes(x = reorder(job, mean_income), y= mean_income)) +
  geom_col() +
  coord_flip()

# 하위 10위 추출
bottom10 <- job_income %>%
  arrange(mean_income) %>%
  head(10)

bottom10

# 그래프 그리기

ggplot(data = bottom10, aes(x = reorder(job, mean_income),
                            y= mean_income)) +
  geom_col() +
  coord_flip() +
  ylim(0, 800)

# 성별로 어떤 직업이 많을까?

# 성별 빈도표 만들기
# 남성 직업 빈도 상위 10개 추출
job_male <- welfare %>%
  filter(!is.na(job) & sex == "male") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)

job_male

# 여성 직업 빈도 상위 10개 추출

job_female <- welfare %>%
  filter(!is.na(job) & sex == "female") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)

job_female

# 그래프 만들기
# 남성 직업 빈도 상위 10개
ggplot(data = job_male, aes(x = reorder(job, n), 
                            y = n)) +
  geom_col() +
  coord_flip()

# 여성 직업 빈도 상위 10개
ggplot(data = job_female, aes(x = reorder(job, n), 
                            y = n)) +
  geom_col() +
  coord_flip()

# 종교가 있는 사람들이 이혼을 덜 할까?

# 변수 검토
class(welfare$religion)

table(welfare$religion)

# 전처리

# 종교 유무 이름 부여
welfare$religion <- ifelse(welfare$religion ==1,
                           "yes", "no")
table(welfare$religion)
qplot(welfare$religion)

# 결혼 여부 변수 검토

class(welfare$marriage)

table(welfare$marriage)

# 이혼 여부 변수 만들기
welfare$group_marriage <- ifelse(welfare$marriage == 1, "marriage",
                                 ifelse(welfare$marriage == 3,
                                        "divorce", NA))

table(welfare$group_marriage)

table(is.na(welfare$group_marriage))

qplot(welfare$group_marriage)

# 종교 유무에 따른 이혼율 분석

# 종교 유무에 따른 이혼율 표 만들기
religion_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(religion, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 1)) # 소수점 1자리까지 표현

religion_marriage

# count() 활용
religion_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  count(religion, group_marriage) %>%
  group_by(religion) %>%
  mutate(pct = round(n/sum(n)*100, 1))

religion_marriage

# 이혼율 표 만들기
# 이혼 추출

divorce <- religion_marriage %>%
  filter(group_marriage == "divorce") %>%
  select(religion, pct)

divorce

ggplot(data = divorce, aes(x=religion, y=pct)) +
  geom_col()

# 연령대 및 종교 유무에 따른 이혼율 분석
# 연령대별 이혼율 표 만들기

ageg_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(ageg, group_marriage) %>%
  summarise(n= n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 1))

ageg_marriage

# count 활용
ageg_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  count(ageg, group_marriage) %>%
  group_by(ageg) %>%
  mutate(pct = round(n/sum(n)*100, 1))

ageg_marriage

# 초년 제외, 이혼 추출

ageg_divorce <- ageg_marriage %>%
  filter(ageg != "young" & group_marriage == "divorce") %>%
  select(ageg, pct)

ageg_divorce

# 그래프

ggplot(data = ageg_divorce, aes(x = ageg, y= pct)) +
  geom_col()

# 연령대, 종교유무, 결혼상태별 비율표 만들기
ageg_religion_marriage <- welfare %>%
  filter(!is.na(group_marriage) & ageg != "young") %>%
  group_by(ageg, religion, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 1))

ageg_religion_marriage

# 연령대 및 종교 유무별 이혼율 표 만들기
df_divorce <- ageg_religion_marriage %>%
  filter(group_marriage == "divorce") %>%
  select(ageg, religion, pct)

df_divorce

# 그래프

ggplot(data = df_divorce, aes(x = ageg, y= pct, fill = religion)) +
  geom_col(position = "dodge")

# 노년층이 많은 지역은 어디일까?

# 변수 검토
class(welfare$code_region)

table(welfare$code_region)

# 지역 코드 목록 만들기

list_region <- data.frame(code_region = c(1:7),
                          region = c("서울",
                                     "수도권(인천/경기)",
                                     "부산/경남/울산",
                                     "대구/경부",
                                     "대전/충남",
                                     "강원/충북",
                                     "광주/전남/전북/제주도"))
list_region

# welfare 지역명 변수 추가

welfare <- left_join(welfare, list_region, id= "code_region")

welfare %>%
  select(code_region, region) %>%
  head()

# 지역별 연령대 비율표 만들기

region_ageg <- welfare %>%
  group_by(region, ageg) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 2))

head(region_ageg)

# 그래프
ggplot(data = region_ageg, aes(x = region, y= pct, fill = ageg)) +
  geom_col() +
  coord_flip()

# 막대 정렬 : 노년층 비율 높은 순
list_order_old <- region_ageg %>%
  filter(ageg == "old") %>%
  arrange(pct)

list_order_old

# 지역명 순서 변수 만들기
order <- list_order_old$region
order

# 그래프 

# 연령대 순으로 막대 색깔 나열
# factor라는 범주형 type으로 만들면 levels 함수에 표시가 된다.
# * 일반 문자 형태여도 기능상으로는 큰 차이가 없다.
class(region_ageg$ageg)

levels(region_ageg$ageg)

region_ageg$ageg <- factor(region_ageg$ageg,
                           level = c("old", "middle", "young"))

class(region_ageg$ageg)

levels(region_ageg$ageg)

# 그래프

ggplot(data = region_ageg, aes(x = region, y= pct, fill = ageg)) +
  geom_col() +
  coord_flip()