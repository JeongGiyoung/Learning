# 연습할 수 있는 기존 자료(iris)를 불러오기 
# column 명별 데이터를 불러오는 여러가지 방법
  * 1~2열 데이터
  * 1,3,5열 데이터
  * 1,5열 데이터를 필드 이름으로 출력
  * 행 1부터 5까지 값만 출력
  * 행 1부터 5까지, 열은 1,3 값만 출력

#######################################
iris

iris[,c(1:2)]

iris[,c(1,3,5)]

iris[,c("Sepal.Length","Species")]

iris[1:5,]

iris[1:5,c(1,3)]

#######################################
# 연습할 수 있는 기존 자료(iris)를 불러오기
iris

# 1~2열 데이터
iris[,c(1:2)]

# 1,3,5열 데이터
iris[,c(1,3,5)]

# 1,5열 데이터를 필드 이름으로 출력
iris[,c("Sepal.Length","Species")]

# 행 1부터 5까지 값만 출력
iris[1:5,]

# 행 1부터 5까지, 열은 1,3 값만 출력
iris[1:5,c(1,3)]