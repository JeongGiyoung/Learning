# dir()
# getwd()
# setwd()
# 파일 확인 단계
# subset()
# 데이터 형 변환
# 컬럼명 정리
# paste()
# 필요한 컬럼만 모아서 별도의 데이터셋 제작
# 필드명 번호 추출
# 조건에 맞는 자료만 필터링
# unique()
# 자료셋을 새로 제작해서 csv로 저장하기
# rownames 
# csv 파일로 저장하기
# 시도명별 csv 파일 저장하기
##################################
dir()
getwd()
setwd("C:/Sources/StudyR/day3")
dir()
fileName = "전국무인교통단속카메라표준데이터.csv"

df=read.csv(fileName)
tmp=subset(df, 시도명=='01')
tmp

df$시도명 = factor(df$시도명)
df$시군구명 = factor(df$시군구명)
df$시도명
df$시군구명

df[,3]=factor(df[,3])
df[,4]=factor(df[,4])
df[,5]=factor(df[,5])
head(df[,3:5])

df$설치연도Factor=factor(df$설치연도)
head(df$설치연도Factor)

df[,25] = factor(df$제한속도)
head(df[,25])

ma=df$제한속도
ma
ncol(ma)
nrow(ma)
length(ma)
mean(ma)

head(df[,c(1,25)])
names(df)[1]='카메라Num'
names(df)[25]='제한속도factor'
names(df)

names(df)[1]=paste(names(df)[1],'-bu',sep='')
str(df)

df1=df[,c(2,3,4,7,11,13,14,16)]
str(df1)

sido=unique(df1$시도명)
sido
index=1
tmp=subset(df1,시도명==sido[index])
head(tmp)

length(sido)

for (index in 1:21){
	tmp=subset(df1,시도명==sido[index])
	fileName=paste('./저장/', sido[index], '.csv', sep='')
	write.csv(tmp,fileName)
	}
##################################

# 현재 작업 디렉토리에 있는 파일 확인
dir()

# 현재 작업 디렉토리 경로 확인
getwd()

# 새로운 작업디렉토리 지정하기
setwd("C:/Sources/StudyR/day3")

dir()

# 파일 확인 단계
fileName = "전국무인교통단속카메라표준데이터.csv"

df=read.csv(fileName)

head(df)

str(df)

table(df$시도명)

barplot(table(df$시도명))

# subset() 
# 필드명 중에 01 이 보여서 어디 시군구인지 확인해야 한다.

head(subset(df, 시도명=='01'))

tmp=subset(df, 시도명=='01')

str(tmp)

# 시군구명이 과연 '서초구' 있나 확인하는 3가지 방법

summary(tmp$시군구명)
table(tmp$시군구명)
unique(tmp$시군구명)

# 01은 서초구로 확인되서 '서울특별시'라고 바꿔줘야한다.

# 마찬가지로 01,03,10,9도 확인

tmp=subset(df, 시도명=='10')
str(tmp)

summary(factor(tmp$소재지지번주소))
table(factor(tmp$소재지지번주소))
unique(factor(tmp$소재지지번주소))

##################################
### 데이터 형 변환
### 1. character를 factor로 변환
###    * 시도명, 시군구명, 도로종류, 도로노선명 등
### 2. 숫자를 factor로 변환하는 파생변수
       * 설치연도, 제한속도 등

df$시도명 = factor(df$시도명)
df$시군구명 = factor(df$시군구명)

# 위 작업을 인덱싱으로 진행하려면

df[,3]=factor(df[,3])
df[,4]=factor(df[,4])
df[,5]=factor(df[,5])
str(df)

summary(df)
levels(df[,3])

##################################
# 숫자를 factor로 변환하는 파생변수(변수 추가)

df$설치연도Factor=factor(df$설치연도)

df[,25] = factor(df$제한속도)
str(df)

summary(df)
plot(df[,24])
table(df[,25])
table(df[,24])

####################################
복습용 교재 p.176 매트릭스 구조가 필요한 이유

str(df)

ma=df$제한속도 
ma
ncol(ma)
nrow(ma)
length(ma)
mean(ma)


##############################

ma=df[,c(10:11)]
head(ma)
colSums(ma)
rowSums(ma)

##########################
2. 컬럼명 정리
# names(df) 작업했어서 인덱싱 번호에다가 컬럼명 변경
# names(df)=c('',''),....

names(df)[1]='카메라Num'
names(df)[25]='제한속도factor'
names(df)

# R은 문장열 연결 연산자(+)는 작동하지 않는다.
names(df)[1]=names(df)[1]+'bu'

# paste()
# paste( , sep='') : 띄어쓰기 없애기

#예시
paste('e','k', sep='')

names(df)[1]=paste(names(df)[1],'-bu',sep='')
str(df)

#################################
3. 필요한 컬럼만 모아서 별도의 데이터셋 제작
# 첫번째 : 불필요한 컬럼을 제거함으로서 수행속도를 높임
# 두번째 : 분석하고자 하는 내용에 맞게끔 새로운 데이터프레임 구성

# 필드명 번호 추출
names(df)

df1=df[,c(2,3,4,7,11,13,14,16)]
str(df1)

# 위경도로 지도 그리고 싶다면
df2=df[,c(10,11,13,14)]
head(df2)

#########################
4. 조건에 맞는 자료만 필터링
# subset으로

str(df1)

# 미션. 단속구분을 unique하게 받기

unique(df1$단속구분)

head(df1$단속구분)

# subset 을 이용하여서 단속구분이 1인 자료만 필터링 해보기

head(subset(df1, 단속구분=='1'))

# subset 을 이용하여서 제한속도가 50인 자료만 필터링 해보기

head(subset(df1, 제한속도==50))

# subset 을 이용하여서 단속구분이 1제외하고 필터링

head(subset(df1, 단속구분!=1))

# subset 을 이용하여서 단속구분이 1이면서(&) 시군구명이 '경기도'인 자료
# 교재 p.197 참조
# 두 개 중 한 개만 만족해도 되면 OR (|)

시도.경기도=subset(df1, 시도명=='경기도')

######################################
5. 자료셋을 새로 제작해서 csv로 저장하기

sido=unique(df1$시도명)
sido
index=1
tmp=subset(df1,시도명==sido[index])

# rownames 
head(tmp)출력했을 때 맨 왼쪽 열값 = 인덱스키

head(rownames(tmp))

# csv 파일로 저장하기

fileName=paste(sido[index], '.csv', sep='')
write.csv(tmp,fileName)

#############################
# 시도명별 csv 파일 저장하기

length(sido)

for (index in 1:21){
	tmp=subset(df1,시도명==sido[index])
	fileName=paste('./저장/', sido[index], '.csv', sep='')
	write.csv(tmp,fileName)
	}


