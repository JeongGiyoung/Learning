# 특수 문자 제거 
# 대체할 문구에 공백(스페이스)이 없이 바꾸면 한글이 깨진다.
# 명사 추출
# 가사에서 명사추출
# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
# list(배열)란?  
# 벡터란? 

# 데이터 프레임으로 변환
# 변수명 수정
# 두 글자 이상 단어 추출
# 워드 클라우드 패키지 설치
# 패키지 로드
# 단어 색상 목록 만들기기
# 워드 클라우드 생성
# 단어 색상 바꾸기
######################
# 국정원 트윗 텍스트 마이닝
# 데이터 로드
# 변수명 수정
# 특수문자 제거
# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
# 데이터 프레임으로 전환
# 변수명 수정
# 트위에서 명사 추출
# 추출한 명사 list 를 문자열 벡터로 변환, 단어별 빈도표 생성
# 데이터 프레임으로 변환
# 변수명 수정
# 두 글자 이상으로 된 단어 추출, 빈도 상위 20개 단어 추출
# 단어 빈도 막대 그래프 만들기
# 워드 클라우드 만들기
# 색상 수정

#########################################################
#########################################################
library(KoNLP)

text <- "R은 통계 계산과 그래픽을 위한 프로그래밍 언어이자 소프트웨어 환경이자 프리웨어이다.[2] 뉴질랜드 오클랜드 대학의 로버트 젠틀맨(Robert Gentleman)과 로스 이하카(Ross Ihaka)에 의해 시작되어 현재는 R 코어 팀이 개발하고 있다. R는 GPL 하에 배포되는 S 프로그래밍 언어의 구현으로 GNU S라고도 한다. R는 통계 소프트웨어 개발과 자료 분석에 널리 사용되고 있으며, 패키지 개발이 용이해 통계 소프트웨어 개발에 많이 쓰이고 있다."

extractNoun(text)

#
library(dplyr)

# 사전 : 형태소 분석을 위한 규칙들이 모여있다.
useNIADic()

#
txt <- readLines("./Data/hiphop.txt", encoding="UTF-8")
txt

head(txt)

# 특수 문자 제거 

install.packages("stringr")
library(stringr)

# 대체할 문구에 공백(스페이스)이 없이 바꾸면 한글이 깨진다.
txt <- str_replace_all(txt, "\\W", " ")
head(txt)

# 명사 추출
extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다")


# 가사에서 명사추출
nouns <- extractNoun(txt)

head(nouns)

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
# list(배열)란? : 일반변수의 경우 한 메모리에 하나의 값만을 저장하는데, 한 메모리에 공간을 다시 쪼개서 각 공간에 여러가지 값을 넣어서 한 메모리 동시에 넣어놓은 상태.

# 벡터란? : 크기(table 명령어 결과 형태와 같은)를 가지는 값

wordcount <- table(unlist(nouns))
wordcount

# 데이터 프레임으로 변환

df_word <- as.data.frame(wordcount, stringsAsFactors = F)

df_word

# 변수명 수정

df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)
df_word

# 두 글자 이상 단어 추출
df_word <- filter(df_word, nchar(word) >=2)

df_word

top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

top_20

# 워드 클라우드 패키지 설치

install.packages("wordcloud")

# 패키지 로드

library(wordcloud)

library(RColorBrewer)

# 단어 색상 목록 만들기기

pal <- brewer.pal(8, "Dark2")

pal

# 워드 클라우드 생성

set.seed(1234) # 난수 고정

wordcloud(words = df_word$word, # 단어
          freq = df_word$freq, # 빈도
          min.freq = 2, # 최소 단어 빈도
          max.words = 200, # 표현 단어 수
          random.order = F, #고빈도 단어 중앙 배치
          rot.per = .1, #회전 단어 비율
          scale = c(4, 0.3), #단어 크기 범위
          colors = pal) # 색깔 목록

# 단어 색상 바꾸기
pal <- brewer.pal(9, "Blues")[5:9]

set.seed(1234) # 난수 고정

wordcloud(words = df_word$word, # 단어
          freq = df_word$freq, # 빈도
          min.freq = 2, # 최소 단어 빈도
          max.words = 200, # 표현 단어 수
          random.order = F, #고빈도 단어 중앙 배치
          rot.per = .1, #회전 단어 비율
          scale = c(4, 0.3), #단어 크기 범위
          colors = pal) # 색깔 목록

# 국정원 트윗 텍스트 마이닝

# 데이터 로드
getwd()
setwd("C:/Recture/Busan_202202_R")

twitter <- read.csv("./Data/twitter.csv",
                    header = T,
                    stringsAsFactors = F,
                    fileEncoding = "UTF-8")

# 변수명 수정

twitter <- rename(twitter,
                  no = 번호, 
                  id = 계정이름,
                  data = 작성일,
                  tw = 내용)

head(twitter)

# 특수문자 제거

twitter$tw <- str_replace_all(twitter, "\\W", " ")

head(twitter$tw)

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))

# 데이터 프레임으로 전환

df_word <- as.data.frame(wordcount, stringsAsFactors = F)

# 변수명 수정

df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

df_word

# 트위에서 명사 추출

nouns <- extractNoun(twitter$tw)

# 추출한 명사 list 를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))

# 데이터 프레임으로 변환

df_word <- as.data.frame(wordcount, stringsAsFactors = F)

head(df_word)

# 변수명 수정

df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

head(df_word)

# 두 글자 이상으로 된 단어 추출, 빈도 상위 20개 단어 추출

df_word <- filter(df_word, nchar(word) >= 2)

top20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

top20

# 단어 빈도 막대 그래프 만들기

library(ggplot2)

order <- arrange(top20, freq)$word # 빈도 순서 변수 생성

ggplot(data = top20, aes(x = word, y = freq)) +
  ylim(0, 2500) +
  geom_col()+
  coord_flip() +
  scale_x_discrete(limit = order) + # 빈도 순서 변수 기준 막대 정렬 
  geom_text(aes(label = freq), hjust = -0.3) # 빈도 수치를 그래프에 표시

# 워드 클라우드 만들기

pal <- brewer.pal(8, "Dark2")

set.seed(1234) # 난수 고정

wordcloud(words = df_word$word, # 단어
          freq = df_word$freq, # 빈도
          min.freq = 2, # 최소 단어 빈도
          max.words = 200, # 표현 단어 수
          random.order = F, #고빈도 단어 중앙 배치
          rot.per = .1, #회전 단어 비율
          scale = c(4, 0.3), #단어 크기 범위
          colors = pal) # 색깔 목록

# 색상 수정

pal <- brewer.pal(8, "Dark2")

set.seed(1234) # 난수 고정

wordcloud(words = df_word$word, # 단어
          freq = df_word$freq, # 빈도
          min.freq = 2, # 최소 단어 빈도
          max.words = 200, # 표현 단어 수
          random.order = F, #고빈도 단어 중앙 배치
          rot.per = .1, #회전 단어 비율
          scale = c(4, 0.3), #단어 크기 범위
          colors = pal) # 색깔 목록
