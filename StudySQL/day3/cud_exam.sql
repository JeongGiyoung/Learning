-- 데이터 입력 INSERT INTO

--- 업계 예의 version

INSERT INTO bonus 
                          (ename
                          , job
                          , sal, comm)
  VALUES
                          ( ename
                          , job
                          , sal
                          , comm
                  ) ;
                  
 -- INSERT, COMMIT, ROLLBACK
 
 --- 연습 version                 
 
INSERT INTO bonus 
            (ename, job, sal, comm)
  VALUES
            ('JACK', 'SALEMAN', 4000, NULL) ;
            
COMMIT ; -- 완전저장(오류가 없다는 게 확실할 때)
ROLLBACK ; -- 취소(위에 INSERT 한 값을 삭제하고 싶을 때)

-- 테이블을 생성하고 싶을 때

--- scott - 오른쪽 클릭 - 테이블 새 테이블 - 확인 혹은 sql 복사 붙여넣기

---- 롤백이나 커밋이 불가능


-- INSERT 

--- TEST 테이블 입력쿼리

INSERT INTO test 
          ( idx, title, descs ) 
  VALUES
          ( 1, '내용증명', NULL ) ;

INSERT INTO test 
          ( idx, title, descs ) 
  VALUES
          ( 2, '내용증명2', '내용내용내용2' ) ;
          
INSERT INTO test 
          ( idx, title, descs, regdate ) 
  VALUES
          ( 3, '내용증명3', '내용내용내용3', SYSDATE ) ;
          
INSERT INTO test 
          ( idx, title, descs, regdate ) 
  VALUES
          ( 4, '내용증명4', '내용내용내용4', TO_DATE('2021-12-31', 'yyyy-mm-dd') ) ;
          
-- SEQUENCE : 자동으로 부여한 조건대로 숫자가 증가되길 원할 때

--- 생성방법 scott - 시퀀스 - 오른쪽클릭

SELECT SEQ_TEST.CURRVAL FROM dual ;

--시퀀스 값을 한 번 증가시키고 싶다면

SELECT SEQ_TEST.NEXTVAL FROM dual ;

-- 실제 INSERT에서 SEQUENCE 가 사용되는 예시

INSERT INTO test 
          ( idx, title, descs, regdate ) 
  VALUES
          ( SEQ_TEST.NEXTVAL, '내용증명5', '내용내용내용5', SYSDATE ) ;
          
INSERT INTO test 
          ( idx, title, descs, regdate ) 
  VALUES
          ( SEQ_TEST.NEXTVAL, '내용증명7', '내용내용내용7', SYSDATE ) ;
          
-- UPDATE : 테이블의 데이터를 수정하고 싶을 때

---- 반드시 WHERE과 함께 써서 모든 데이터를 일괄 수정되지 않게 하기

UPDATE test
        SET title = '내용증명요?'
            , descs = '내용이 변경됩니다.'
    WHERE idx = 7;
    
COMMIT;

-- DELETE : 테이블의 데이터를 삭제하고 싶을 때

---- 반드시 WHERE과 함께 써서 모든 데이터를 일괄 삭제되지 않게 하기

DELETE FROM test
  WHERE idx = 7;
  
  
-- su. : SUBQUARRY 서브쿼리

--- 괄호() 안에 명령문의 테이블을 하위 테이블로 표현하고 싶을 때
--- 괄호() 이후 su를 입력

--- ROWNUM : 행 번호를 값으로 출력

--- 예시) 월급이 비싼 순으로 정렬하면서 행번호가 1번 이하인 값 

SELECT ROWNUM, su.ename, su.job, su.sal, su.comm
  FROM (SELECT ename, job, sal, comm
              FROM emp
               ORDER BY sal DESC) su
    WHERE ROWNUM <= 1 ;
    
SELECT ROWNUM, idx, title FROM test ;