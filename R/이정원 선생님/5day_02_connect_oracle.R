### Oracle 연동 ### 
# oracle 이 설치되고, sql developer도 설치되어 있는 상황

# Java 연결 프로그램 : oracle이 java로 만들어졌기 때문

install.packages("RJDBC")
library(RJDBC)

# 오라클 드라이버(연결) 경로 설정

driver <- JDBC("oracle.jdbc.OracleDriver",
               classPath = "C:/DEV/Server/Oracle/product/12.2.0/dbhome_1/jdbc/lib/ojdbc8.jar")

driver

# 오라클 테스트 접속

conn <- dbConnect(driver, 
                  "jdbc:oracle:thin:@//localhost:1521/orcl",
                  "scott", "tiger")

conn

# 이 상태에서 sql developer로 넘어가기
#  * 5day_02_connect_oracle_01.txt 순서 따라가기


# 다시 R로 와서 

conn <- dbConnect(driver, 
                  "jdbc:oracle:thin:@//localhost:1521/orcl",
                  "busan", "dbdb")

conn

# 다시 sql developer로 가기

# busan 으로 접속

#  * 5day_02_connect_oracle_02.txt 순서 따라가기

# 다시 R 로 오기

# paste() : 하나의 문장으로 합치는 함수

sql_in <- paste("Insert into test",
                "(AA, BB, CC) ",
                "values('a1', 'b1', 'c1') ")
sql_in

# dbSendQuery(conn, ) : 데이터베이스에 요청하는 함수
in_stat = dbSendQuery(conn, sql_in)
in_stat

# dbClearResult() : 현 상태에서 더 할 작업이 없다는 함수로서 서버의 트래픽 부담을 줄이는 명령어

dbClearResult(in_stat)

# sql developer에 데이터가 만들어졌는지 확인

# 방금 만든 데이터를 조건절을 써서 확인

sql_sel <- "Select * From test where AA = 'a1' "
sql_sel

getData <- dbGetQuery(conn, sql_sel)
getData

getData$AA

str(getData)

# 중요 # 필수 # 오라클 접속 해제
# 하지만 잘 해제가 안되서 R에서는 오라클을 잘 사용하지 않는다.

dbDisconnect(conn)

