# StudyR
R 프로그램 공부

# 머신러닝 : 기계가 학습하여 모델을 생성하고 새로운 데이터를 예측하거나 분류
  * 그 중 사진, 오디오, 비디오등의 비정형 데이터는 양이 엄청 많음.
    - 비정형데이터 분석은 인공신경망 이용(=딥러닝)

# 트랜잭션 파일 : 
  * 주 파일(master file)의 변경 사항을 일시적으로 저장하고 있는 파일. 일반 업무에서 전표와 같은 역할을 하는 것으로 갱신용 데이터나 조합용 데이터를 기록해 두는 파일이다. 실시간으로 처리되는 온라인 시스템에서는 단말기로부터 입력되는 트랜잭션 데이터를 일시적으로 포함하고 있다가 주 컴퓨터 시스템에서 처리함으로써 주 파일이 갱신된다.

# 마스터 파일 : 

# 메모장에 데이터를 입력하고 저장할 때 인코딩을 'ANSI' 로 저장하면 R에서 잘 읽힌다.
-----------------
# 연관성 분석에 대해 간단히 설명하자면!
  * https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=leedk1110&logNo=220788082381

# 연관성 분석은 데이터 간의 연관성 및 상관관계를 표현하는 규칙입니다.
  * 일반적으로 'A->B' 즉, 'A를 사면, B를 살 것이다' 와 같이 직관적인 형태로 결과가 도출됩니다.
    - 이때, A를 lhs(left-hands side), B를 rhs(right-hands side)라 부릅니다.
  * 연관성분석의 지표에는 
    - SUPPORT(지지도),
    - CONFIDENCE(신뢰도),
    - LIFT(향상도)
  * 지지도(support)는 품목 A와 B를 동시에 구매할 확률인 P(A∩B)를 나타냅니다.
    - 당연히 클수록 A와 B의 관련도가 높겠죠?
  * 신뢰도(Confidence)는 품목 A가 구매되었을 때, 품목 B 가 구매될 확률 즉, P(B|A)를 나타냅니다.
    - 역시 클수록 관련도가 높습니다.
      + 하지만 결과값이 A에 의존하기 때문에 전체적인 분석이 어렵습니다.
      + 딱 몇일때 좋다! 라는 기준도 없어, 애매할 때가 많습니다.
      + 이럴때, 향상도를 확인합니다.
  * 향상도(Lift)는 
    * A를 구매한 사람이 B를 구매할 확률과 
    * A의 구매와 상관없이 B를 구매할 확률의 비 입니다.
    * 즉, 𝑷(𝑩|𝑨)/𝑷(𝑩) = 𝑷(𝑨∩𝑩)/𝑷(𝑨)𝑷(𝑩) = 𝑪𝒐𝒏𝒇𝒊𝒅𝒆𝒏𝒄𝒆(𝑨→𝑩)/𝑷(𝑩) 입니다.
    * 향상도에서 만약 A와 B가 독립이라면 
      - P(B∩A)가 P(A)*P(B) 이므로
      - LITF = P(A)*P(B) / P(A)*P(B) = 1이 됩니다.
      - 즉, A와 B가 관련성이 없다면 LIFT=1이되고,
      - LIFT > 1 이라면 LIFT값이 클 수록 관련도가 높으며,
      - LIFT < 1 이라면 오히려 A를 구매한 사람은 B를 구매하지 않는다는 결론이 나옵니다.

---------------------
## 2022-01-25(화)(day2)
## 2022-01-26(수)(day3)
    # R01_행렬합계
        iris[,-5]
        x[,-ncol(x)]
        colSums()
        rowSums()
    # R02_전국무인교통단속카메라
        # dir()
        # getwd()
        # setwd()
        # 파일 확인 단계
        # subset()
        # 데이터 형 변환
        # 컬럼명 정리
        # paste()
        # 필요한 컬럼만 모아서 별도의 데이터셋 제작
        # 필드명 번호 추출
        # 조건에 맞는 자료만 필터링
        # unique()
        # 자료셋을 새로 제작해서 csv로 저장하기
        # rownames 
        # csv 파일로 저장하기
        # 시도명별 csv 파일 저장하기
    # R03_전국무인교통단속카메라_폴더 만들어서 시도명별 파일 만들기
        # R에서 폴더를 생성하고 저장하는 방법
            * ifelse(dir.exists(' '), F, dir.create(' '))
        # 시도명별 원하는 폴더에 csv 파일 저장하기
            fileName=paste(sido[index], '.csv', sep='')
            fileName

            for (index in 1:21){
                tmp=subset(df1,시도명==sido[index])
                fileName=paste('./test/', sido[index], '.csv', sep='')
                write.csv(tmp,fileName)
                }
