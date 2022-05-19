dir()
setwd("C:/Sources/StudyR/day5/2022-01-28(금)_미션_데이터전처리/data_r")
dir()

df=read.csv('./cust_order_data.csv',sep='\t',encoding='ANSI', stringsAsFactors = TRUE)

df
str(df)

# 고객의 방문횟수
tmp=data.frame(table(df[,1]))
tmp
head(tmp)

# 방문횟수 summary
summary(tmp$Freq)
boxplot(tmp$Freq)

# 한 번에 한 상품을 구매하는 수량
boxplot(df[,16])

# '#NAME?' 지우기

tmp <- df$GOODS_NAME

tmp[tmp=='#NAME?'] <- NA
tmp <- tmp[complete.cases(tmp)]

# 여전히 #NAME 이 있다.
str(tmp)


# factor 안에 데이터셋은 지워도 levels이 남아있기 때문이다.


# factor로 만들어줬던 데이터를 다시 문자열로 바꾼다음, 다시 factor 작업을 해줘야 levels가 사라져있다.

as.factor(as.character(tmp))

tmp1=as.factor(as.character(tmp))

str(tmp1)

# 

str(df)
