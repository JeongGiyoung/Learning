library(KoNLP)

library(dplyr)

useNIADic()

txt_14 <- readLines("./Data/14th__president_speech_19930225.txt", encoding="UTF-8")

head(txt_14)

library(stringr)

txt_14 <- str_replace_all(txt_14, "\\W", " ")

nouns <- extractNoun(txt_14)

wordcount <- table(unlist(nouns))
wordcount

df_word <- as.data.frame(wordcount, stringsAsFactors = F)

head(df_word)

df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)
head(df_word)

df_word <- filter(df_word, nchar(word) >=2)

head(df_word)

top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

top_20

library(wordcloud)

library(RColorBrewer)

pal <- brewer.pal(8, "Dark2")

set.seed(1234) # 난수 고정

wordcloud(words = df_word$word, # 단어
          freq = df_word$freq, # 빈도
          min.freq = 2, # 최소 단어 빈도
          max.words = 200, # 표현 단어 수
          random.order = F, #고빈도 단어 중앙 배치
          rot.per = .1, #회전 단어 비율
          scale = c(3, 0.3), #단어 크기 범위
          colors = pal) # 색깔 목록
