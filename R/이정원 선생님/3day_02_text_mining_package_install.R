# 텍스트 마이닝(Text Mining) : 문자로 된 데이터에서 가치 있는 정보를 얻어 내는 분석 기법
# eg) 대통령 담화문에서 많이 쓰인 단어

# 분석절차
# 1. 형태소 분석
# 2. 품사 단어 추출
# 3. 빈도표 만들기
# 4. 시각화

# 이를 위해 KoNLP 패키지를 사용해야 한다.

# KoNLP(텍스트 마이닝 패키지) 사용하기 전에 JDK를 설치해야 한다.

# * 왜냐하면 KoNLP 패키지가 Java 언어로 되어있고 이를 해석할 수 있는(컴파일러) 가 JDK이다.

# 설치하면서 환경변수 설정(문서 참조)

# 환경 변수 설정이 완료 되면

install.packages("usethis")
usethis::edit_r_environ()

# 위 명령문 실행 후 작업 창이 뜨면

# PATH="${RTOOLS40_HOME}\usr\bin;${PATH}"

# 입력

Sys.which("make")

# R에서 Java를 사용

install.packages("rJava")

# 
install.packages("remotes")

remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))