# [데이터(자료) 파악 : 변수의 성격과 해설]
# install.packages('reshape2')
# library(reshape2)
# 데이터(자료) 파악 : 변수의 성격과 해설
# sum(is.na())
  * 결측치 확인
# unique() 
  * unique 명령어로 필드별로 데이터 변수 파악
# 가설과 검증
  * 일반적인 가설검증은 데이터집계를 통해서 비교
# table()
  * 빈도수 구하기
    - 빈도수 : 전체데이터에서 발생횟수
# for문을 이용해 기준이 될(명목형 변수) 컬럼들을 빈도수 집계내기.
# 시간대 별 빈도수 확인
# colMeans()
  * 총 금액, 팁, 인원수 별 평균값
# colSums()
  * 총 금액, 팁, 인원수 별 합계
# plot()
  * 시간대별 빈도수 시각화
# plot(  , main=' ')
  * 차트 제목 부여

#####################################
#####################################
# install.packages('reshape2')
install.packages('reshape2')
#####################################
# library(reshape2)
library(reshape2)

tips

# total_bill : 전체 지불비용
# tip : tip비용
# sex : 성별
# smoker : 흡연석/비흡연석
# day : 요일
# time : 방문시간
# size : 방문인원

# sum(is.na())

sum(is.na(tips))

# unique() 

unique(tips[,3])

# table()

table(tips[,3])

# for문을 이용해 기준이 될(명목형 변수) 컬럼들을 빈도수 집계내기.

for(i in 3:7){
	print(table(tips[,i]))
	}

# 시간대 별 빈도수 확인

din=subset(tips,time=='Dinner')
lun=subset(tips,time=='Lunch')

table(tips$time)
table(din$day)
table(lun$day)

# 총 금액, 팁, 인원수 별 평균값

head(din)

table(tips$time)

colMeans(din[c('total_bill','tip','size')])
colMeans(lun[c('total_bill','tip','size')])

# 총 금액, 팁, 인원수 별 합계

colSums(din[c('total_bill','tip','size')])
colSums(lun[c('total_bill','tip','size')])


# 시간대별 빈도수 시각화

par(mfrow=c(2,1))
plot(din$tip)
plot(lun$tip)


#####################################
#####################################
#####################################
# 데이터(자료) 파악 : 변수의 성격과 해설
######################################

#####################################
# install.packages('reshape2')
# library(reshape2)
  * tips 자료 불러오고 싶을 때 쓰는 명령어
  * 한 번 install 하면 library명령어만 쓰면 된다.

library(reshape2)
#####################################
head(tips)

str(tips)

# total_bill : 전체 지불비용
# tip : tip비용
# sex : 성별
# smoker : 흡연석/비흡연석
# day : 요일
# time : 방문시간
# size : 방문인원

######################################
# sum(is.na(tips))
  * 결측치 확인

sum(is.na(tips))

# unique() 
  * unique 명령어로 필드별로 데이터 변수 파악

unique(tips[,3])

########################################
### 가설과 검증
########################################

# 1번 가설 : 성별(독립변수,x값)에 따르는 tips(종속변수,y값,레이블)의 비용은 같다.
  * 0가설(귀무가설)
     - 검증을 통해서 비용은 같다 => 귀무가설 채택
     - 비용이 다르다 => 귀무가설 기각/대립가설 선택
     - pvalue 통해서 확인한다.(통계에서는)

# 일반적인 가설검증은 데이터집계를 통해서 비교

# table()
  * 빈도수 구하기
    - 빈도수 : 전체데이터에서 발생횟수

table(tips[,3])

# for문을 이용해 기준이 될(명목형 변수) 컬럼들을 빈도수 집계내기.

for(i in 3:7){
	print(table(tips[,i]))
	}

# 시간대 별 빈도수 확인

din=subset(tips,time=='Dinner')
lun=subset(tips,time=='Lunch')

table(tips$time)
table(din$day)
table(lun$day)

# 총 금액, 팁, 인원수 별 평균값

head(din)

table(tips$time)

colMeans(din[c('total_bill','tip','size')])
colMeans(lun[c('total_bill','tip','size')])

# 총 금액, 팁, 인원수 별 합계

colSums(din[c('total_bill','tip','size')])
colSums(lun[c('total_bill','tip','size')])


# 시간대별 빈도수 시각화

par(mfrow=c(2,1))
plot(din$tip)
plot(lun$tip)

# 

summary(lun)
subset(lun, tip >= 4)

tmp=(subset(lun, tip >= 4))
summary(tmp)

summary(lun)


subset(tips, tips$day=='Fri')

summary(subset(tips, tips$day=='Fri'))

tmp=subset(tips, tips$day=='Fri')

table(tmp$size)

# 성별에 따라 tip의 차이가 없다(가설)
  * 성별 tips 빈도수 확인
  * summary() 로 수치 확인
  * 시각화

table(tips$sex)
혹은
table(tips[,3])

s.F=subset(tips,sex=='Female')
s.M=subset(tips,sex=='Male')

summary(s.F)
summary(s.M)

plot(s.F$tip)
plot(s.M$tip)

# 차트 제목 부여

plot(s.F$tip, main='Tips by F')
plot(s.M$tip, main='Tips by M')

# 

plot(s.F$size, main='F by size')
plot(s.M$size, main='M by size')

# 교재 p.317 예제 풀어보기