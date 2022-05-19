# 변수 = c()
# 산점도
# plot()
# as.factor()
# pie()
# data.frame()
# strsplit()
# factor() 구조 연습문제

# 스크립트 창에서 작성한 코드는 커서를 그 줄에 두고 ctrl+R 또는 F5
# 여러줄 명령은 블럭지정 후 Ctrl+R 또는 F5
3+4
View(a)

# 파이썬에서는
#  * 직업명 =  [' ', ' ']
# R에서는
#  * 직업명 = c(' ', ' ')

직업명=c('데이터과학자','엔지니어','엔지니어','세금관리자','분석관리자')
채용수=c(4184,2725,2599,3317,1958)
평균급여=c(110,110,106,110,112)
직업만족도 = c(4.4, 4.0, 4.3, 4.0, 4.1)
직업명
str(직업명)
summary(직업명)
summary(채용수)
summary(평균급여)
summary(직업만족도)

# 산점도 : 데이터가 얼마나 가까이에 있는지

#  ** plot(직업명) 하면 처리를 못한다.

plot(평균급여)

직업명fa=as.factor(직업명)
직업명

# 중복되지 않는 unique값
직업명fa

summary(직업명fa)
plot(직업명fa)

# 원형 차트
pie(평균급여)

# data.frame()

data=data.frame(직업명, 채용수, 평균급여, 직업만족도)
data
str(data)
summary(data)
plot(data)

-----------------------------------------

# R에서는 명목형 변수의 factor가 있음
# 자료형 확인 str(변수명)으로 확인가능
# factor는 자료 split(=글자 나누기) 안되지만, 유니크한 레벨을 갖고 있음.
# =>plot() 했을 때 count 집계가 가능함.

# as.factor(변수) : 문자자료를 factor로 변경하는 방법


# strsplit(변수, 글자를 나눌 기준)
a = 'python/r/cobol/r'
strsplit(a,"/")
tmp=strsplit(a,"/")
tmp
tmp[[1]][2]
plot(a) # 에러
tmp[[1]]

a = c('python/r/cobol/r', 'aa/b/b/c')
tmp=strsplit(a,"/")
tmp
summary(tmp)

a = c('파이선, 데이터분석가, 인공지능','R, 데이터분석가, 빅데이터')
tmp=strsplit(a,",")
tmp
summary(tmp)

tmpAsFactor=as.factor(tmp[[1]][1])
unlist(tmp) # C() 안에 ' ' , ' '에서 쉼표로 구분을 하지 않겠다는 명령어
summary(unlist(tmp))

tmp1 = unlist(tmp)
tmp2 = as.factor(tmp1)
summary(tmp2)
plot(tmp2)
str(tmp2)


# 팩터와 리스트의 차이를 알기
# levels 와 unique 명령어의 차이점
#  * unique 역시 중복값을 삭제하는 명령어
#  * levels 는 출력 순서를 조정할 수 있다.
# R levels 변경 구글링 해보기

---------------------------------
# factor() 구조 연습문제
# [교재 p.135 연습문제]

# bt 정의
bt <- c('A','B','B','O','AB','A')
bt
bt[5]

# 팩터 bt.new 정의

bt.new <- factor(bt)
bt
bt.new

# 벡터 bt의 5 번째 값 출력
bt[5]

# 펙터 bt.new 5 번째 값 출력
bt.new[5]

#팩터에 저장된 값의 종류를 출력
levels(bt.new)

# 팩터의 문자값을 숫자로 바꾸어 출력
bt.new[7]

# 팩터의 문자값을 숫자로 바꾸어 출력
as.integer(bt.new)

# 팩터 bt.new의 7 번쨰에 'B' 저장
bt.new[7] <- 'B'
bt.new[8] <- 'C'
bt.new