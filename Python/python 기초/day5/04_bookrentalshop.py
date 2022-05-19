# bookrentalshop.py
# divtbl, membertbl
import cx_Oracle as ora

def myconn() : 
    dsn = ora.makedsn('localhost', 1521, service_name='orcl')
    conn = ora.connect(user='scott', password='tiger', dsn=dsn, encoding='utf-8')
    return conn

def getAllDataFromDivtbl(conn) :
    cur = conn.cursor()
    query = 'SELECT * FROM divtbl'
    for row in cur.execute(query) :
        print(row)

def setDataIntoDivtbl(conn, tup) :
    cur = conn.cursor()
    query = '''INSERT INTO divtbl (division, names) 
    VALUES (:1, :2)'''
    cur.execute(query, tup)
    cur.close()
    conn.commit() # DB에서 하는 COMMIT ; 과 같은 명령어
                    # 필수

# membertbl에서 일부(주소에 '서울'이 들어간) 데이터 가져오기
def getSomeDataFromMembertbl(conn) :
    cur = conn.cursor()
    query =''' SELECT names, levels, addr, mobile, email 
                  FROM membertbl
                WHERE addr LIKE '서울%'
                  AND UPPER(email) LIKE '%@NAVER.COM'
                ORDER BY idx DESC'''
    for row in cur.execute(query) :
        print(row)
    cur.close()

if __name__ == '__main__':
    print('책 대여점 프로그램 시작')
    scott_con = myconn() # DB 접속

    # 1. divtbl에서 데이터 조회
    print('책 장르 정보조회')
    getAllDataFromDivtbl(scott_con)

    # 2. divtbl에 새로운 데이터 입력
    print('책 장르 정보조회')
    division = input('구분코드를 입력 : ')
    names = input('장르명 입력 : ')
    tup = (division, names)
    setDataIntoDivtbl(scott_con, tup)
    print('정보 입력 성공')

    # 3. membertbl에서 데이터 조회
    getSomeDataFromMembertbl(scott_con)

    # 4. membertbl에 새 데이터 입력

    # 5. membertbl 새 데이터를 수정
    # 6. divtbl에 임의 데이터 삭제

""" 
# bookrentalshop.py 에서 def setDataIntoDivtbl(conn, tup) : 에서 close() 가 들어간 이유.
  * close로 실행되었던 문법을 종료해야되기 때문. 하지만 Python은 문법에 엄격하지 않기 때문에 없어도 오류 없이 동작한다.
"""