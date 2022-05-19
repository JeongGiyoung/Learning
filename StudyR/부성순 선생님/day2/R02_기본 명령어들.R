# read없는 자료는 내장자료 불러오기
# 위로 5개 자료를 보고 싶다면
# 위로 3개 자료를 보고 싶다면
# summary : 각 column 별 최소,중간,평균,최대 값 보기
# plot() : 데이터 수치 산점도
# factor() : 같은 것끼리(명목형 변수별) 묶는 것(그룹)
# names() : 명목형 변수 추출
# leves() : names 명령어와 비슷하지만 표시 순서를 바꿀 수 있게 하는 명령어
# unique() : 위에 있는 데이터부터 중복 자료 삭제하면서 출력
# names, levels, unique 은 비슷한 명령어
# split(자료, 기준) 작업하면 리스트화 된다.
# cyl의 개수가 4개인 자료 중에서 am별로 다시 나누기

############################################
mtcars 

str(mtcars)

head(mtcars,3) 

summary(mtcars)

plot(mtcars$mpg)

factor(mtcars$cyl)
summary(factor(mtcars$cyl)) 

names(summary(factor(mtcars$cyl)))

levels(factor(mtcars$cyl)) 

unique(mtcars$cyl) 

tmp = summary(factor(mtcars$cyl))
tmp
names(tmp) = c('cyl:4', 'cyl:6', 'cyl:8')
tmp
str(tmp)
tmp[1]

split(mtcars, mtcars$cyl)
tmp=split(mtcars, mtcars$cyl)

str(tmp)
tmp[[1]]

split(tmp[[1]],tmp[[1]]$am) 
############################################

# R 에는 내장데이터를 많이 제공
# 자동차 연비와 관련된 mtcars

# read없는 자료는 내장자료 불러오기
mtcars 

str(mtcars)

# 위로 5개 자료를 보고 싶다면
head(mtcars) 

# 위로 3개 자료를 보고 싶다면
head(mtcars,3) 

# summary : 각 column 별 최소,중간,평균,최대 값 보기
summary(mtcars)

# plot() : 데이터 수치 산점도
plot(mtcars$mpg)


# factor() : 같은 것끼리(명목형 변수별) 묶는 것(그룹)
factor(mtcars$cyl)
summary(factor(mtcars$cyl)) 

# names() : 명목형 변수 추출
names(summary(factor(mtcars$cyl))) 

# leves() : names 명령어와 비슷하지만 표시 순서를 바꿀 수 있게 하는 명령어
levels(factor(mtcars$cyl)) 

# unique() : 위에 있는 데이터부터 중복 자료 삭제하면서 출력
unique(mtcars$cyl) 

# names, levels, unique 은 비슷한 명령어

tmp = summary(factor(mtcars$cyl))
tmp
names(tmp) = c('cyl:4', 'cyl:6', 'cyl:8')
tmp
str(tmp)
tmp[1]

# split(자료, 기준) : mtcars 데이터들 중에 cyl 컬럼의 값별로 리스트화
split(mtcars, mtcars$cyl)

tmp=split(mtcars, mtcars$cyl)
str(tmp)
tmp[[1]]

# cyl의 개수가 4개인 자료 중에서 am별로 다시 나누기
split(tmp[[1]],tmp[[1]]$am) 