# 이상치는 무엇인가요? 
# boxplot()
# 박스플롯 이용해서 확인하고 싶은 컬럼별로 이상치 확인하기
# 'Sat' 데이터를 박스플롯 이용해서 확인하고 싶은 컬럼별로 이상치 확인하기
# 이상치를 제거하고 다시 확인하기

############################################
############################################
############################################

str(tips)
boxplot(tip~day, data=tips)

# 'Sat' 데이터를 박스플롯 이용해서 확인하고 싶은 컬럼별로 이상치 확인하기

tmp=subset(tips, day=='Sat')

par(mfrow=c(2,2))

boxplot(tip~size, data=tmp)
boxplot(tip~sex, data=tmp)
boxplot(tip~smoker, data=tmp)
boxplot(tip~time, data=tmp)

# 이상치를 제거하고 다시 확인하기

boxplot(tips$tip)
tt = subset(tips, tip<=5)
summary(tt)

boxplot(tt$tip)

############################################
############################################
############################################
# 이상치는 무엇인가요? 
  * 이상치(Outlier)는 수집한 데이터의 범위에서 많이 벗어난 값을 의미하며, 너무 작은 이상치와 너무 큰 이상치가 있습니다.
  * 이상치가 있다는 건 그 데이터에 오류가 있을 수 있다는 말이라 확인해야 하기 때문

# boxplot()
  * 박스플롯을 이용해 이상치 확인하기
  * 현재 'Sat', 'Thur'에 데이터들 중 이상치가 많다는 걸 확인

str(tips)
boxplot(tip~day, data=tips)

# 'Sat' 데이터를 박스플롯 이용해서 확인하고 싶은 컬럼별로 이상치 확인하기

tmp=subset(tips, day=='Sat')

par(mfrow=c(2,2))

boxplot(tip~size, data=tmp)
boxplot(tip~sex, data=tmp)
boxplot(tip~smoker, data=tmp)
boxplot(tip~time, data=tmp)

# 'Thur' 데이터를 박스플롯 이용해서 확인하고 싶은 컬럼별로 이상치 확인하기

tmp=subset(tips, day=='Thur')

boxplot(tip~size, data=tmp)
boxplot(tip~sex, data=tmp)
boxplot(tip~smoker, data=tmp)
boxplot(tip~time, data=tmp)

# 이상치를 제거하고 다시 확인하기

boxplot(tips$tip)
tt = subset(tips, tip<=5)
summary(tt)

boxplot(tt$tip)
