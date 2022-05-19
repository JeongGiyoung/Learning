# 색인(:1)을 이용해 부서번호와 지역을 입력해서 부서명을 찾는 방법

import cx_Oracle as ora

def myconn() : 
    dsn = ora.makedsn('localhost', 1521, service_name='orcl')
    conn = ora.connect(user='scott', password='tiger', dsn=dsn, encoding='utf-8')
    return conn

def getDeptName(conn, tup) : 
    cur = conn.cursor()
    query = "SELECT * FROM dept WHERE deptno = :1 AND loc = :2" 
    # 오라클 같은 데이터베이스는 색인의 시작이 1부터 시작하기 때문에 1로 시작한다.
    cur.execute(query, tup) 
    row = cur.fetchone()
    print(row)

if __name__ == '__main__' :

    print('프로그램 시작')

    scott_con = myconn() 
    
    no = input('1. 부서번호를 입력하세요 : ')
    loc = input('2. 지역명을 입력하세요 : ').upper()

    tup = (no, loc)
    print()
    print(f'부서번호 : {no}, 지역 : {loc}')
    print()

    getDeptName(scott_con, tup)
    print()

    print('프로그램 종료')