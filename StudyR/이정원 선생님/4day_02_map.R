# 지도 그래프 패키지 설치
# 미국 주별 범죄 데이터 준비
# USArrests 데이터는 기본 제공 데이터
# library(tibble) : 열 이름(변수명)을 지정하기 위해 필요한 라이브러리.
# <- rownames_to_column( , var = " ") : 행 이름을 state 변수로 바꿔 데이터 프레임 생성
# 미국 주 지도 데이터 준비
# 단계 구분도 만들기
# 인터랙티브 단계 구분도 : 그래프가 조금 더 깔끔하게

# 대한민국 시도별 인구 단계 구분도 만들기
# github에서 파일 다운받는 패키지
# 대한민국 지도 데이터 github에서 다운 받기
# 데이터를 UTF-8로 구성되어 있을 때, 안전하게 다시 CP949 인코딩으로 변환해주는 명령
# 위경도 정보 데이터 인코딩 바꾸기
# 단계 구분도 만들기 
# 그래프가 제대로 안나오면 ggplot2 라이브러리 장착을 한 번 더한다.

# 대한민국 시도별 결핵 환자 수 단계 구분도
# tooltip = name : 지도 위에 표시할 지역명(안나오는 경우도 있다.)


#####################################
#####################################

# 지도 그래프 패키지 설치
install.packages("ggiraphExtra")

library(ggiraphExtra)

# 미국 주별 범죄 데이터 준비
# USArrests 데이터는 기본 제공 데이터

str(USArrests) 

head(USArrests)

# library(tibble) : 열 이름(변수명)을 지정하기 위해 필요한 라이브러리.

library(tibble)

# <- rownames_to_column( , var = " ") : 행 이름을 state 변수로 바꿔 데이터 프레임 생성
crime <- rownames_to_column(USArrests, var = "state")

head(crime)

# <- tolower() : 지도 데이터와 동일하게 맞추기 위해 state의 값을 소문자로 수정

crime$state <- tolower(crime$state)

str(crime)

# 미국 주 지도 데이터 준비
library(ggplot2)
states_map <- map_data("state")
str(states_map)

# 단계 구분도 만들기

ggChoropleth(data = crime, # 지도에 표현할 데이터
             aes(fill = Murder, # 색깔로 표현할 변수
                 map_id = state), # 지역 기준 변수
             map = states_map) # 지도 데이터터

# 인터랙티브 단계 구분도 : 그래프가 조금 더 깔끔하게

ggChoropleth(data = crime, # 지도에 표현할 데이터
             aes(fill = Murder, # 색깔로 표현할 변수
                 map_id = state), # 지역 기준 변수
             map = states_map, # 지도 데이터터
             interactive = T) # 인터랙티브

# 대한민국 시도별 인구 단계 구분도 만들기

install.packages("stringi")

# github에서 파일 다운받는 패키지
install.packages("devtools")

# 대한민국 지도 데이터 github에서 다운 받기
devtools::install_github("cardiomoon/kormaps2014")

library(kormaps2014)

# 데이터를 UTF-8로 구성되어 있을 때, 안전하게 다시 CP949 인코딩으로 변환해주는 명령
str(changeCode(korpop1))

library(dplyr)
korpop1 <- rename(korpop1,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동)

# 위경도 정보 데이터 인코딩 바꾸기
str(changeCode(kormap1))

# 단계 구분도 만들기
# 그래프가 제대로 안나오면 ggplot2 라이브러리 장착을 한 번 더한다. 

ggChoropleth(data = korpop1, # 지도에 표현할 데이터
             aes(fill = pop, # 색깔로 표현할 변수
                 map_id = code, # 지역 기준 변수
                 tooltip = name), # 지도 위에 표시할 지역명
             map = kormap1, # 지도 데이터 
             interactive = T) # 인터랙티브

# 대한민국 시도별 결핵 환자 수 단계 구분도
# tooltip = name : 지도 위에 표시할 지역명(안나오는 경우도 있다.)

str(changeCode(tbc))

ggChoropleth(data = tbc, # 지도에 표현할 데이터
             aes(fill = NewPts, # 색깔로 표현할 변수
                 map_id = code, # 지역 기준 변수
                 tooltip = name), #지도 위에 표시할 지역명(안나오는 경우도 있다.)
             map = kormap1, # 지도 데이터
             interactive = T) # 인터랙티브
