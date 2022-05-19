# memory.limit()
  * 현재 사용가능한 메모리
# ls()
  * 메모리에 저장된 값 모두 출력
# rm(list=ls())
  * R에서 메모리 초기화
# 데이터 로드 후 재작업해서 다시 로드
  * df의 1~9번 열만 df1 에 할당
  * df1 자료를 작업자료.csv 로 저장
  * 메모리 변수 모두 제거
  * df로 작업자료.csv 부르기
# rownames로 숫자가 매겨저 있기 때문에 뺀다.
# 기술통계
  * NA값 지우기
# NA값 확인
# 결측치 시각화 하기

###########################
패키지 설치가 안되어 있을 경우

install.packages('naniar')
install.packages('VIM')
install.packages('Amelia')
#################################

# 결측치(NA) 패키지 설치(install로 설치한 패키지는 R을 새로 켰을 때 제대로 작동을 안하면 다시 설치)
# 설치한 패키지 명령어를 이용해 시각화
# 다른 패키지 이용해보기
# 일반적으로 결측치 시각화 하는 패키지

#################################
# plot 창 저장하기

#################################
# 결측치 제거
#################################
# Freq 컬럼값 시각화 
# Freq 컬럼 퍼센트(%)으로 바꾸기

#################################
memory.limit()
ls()
rm(list=ls())

setwd("C:/Sources/StudyR/day3")
getwd()
dir()
df=read.csv("전국무인교통단속카메라표준데이터.csv", stringsAsFactors = TRUE)

df=df[-1]
head(df)

df1=df[,c(1:9)]

write.csv(df1, '작업자료.csv')

rm(list=ls())

read.csv('작업자료.csv', stringsAsFactors = TRUE)

df=read.csv('작업자료.csv', stringsAsFactors = TRUE)

sum(is.na(df[,1]))
sum(is.na(df[,2]))
sum(is.na(df[,3]))
sum(is.na(df[,4]))

colName=names(df)

cnt=length(colName)

for (i in 1:cnt){
	print(colName[i])
	print(sum(is.na(df[,i])))
}

naniar::vis_miss(df)

library(VIM); VIM::aggr(df)

library(Amelia)
missmap(df)

###########################################
savePlot("무인카메라결측치", type="png")
#############################

df=na.omit(df)
missmap(df)
str(df)

###########################
data.frame(table(df[,2]))
tableDf=data.frame(table(df[,2]))
names(tableDf)[1] = 'title'
tableDf

tableDf$Freq/sum(tableDf$Freq)*100
tableDf$pro=tableDf$Freq/sum(tableDf$Freq)*100
tableDf
###########################
############################
### # 현재 사용가능한 메모리
### # 메모리에 저장된 값 모두 출력
### # R에서 메모리 초기화
############################
# 현재 사용가능한 메모리
memory.limit()

# 메모리에 저장된 값 모두 출력
ls()

# 메모리 초기화

rm(list=ls())

################################
# 데이터 로드 후 재작업해서 다시 로드
################################

dir()
getwd()
setwd("C:/Sources/StudyR/day3")
df=read.csv(dir()[7], stringsAsFactors = TRUE)

head(df)
str(df)

# df의 1~9번 열만 df1 에 할당

df1=df[,c(1:9)]
head(df1)
summary(df1)

# df1 자료를 작업자료.csv 로 저장

write.csv(df1, '작업자료.csv')
dir()

# 메모리 변수 모두 제거

rm(list=ls())

# df로 작업자료.csv 부르기

read.csv('작업자료.csv', stringsAsFactors = TRUE)

df=read.csv('작업자료.csv', stringsAsFactors = TRUE)

# rownames로 숫자가 매겨저 있기 때문에 뺀다.
df=df[-1]

str(df)

################################
# 기술통계
  * NA값 지우기
################################

names(df)[2] ; str(names(df)[2])
summary(df[,2])

# 보기 좋게 출력
data.frame(summary(df[,2]))

data.frame(빈도수=summary(df[,2]))

# NA값 확인

summary(df)

sum(is.na(df[,1]))
sum(is.na(df[,2]))
sum(is.na(df[,3]))
sum(is.na(df[,4]))
...

혹은

# 결측치 시각화 하기

colName=names(df)

cnt=length(colName)

for (i in 1:cnt){
	print(colName[i])
	print(sum(is.na(df[,i])))
}

# 결측치(NA) 패키지 설치(install로 설치한 패키지는 R을 새로 켰을 때 제대로 작동을 안하면 다시 설치)

install.packages('naniar')

# 설치한 패키지 명령어를 이용해 시각화
naniar::vis_miss(df)

# 다른 패키지 이용해보기
install.packages('VIM')

library(VIM); VIM::aggr(df)

# 일반적으로 결측치 시각화 하는 패키지
install.packages('Amelia')
library(Amelia)
missmap(df)

# plot 창 저장하기

savePlot("무인카메라결측치", type="png")

# 결측치 제거
df=na.omit(df)
missmap(df)
str(df)


# Freq 컬럼값 시각화 

data.frame(table(df[,2]))
tableDf=data.frame(table(df[,2]))
names(tableDf)[1] = 'title'
tableDf

plot(tableDf)


# Freq 컬럼 퍼센트(%)으로 바꾸기

tableDf$Freq/sum(tableDf$Freq)*100
tableDf$pro=tableDf$Freq/sum(tableDf$Freq)*100
tableDf

str(df)

#### 다양한 table() 사용방법
data.frame(table(df[,4]))
tableDf=data.frame(table(df[,4]))
names(tableDf)[1] = 'title'
tableDf

tableDf$Freq/sum(tableDf$Freq)*100
tableDf$pro=tableDf$Freq/sum(tableDf$Freq)*100
tableDf

split(df$도로노선방향, df$시도명)
tmp=split(df$도로노선방향, df$시도명)

head(tmp,1)

tmp[[1]]

mean(tmp[[1]])

sapply(tmp,mean)

data.frame(sapply(tmp,mean))

tapply(df$도로노선방향, df$시도명, mean)

# 데이관리하는 명령어 모은 패키지
dply