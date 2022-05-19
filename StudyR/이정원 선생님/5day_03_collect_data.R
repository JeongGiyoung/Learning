# 자료수집 
# 1.파일 데이터 셋 2.웹 스크랩핑 3.오픈 API 이용

# 주요 빅데이터 제공기관 : "주요 빅데이터 제공기관.txt" 참조


# 1.파일 데이터
getwd()

data <- read.csv("./Data/전라남도_목포시_장애인_복지시설_20210802.csv",
                 header = T,
                 fileEncoding="EUC-KR")

data

# 2.웹 스크랩핑

# 웹 스크랩핑 패키지
install.packages("rvest")

# 문자열 처리 패키지
install.packages("stringr")

library(rvest)
library(stringr)

# 웹 스크래핑 순서
# 대상 URL 할당 - 웹 문서 자겨오기 - 특정 태그의 데이터 추출 - 데이터 정제(전처리) - 데이터 프래임 만들기

# 중고차매매 사이트(보배드림) 정보 가져오기
# https://www.bobaedream.co.kr/
# 크롬 - F12

# 1. 대상 URL 할당
# http 다음에 s가 없어야 한다.

url <- "http://www.bobaedream.co.kr/cyber/CyberCar.php?gubun=K&page=1"

# 2. 웹 문서 가져오기
usedCar <- read_html(url)
usedCar

# 3. 태그의 데이터 추출
# 가져온 usedCar에서 css 가 ".product-tiem"인 것을 참음.

carInfos <- html_nodes(usedCar, css=".product-item")

head(carInfos)

# 차량 명칭 추출
title_tmp <- html_nodes(carInfos, css=".tit.ellipsis")
title_tmp

title <- html_text(title_tmp)
title

# 4. 데이터 정제
title <- str_trim(title) # 문자열에서 공백 제거
title

# 차량 연식 추출
year_tmp <- html_nodes(carInfos, css=".mode-cell.year")
year_tmp

year <- html_text(year_tmp)
year

year <- str_trim(year)
year

# 연료 구분

fuel_tmp <- html_nodes(carInfos, css=".mode-cell.fuel")
fuel_tmp

fuel <- html_text(fuel_tmp)
fuel

fuel <- str_trim(fuel)
fuel

# 주행거리 추출

km_tmp <- html_nodes(carInfos, css=".mode-cell.km")
km_tmp

km <- html_text(km_tmp)
km

km <- str_trim(km)
km

# 판매가격 추출

price_tmp <- html_nodes(carInfos, css=".mode-cell.price")
price_tmp

price <- html_text(price_tmp)
price

price <- str_trim(price)
price

price <- str_replace(price, '\n', '')
price

# 차량 명칭으로부터 제조사 추출
maker = c() # 비어있는 공간 만든다.
maker

title # 제조사가 차량 명칭 제일 앞에 있는 패턴이 있다.

# 제조사 이름 다음 띄어쓰기가 있는 패턴이 보여서 띄어쓰기를 기준으로 분리해서 첫번째 단어만 다시 maker 변수에 넣는다.

# unlist() : 리스트 형태가 아니라 쭉 나열한다.

for(i in 1:length(title)) {
  maker <- c(maker, unlist(str_split(title[i], ' '))[1])
}

maker

# 5. 데이터프레임 만들기
usedcars <- data.frame(title, year, fuel, km, price, maker)

View(usedcars)

# 4. 데이터 정제

# km 자료 숫자로 변경
usedcars$km

# gsub() : 문자열 변환. replace 함수와 비슷한 기능

usedcars$km <- gsub("만km", "0000", usedcars$km)
usedcars$km <- gsub("천km", "000", usedcars$km)
usedcars$km <- gsub("km", "", usedcars$km)
usedcars$km <- gsub("미등록", "", usedcars$km)

# 숫자형으로 변환
usedcars$km <- as.numeric(usedcars$km)

usedcars$km

# price 자료 숫자로 변경
usedcars$price

usedcars$price <- gsub("만원", "", usedcars$price)
usedcars$price <- gsub("계약", "", usedcars$price)
usedcars$price <- gsub("팔림", "", usedcars$price)
usedcars$price <- gsub("금융리스", "", usedcars$price)
usedcars$price <- gsub(",", "", usedcars$price)

usedcars$price <- as.numeric(usedcars$price)

usedcars$price

# 웹 스크래핑 자료 파일로 저장하기

getwd()
setwd("C:/Recture/Busan_202202_R/Data")

write.csv(usedcars, "usedcars_new.csv")


### 오픈 API 기반 자료 수집

# API 자료를 XML 형식으로 변경하는데 필요한 패키지

install.packages("XML")

library(XML)

# 공공데이터 포털에서 API 활용신청 후 다시 R로 돌아오기

# 웹사이트 URL 설정
api_url <- "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty"

service_key <- "Dr7tAnPw7dYSBFS5VRSES3uMoLrwJP6h0SZ%2BCxaa%2Fh3%2BVoCQ6gIkUnm7%2B0l28jD%2Ff8lWBj6P7mWLXaQf7fsdYQ%3D%3D"

# 요청변수 등록
numOfRows <- "30"
sidoName <- "경기"

sidoName <- URLencode(iconv(sidoName, to="UTF-8"))
sidoName

searchCondition <- "DAILY"

# paste와 paste0 의 차이

paste("a", "b", "c") #공백을 구분자로 묶기
paste("a", "b", "c", sep=" ") # 원래는 이 상태
paste("a", "b", "c", sep="/") # / 구분자로 묶기

paste0("a", "b", "c") # 구분자 없이 다 묶기

# URL 주소를 공백없이 모두 묶기
open_api_url <- paste0(api_url, 
                       "?serviceKey=", service_key,
                       "&numOfRows=", numOfRows,
                       "&sidoName=", sidoName,
                       "&searchCondition=", searchCondition)

open_api_url

# 오픈 API 통하여 XML 형식으로 자료 가져오기
raw.data <- xmlTreeParse(open_api_url,
                         useInternalNodes = TRUE,
                         encoding = "utf-8")
raw.data

# XML 형식의 자료를 데이터프레임으로 변경하기
# </item> 태그 별로 데이터 구분

air_pollution <- xmlToDataFrame(getNodeSet(raw.data, "//item"))

air_pollution

View(air_pollution)

# subset() : 데이터프레임 내에서 검색 조건(select)에 맞는 항목(컬럼)들만 가지고 온다.

air_pollution <- subset(air_pollution,
                        select = c(dataTime,
                                   stationName,
                                   so2Value,
                                   coValue,
                                   o3Value,
                                   no2Value,
                                   pm10Value))
View(air_pollution)

# API 자료 파일로 저장

getwd()

write.csv(air_pollution, "air_pollution_new.csv")