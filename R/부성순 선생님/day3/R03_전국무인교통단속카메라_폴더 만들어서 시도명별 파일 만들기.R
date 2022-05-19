# R에서 폴더를 생성하고 저장하는 방법
  * ifelse(dir.exists(' '), F, dir.create(' '))
# 시도명별 원하는 폴더에 csv 파일 저장하기
fileName=paste(sido[index], '.csv', sep='')
fileName

for (index in 1:21){
	tmp=subset(df1,시도명==sido[index])
	fileName=paste('./test/', sido[index], '.csv', sep='')
	write.csv(tmp,fileName)
	}
###############################################
###############################################
###############################################
dir()
getwd()
setwd("C:/Sources/StudyR/day3")
dir()
fileName = "전국무인교통단속카메라표준데이터.csv"

df=read.csv(fileName)

names(df)[1]=paste(names(df)[1],'-bu',sep='')
str(df)

ifelse(dir.exists('test'), F, dir.create('test'))

sido=unique(df1$시도명)
sido
index=1
tmp=subset(df1,시도명==sido[index])
head(tmp)

length(sido)

fileName=paste(sido[index], '.csv', sep='')
fileName

for (index in 1:21){
	tmp=subset(df1,시도명==sido[index])
	fileName=paste('./test/', sido[index], '.csv', sep='')
	write.csv(tmp,fileName)
	}



#######################

# R에서 폴더를 생성하고 저장하는 방법
  * dir.exists 는 폴더명이 존재하는지 여부를 T,F 형태로 리턴하는 함수
  * dir.create는 작은 따옴표 안의 폴더명으로 폴더명 생성하는 함수 
  * ifelse 구문으로 폴더명 확인 후 없으면 create하는 구문 실행
  * write.csv로 해당 경로에 파일 저장
###################
## ifelse(dir.exists('폴더명'), F, dir.create('폴더명'))
## write.csv('저장하고 싶은 파일,폴더명/저장할 파일명.csv')
###################

# ifelse 구문으로 폴더명 확인 후 없으면 create하는 구문 실행

dir.exists('test')
dir.create('test')

ifelse(dir.exists('test'), F, dir.create('test'))

# write.csv로 해당 경로에 파일 저장

sido=unique(df1$시도명)
sido

tmp=subset(df1,시도명==sido[index])
head(tmp)

write.csv(tmp, './test/test01.csv')

# 시도명별 원하는 폴더에 csv 파일 저장하기

sido=unique(df1$시도명)
sido
index=1
tmp=subset(df1,시도명==sido[index])

fileName=paste(sido[index], '.csv', sep='')
fileName

for (index in 1:21){
	tmp=subset(df1,시도명==sido[index])
	fileName=paste('./test/', sido[index], '.csv', sep='')
	write.csv(tmp,fileName)
	}
