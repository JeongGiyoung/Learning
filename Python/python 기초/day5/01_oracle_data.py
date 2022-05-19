# oracle data 연동

# cx_oracle 설치 : 
## 터미널에서 'pip install cx_oracle' 입력

from sqlite3 import DatabaseError
import cx_Oracle as ora

""" 
# dsn : data source name

# makedsn('호스트명 혹은 ip주소', 포트번호, '서비스 이름')
  * oracle sql developer 프로그램 켜서, 쓰고 싶은 계정에서 오른쪽 클릭 후 '속성'에서 확인 가능
"""

dsn = ora.makedsn('localhost', 1521, service_name='orcl')

""" 
# conn(user, password, dsn, encoding='')
# conn(사용자 이름, 비밀번호, dsn, encoding='')
"""
conn = ora.connect(user='scott', password='tiger', dsn=dsn, encoding='utf-8')

cur = conn.cursor()
# 마우스 커서와 개념이 비슷

""" 
try :
    for row in cur.execute('SELECT * FROM emp;') :
        print(row)
except ora.DatabaseError as e :
    print(f'쿼리문이 잘못되었습니다. 30번 라인 확인 : {e}')
finally :
    cur.close() # 커서 닫기
    conn.close() # 접속 닫기 """
""" 
# oracle 에서는 명령문 마지막에 ; 을 넣어야하지만 파이썬 라이브러리를 통해 사용할 때는 ;이 필요 없다. 만약 ;을 붙여서 오류를 낼 가능성이 있을 때를 대비해서 try, except 구문을 넣어둔 예시
# 커서와 접속은 반드시 닫아줘야 한다.
"""


# emp 테이블 총 개수 구하는 쿼리

try :
    cur.execute('SELECT COUNT(*), \'sample\' FROM emp')
    result = cur.fetchone()
    print(result)
except ora.DatabaseError as e :
    print(f'쿼리문이 잘못되었습니다. SELECT 라인 확인 : {e}')
finally :
    cur.close() # 커서 닫기
    conn.close() # 접속 닫기