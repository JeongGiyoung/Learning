dir()
setwd("C:/Sources/StudyR/day5/2022-01-28(금)_미션_데이터전처리/data_r")
dir()

# csv 파일 부를 때 참고사항
help(read.csv)


##################################
### 미션 1-1. 데이터 읽기전 메모리 모두 제거

# 메모리 제거

rm(list=ls())

# 메모리에 있는 변수 확인(메모리 제거가 잘 되었는지 확인용)

ls()

df=read.csv('./cust_order_data.csv',sep='\t',encoding='ANSI', stringsAsFactors = TRUE)

############
### 미션 1-2. 총데이터의 갯수와 변수 성격 확인

# 총데이터의 갯수 (행과 열의 갯수 확인)

dim(df)

# 각 변수의 성격 확인

str(df)

# 위로 3개의 자료만 읽기

head(df)

# 변수명(필드명)만 출력

names(df)

### [미션. 1-3] 아래의 2개 변수(필드)외에 나머지 변수에 대하여 해석
# CUST_SERIAL_NO: 고객번호 / SEX: 고객성별

#  AGE : 문자열, 10부터 100까지 10단위로 데이터 구성
summary(df$AGE)
table(df$AGE)

# REG_DATE : 문자열, 6월부터 12월까지 매월 11일 자료, 1월부터 12월까지 매월 12일 자료
summary(df$REG_DATE)
table(df$REG_DATE)

# ORDER_DATE : 문자열, 2011년 7월 14일부터 2012년 8월 8일까지 자료
summary(df$ORDER_DATE)
table(df$ORDER_DATE)

# ORDER_HOUR : 문자열, [0,3[ 부터 [9,12[ 까지 3단위
head(df)
df$ORDER_HOUR
summary(df$ORDER_HOUR)
table(df$ORDER_HOUR)

# ORDER_WEEKDAY : 문자열, 월~일
summary(df$ORDER_WEEKDAY)
table(df$ORDER_WEEKDAY)

# IS_WEEKEND : 논리연산, True/False
summary(df$IS_WEEKEND)
head(df$IS_WEEKEND)
table(df$IS_WEEKEND)

# GOODS_CODE : 정수값, 20001~20981
str(df$GOODS_CODE)
summary(df$GOODS_CODE)
table(df$GOODS_CODE)

# LGROUP : 정수값, 10~85
str(df$LGROUP)
summary(df$LGROUP)
table(df$LGROUP)

# MGROUP : 정수값, 1~14
str(df$MGROUP)
summary(df$MGROUP)
table(df$MGROUP)

# SGROUP : 정수값, 1~27
str(df$SGROUP)
summary(df$SGROUP)
table(df$SGROUP)

# DGROUP : 정수값, 1~26
str(df$DGROUP)
summary(df$DGROUP)
table(df$DGROUP)

# GOODS_NAME : 문자열, 
str(df$GOODS_NAME)
summary(df$GOODS_NAME)
table(df$GOODS_NAME)

# PRICE : 정수값, 0~3979500 
str(df$PRICE)
summary(df$PRICE)
table(df$PRICE)

# QTY : 정수값, 1~10
str(df$QTY)
summary(df$QTY)
table(df$QTY)

##################################
### [Part2] 자료 오류 확인

str(df)

# age, oder_hour 값이 숫자값으로 바뀌면 더 좋겠다.
# 상품명(goods_name)이 통일되면 좋겠다.
 
#############
### [미션. 2-1] 결측치 확인 (참고R교재 33p-34p)

# df의 전체 결측치 갯수 확인 

sum(is.na(df))

# 각 변수별 결측치 갯수 확인

colName=names(df)
cnt=length(colName)

for (i in 1:cnt){
	print(colName[i])
	print(sum(is.na(df[,i])))
}

#############
### [미션. 2-2] 결측치 활용법 (참고교재 P35)

# GOODS_NAME값의 '#NAME?'를 NA로 대체하고 제거하기 위하여

# df$GOODS_NAME을 summary 하여서 #NAME?가 있는지를 확인하여 봄

summary(df$GOODS_NAME)
table(df$GOODS_NAME)

# df$GOODS_NAME 에 자료가 '#NAME?' 인 자료만 subset으로 추출하여서 제거해도 되는 자료인지 확인하여 봄
subset(df, GOODS_NAME=='#NAME?')

GN.N = subset(df, GOODS_NAME=='#NAME?')
head(GN.N)
str(df)

# df$GOODS_NAME의 '#NAME?' 인 자료를 'NA' 로 변환하기전,
# df$GOODS_NAME 의 NA갯수 확인   (참고교재 32p의 2번)

str(GN.N)

# --[코드작성] df$GOODS_NAME의 값이 #NAME?  인 자료에 NA값 할당

#-- [코드작성] df$GOODS_NAME 의 NA갯수 확인 
summary(GN.N)
summary(df)

# -- [코드작성] 결측치 시각화

library(Amelia)