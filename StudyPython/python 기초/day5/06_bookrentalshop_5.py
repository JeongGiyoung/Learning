# 5. membertbl 새 데이터를 수정

import cx_Oracle as ora

def myconn() : 
    dsn = ora.makedsn('localhost', 1521, service_name='orcl')
    conn = ora.connect(user='scott', password='tiger', dsn=dsn, encoding='utf-8')
    return conn

def setChangeMemberFromMembertbl(conn, tup) :
    cur = conn.cursor()
    query = '''UPDATE membertbl
                SET addr = :1
                    , mobile = :2
                    , email = :3
                WHERE idx = :4 '''
    cur.execute(query, tup)
    cur.close()
    conn.commit()

if __name__ == '__main__':
    print('책 대여점 프로그램 시작')
    scott_con = myconn() # DB 접속

    # 5. membertbl 새 데이터를 수정

    print('기존회원 수정')
    idx = input('변경할 회원번호 입력 : ')
    addr = input('주소 입력 : ')
    mobile = input('폰번호 입력(-포함) : ')
    email = input('이메일 입력 : ')
    tup = (addr, mobile, email, idx)

    setChangeMemberFromMembertbl(scott_con, tup)

    print('기존회원 수정완료')

    



    # 6. divtbl에 임의 데이터 삭제