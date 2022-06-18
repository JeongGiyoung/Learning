# 6. divtbl에 임의 데이터 삭제

import cx_Oracle as ora

def myconn() : 
    dsn = ora.makedsn('localhost', 1521, service_name='orcl')
    conn = ora.connect(user='scott', password='tiger', dsn=dsn, encoding='utf-8')
    return conn

def deleteDivision(conn, division) :
    cur = conn.cursor()
    query = 'DELETE FROM divtbl WHERE division = :1'
    cur.execute(query, [division])
    conn.commit()
'''
#  데이터가 1개일 때 
  * 튜플()을 쓸 때는 (... , ...) 형태로 적어야 되서 (division,) 으로 써야한다.
  * 리스트[]를 쓸 때는 [division]으로 쓰면 된다.
'''

if __name__ == '__main__':

    print('책 대여점 프로그램 시작')

    scott_con = myconn() # DB 접속

    # 6. divtbl에 임의 데이터 삭제

    print('장르 데이터 삭제')
    division = input('삭제할 장르코드 입력 : ')

    deleteDivision(scott_con, division)
    
    print('삭제 성공')

'''
# 만약 데이터 중에서 다른 테이블에서 그 데이터를 쓰면 삭제되지 않는다.
'''