## 2022-01-27(목)(day4)
    # R01_패키지
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
    # R02_데이터 분석 순서
        # [데이터(자료) 파악 : 변수의 성격과 해설]
        # install.packages('reshape2')
        # library(reshape2)
        # 데이터(자료) 파악 : 변수의 성격과 해설
        # sum(is.na())
            * 결측치 확인
        # unique() 
            * unique 명령어로 필드별로 데이터 변수 파악
        # 가설과 검증
            * 일반적인 가설검증은 데이터집계를 통해서 비교
        # table()
            * 빈도수 구하기
                - 빈도수 : 전체데이터에서 발생횟수
        # for문을 이용해 기준이 될(명목형 변수) 컬럼들을 빈도수 집계내기.
        # 시간대 별 빈도수 확인
        # colMeans()
            * 총 금액, 팁, 인원수 별 평균값
        # colSums()
            * 총 금액, 팁, 인원수 별 합계
        # plot()
            * 시간대별 빈도수 시각화
        # plot(  , main=' ')
            * 차트 제목 부여
    # R03_산점도로 보는 데이터
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
    # R04_상관도 시각화
        # cor()
            * 피어슨 상관계수(기울기)
        # plot()
            * 피어슨 상관계수 시각화
        # 다중공선성
        # plot( , main=' ', pch= ,col= ) 
            * plot(데이터, 차트 제목, 점 모양 , 색깔 )
            * 패키지를 이용하지 않고 plot으로 시각화 꾸미기
                - 문자열을 숫자값으로 변환
        # chart.Correlation(mtcars, histogram=TRUE, pch=19)
            * PerformanceAnalytics 패키지를 이용한 상관도 시각화
                - mtcars 상관도 시각화
                - tips 자료 상관도 시각화
    # R05_이상치 확인
        # 이상치는 무엇인가요? 
        # boxplot()
        # 박스플롯 이용해서 확인하고 싶은 컬럼별로 이상치 확인하기
        # 'Sat' 데이터를 박스플롯 이용해서 확인하고 싶은 컬럼별로 이상치 확인하기
        # 이상치를 제거하고 다시 확인하기
    # R06_cor(), scale()
        # cor() 
            * 피어슨 상관계수 구하기
        # scale()
            * raw 데이터값을 컬럼별로 표준화(비율 형태로 출력)
            * 보통 컬럼별 분포도를 한 번에 비교하면서 보고 싶을 때 쓴다.

###################################
# 이정원 선생님 
# 변수 = 데이터를 임시적으로 넣는 공간(메모리)

# 변수, 리스트, 튜플, 딕셔너리
  * 변수 : 데이터를 1개 
  * 리스트, 튜플, 딕셔너리 : 데이터를 여러개

# 함수 : 자주 사용되거나 반복해서 사용되어야 하는 기능을 미리 만들어 놓은 것

# C 함수(기능)
  * a <-c(1,2,3) 

# paste() 함수 : 쉼표 또는 띄어쓰기 구분자로 str5의 단어들을 하나의 문자열로 합치기
  * str5 <-c("hello!", "world")
  * paste(str5, collapse = ",")
    - 결과 : [1] "hello!,world"

# package를 설치하면 R이 있는 폴더로 불러드리는 작업을 'library'

# 속성
  * 임자변수 : 사용자가 진입하는 변수?
  * 매계변수 : 매번 달라지는 변수?

# help(함수명), ?함수명

# 비정형 데이터 : 정형 데이터(행과 열로 이루어진 = 데이터 프레임) 아닌 데이터

# 열 : 변수
# 행 : 데이터
  * 데이터가 많다 = 행이 많다.
  * 데이터가 크다 = 행 or 열 or 행과 열이 많다.

# 통계 분석 : 모집단(샘플링)을 통해 분석
# 빅데이터 분석 : 전수 조사 분석

# factor라는 타입은 '범주형'

# 그래프 중 이상치가 나타나는 기간을 구글 검색에서 설정 - 웹 크롤링 - 워드 클라우드 - 이 중에 크게 표현되는 단어 중심으로 검색

# 데이터를 받을 때 기본정보(출처, 날짜 등)를 그 때마다 정리해야 한다.

##############################
# 이정원 선생님 수업 순서
[day1]

# Rstudio , Rtools 설치
  * rtools는 R이 알아서 사용하기 때문에 쓸 일이 없다.

[R studio]

# Rstudio는 관리자 권한으로 실행하기
  * 웬만한 개발 프로그램은 관리자 권한으로 실행하기
    - Window에서 업데이트를 통해 방화벽을 C드라이브에 강화하고 있기 때문

# tools - option - default working directory 설정하기

# R로 엑셀파일 등을 불러오기 전에 데이터 형태가 어떻게 되어있는지 확인해야 한다.
  * 셀이 합쳐져 있거나, 합계나 차트 등을 다 걸러내고 행렬로만 데이터가 구성되어있어야 한다.

# tools - global option - code - saving - default text encoding - utf-8

# alt + shift + 아래 방향키 : 복사
# alt + 아래 방향키 : 순서 바꾸기

[day3]

# jdk 설치 
  * KoNLP(텍스트 마이닝 패키지) 사용하기 전에 JDK를 설치해야 한다.
  * 오라클 홈페이지에서 jdk 다운()
    - 8버전 이상부터 유료화 되서 무료버전인 8버전을 받기가 힘들다.
    - jdk 8버전을 항상 가지고 있으면 편하다.
  * 환경변수 설정(문서참조)
    - 내컴퓨터 오른쪽 클릭 - 속성 - 고급 시스템 설정 - 환경변수
  * rtools 환경변수 설정하기
    - - 내컴퓨터 오른쪽 클릭 - 속성 - 고급 시스템 설정 - 환경변수 - path - 새로만들기 - %RTOOLS40_HOME%\usr\bin
