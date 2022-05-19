# 커서에 접근하는 코드를 함수로 작성

import cx_Oracle as ora

def myconn() : 
    dsn = ora.makedsn('localhost', 1521, service_name='orcl')
    conn = ora.connect(user='scott', password='tiger', dsn=dsn, encoding='utf-8')
    return conn 

# 함수를 만들 땐 return 명령문을 쓰면 다른 함수로 이어질 수 있다.

def getAllData(conn) : 
    cur = conn.cursor()
    query = 'SELECT * FROM emp' 
    
    """ 
    # conn객체를 매개변수로 받아서 쿼리를 실행할 함수
    # 커서 생성
    # emp 테이블에서 데이터 모두 가져와라 
    """

    for row in cur.execute(query) :
    # emp 테이블의 최상단에 위치한 상태(.cursor()명령어를 썼기 때문)에서 모든 데이터를 한 줄씩 차례대로 가져온다는 쿼리

        print(row) # 그 내용을 출력한다.

def getNameAndJobData(conn) :
    cur = conn.cursor()
    query = 'SELECT ename, job FROM emp' 
    # emp 테이블에서 ename, job 열 값만 가져온다.
        
    """ 
    for row in cur.execute(query) :
    print(row) 
    # 위와 같이 하거나 아래와 같이 적어도 가능 
    """
       
    cur.execute(query) # SQL 문장 실행
    while True :
        row = cur.fetchone() 
        # SQL 문장을 실행한 값에서 하나의 row(레코드) 데이터를 return한다.(마우스 커서의 클릭과 같은 개념)
        # 더 이상 데이터가 없는 경우 None을 반환한다. 
        if row is None :
            break
        else : 
            print(row)

# def getDeptName(conn, no, loc) : 
def getDeptName(conn, tup) : 
    # 튜플 사용 이유 : conn, no, loc, ... 등 이렇게 파라미터가 계속 늘어나기 때문
    cur = conn.cursor()
    # query = 'SELECT * FROM dept WHERE deptno = :1'
    # 이 문장에서 :1 은 파이썬에서 Oracle 명령문 WHERE 에서 '1'번 형식(숫자)의 데이터를 받기 위한 문법. no 형태를 숫자형태로 지정하겠다는 뜻이다.
    query = f"SELECT * FROM dept WHERE deptno = {tup[0]} AND loc = '{tup[1]}'" 
    # oracle 명령문은 oracle에서 테스트해서 확인된 쿼리만 Python에서 쓴다.
    # Oracle 에서는 {loc} 부분에서 홑따옴표를 붙였기 때문에 이곳에서도 붙여줘야 한다.
    cur.execute(query) # 위에 query문을 쓸 때는 .execute(query, no) 이어야한다.
    row = cur.fetchone()
    print(row)

if __name__ == '__main__' :
    """ 
    # 언더바 2개씩 앞뒤로
    # main이라는 시스템 함수(Python을 설치할 때 기본으로 설치된 함수)를 불러오는 작업.
      * 주로 실무에서 '실제 시작하는 지점(Entry Point)'을 표시하는 작업
    """
    print('프로그램 시작')
    # 여기서부터 여러가지 명령문 아래로 쓰인다.

    scott_con = myconn() 
    # 이 함수는 위에 정의된대로 dsn, connect() 실행 후 접속객체 conn에 리턴한다.
   
    # print('emp 테이블 전체 조회(SELECT *)')
    # getAllData(scott_con)
    # print()
    # print()
    
    # print('emp 2개 컬럼 조회')
    # getNameAndJobData(scott_con)
    # print()
    # print()
    
    no = input('1. 부서번호를 입력하세요 : ')
    loc = input('2. 지역명을 입력하세요 : ').upper()
    tup = (no, loc)
    print()
    # print(f'부서번호 : {no}, 지역 : {loc}')
    print()
    getDeptName(scott_con, tup)
    print()

    print('프로그램 종료')

'''
# 블록 주석, 한 줄 주석 차이점
  * 블록 주석은 탭을 구분해야 다음 쿼리에 영향을 미치지 않는다. 
'''