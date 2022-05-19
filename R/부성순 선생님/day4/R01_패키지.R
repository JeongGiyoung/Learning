# library()
  * 임의로 설치된 패키지를 R이 설치된 lib 폴더로 옮겨주는 명령어

# ?
  * 명령에 대한 설명이 보고 싶을 때 

# 명령어 써보기

# for() 
  * 일일이 쓰지 않고 자동화 
###############################################
###############################################
install.packages('cowsay')
###############################################
# library()

library(cowsay) 


# ?

?say

# 명령어 써보기

say('heoo', by='cat')

say('Hello World', by='ghost')

say('Hello World', by='ant')

# for() 

byNameList = c('cat', 'ghost','ant')

for (byName in byNameList){
	say('Hello World', by=byName)
	}

for (index in 1:length(byNameList)){
	say('Hello World', by=byNameList[index])
}
###############################################
##############상세한 설명
###############################################
# 임의로 설치된 패키지를 R이 설치된 lib 폴더로 옮겨주는 명령어
library(cowsay) 

# 명령어에 대해 설명 보기
?say

# 명령어 써보기
say('heoo', by='cat')

say('Hello World', by='ghost')

say('Hello World', by='ant')


# for() 
  * 일일이 쓰지 않고 자동화 

byNameList = c('cat', 'ghost','ant')

for (byName in byNameList){
	say('Hello World', by=byName)
	}

for (index in 1:length(byNameList)){
	say('Hello World', by=byNameList[index])
}
