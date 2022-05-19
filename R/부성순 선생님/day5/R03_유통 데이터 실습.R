dir()
getwd()
setwd("C:/Sources/StudyR/day5/2022-01-28(금)_미션_데이터전처리/data_r")
dir()

# 인터넷 자료를 읽을 수 없어서 선생님이 주신 자료로 사용. 
df = read.csv('./cust_order_data.csv',sep='\t', encoding='ANSI', stringsAsFactors = TRUE)
head(df)

# 일부 데이터에 값이 아닌 *가 들어가 있는 경우가 있어서 사용할 수 없는 데이터는 제거한다.

df <- df[df$SEX != "*",]

str(df)

head(df,10)

# 구매일자, 성별, 구매 건수만 추출하여 별도의 데이터 프레임을 만든다.

sex1 <- subset(df, select=c(ORDER_DATE,SEX,QTY))
sex1

# 구매일자에서 월 정보만 추출하기 위한 lubridate 라이브러리를 설치한다.

install.packages(‘lubridate')
library(lubridate)

# ORDER_DATE 열에 저장되어 있는 날짜를 이용하여 month 함수로 월만 추출해서 month 라는 새로운 열을 추가한다. 

sex2 <- cbind(sex1, month=month(sex1$ORDER_DATE))
head(sex2,5)

# 데이터 조작을 위해 reshape2 라이브러리를 설치한다.

install.packages('reshape2')
library(reshape2)

# 성별로 구분하여 월별 구매 건수의 총합을 구해서 확인한다.
dcast(sex2, SEX ~ month, value.var=“QTY", sum)

str(sex2)

# 