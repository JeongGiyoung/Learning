# bookrentalshop.py
# divtbl, membertbl
import cx_Oracle as ora

def myconn() : 
    dsn = ora.makedsn('localhost', 1521, service_name='orcl')
    conn = ora.connect(user='scott', password='tiger', dsn=dsn, encoding='utf-8')
    return conn

# membertbl에 신규 회원 입력하기
def setNewMemberIntoMembertbl(conn, tup) :
    cur = conn.cursor()
    query = '''SELECT ROWNUM, idx
                FROM (
                    SELECT idx FROM  membertbl
                        ORDER BY IDX desc 
                        )
                WHERE ROWNUM = 1'''
    cur.execute(query)
    idx = cur.fetchone()

    if idx is None:
        idx = 0
    else : 
        idx = idx[1]
    # idx에 데이터가 없는 경우 시작 값을 넣는 쿼리

    intup = (idx+1, tup[0], tup[1], tup[2], tup[3])
    
    query = '''INSERT INTO membertbl
                            (idx, names, levels, userid, password) 
                VALUES (:1, :2, :3, :4, :5)'''
    cur.execute(query, intup)
    conn.commit()

if __name__ == '__main__':
    print('책 대여점 프로그램 시작')
    scott_con = myconn() # DB 접속

    # 4. membertbl에 새 데이터 입력
    print('신규 회원 입력')
    names = input('이름 입력 : ')
    levels = input('레벨 입력(A~D) : ')
    userid = input('아이디 입력(최대 20자) : ')
    password = input('패스워드 입력(최대 20자) : ')
    tup = (names, levels, userid, password)
    setNewMemberIntoMembertbl(scott_con, tup)
    print('신규회원 저장성공')

    # 5. membertbl 새 데이터를 수정
    # 6. divtbl에 임의 데이터 삭제


""" 
# bookrentalshop_1 에서 def 에서 query가 중복될 때 괜찮은지
  * 괜찮다 왜냐하면 idx 값을 바꾸고 다시 query 문은 INSERT INTO 문으로 다시 대체 되기 때문 
"""