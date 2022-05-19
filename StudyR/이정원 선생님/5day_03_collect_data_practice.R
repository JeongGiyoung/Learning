install.packages("stringr")
install.packages("XML")
#####################################
#####################################
library(stringr)
library(XML)


open_api_url <- "http://apis.data.go.kr/6260000/DegreeOfAirPollutionService/getDegreeOfAirPollution?serviceKey=Dr7tAnPw7dYSBFS5VRSES3uMoLrwJP6h0SZ%2BCxaa%2Fh3%2BVoCQ6gIkUnm7%2B0l28jD%2Ff8lWBj6P7mWLXaQf7fsdYQ%3D%3D&numOfRows=5&pageNo=1"

open_api_url

# 오픈 API 통하여 XML 형식으로 자료 가져오기
raw.data <- xmlTreeParse(open_api_url,
                         useInternalNodes = TRUE,
                         encoding = "utf-8")
raw.data

# XML 형식의 자료를 데이터프레임으로 변경하기
# </item> 태그 별로 데이터 구분

busan_air_poll <- xmlToDataFrame(getNodeSet(raw.data, "//item"))

busan_air_poll

View(busan_air_poll)

#############################
# 국토교통부_(TAGO)_열차정보

api_url <- "http://apis.data.go.kr/1613000/TrainInfoService/getCtyAcctoTrainSttnList"

service_key <- "Dr7tAnPw7dYSBFS5VRSES3uMoLrwJP6h0SZ%2BCxaa%2Fh3%2BVoCQ6gIkUnm7%2B0l28jD%2Ff8lWBj6P7mWLXaQf7fsdYQ%3D%3D"

# 요청변수 등록
numOfRows <- "30"
cityCode <- "21"

# URL 주소를 공백없이 모두 묶기
open_api_url <- paste0(api_url, 
                       "?serviceKey=", service_key,
                       "&numOfRows=", numOfRows,
                       "&cityCode=", cityCode)

open_api_url

# 오픈 API 통하여 XML 형식으로 자료 가져오기
raw.data <- xmlTreeParse(open_api_url,
                         useInternalNodes = TRUE,
                         encoding = "utf-8")
raw.data

# XML 형식의 자료를 데이터프레임으로 변경하기
# </item> 태그 별로 데이터 구분

train <- xmlToDataFrame(getNodeSet(raw.data, "//item"))

train

View(train)
