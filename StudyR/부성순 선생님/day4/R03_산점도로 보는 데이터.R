# 산점도로 보는 데이터

tips

head(tips)

plot(tips[,1])

str(tips)

plot(tips[,1], tips[,2])
plot(tips[,7], tips[,1])

colNum=c(1,2,7)

par(mfrow=c(3,1))

for (i in colNum){
	plot(tips[,i],
	main=names(tips)[i])
}