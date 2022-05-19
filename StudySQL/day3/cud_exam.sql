-- ������ �Է� INSERT INTO

--- ���� ���� version

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
 
 --- ���� version                 
 
INSERT INTO bonus 
            (ename, job, sal, comm)
  VALUES
            ('JACK', 'SALEMAN', 4000, NULL) ;
            
COMMIT ; -- ��������(������ ���ٴ� �� Ȯ���� ��)
ROLLBACK ; -- ���(���� INSERT �� ���� �����ϰ� ���� ��)

-- ���̺��� �����ϰ� ���� ��

--- scott - ������ Ŭ�� - ���̺� �� ���̺� - Ȯ�� Ȥ�� sql ���� �ٿ��ֱ�

---- �ѹ��̳� Ŀ���� �Ұ���


-- INSERT 

--- TEST ���̺� �Է�����

INSERT INTO test 
          ( idx, title, descs ) 
  VALUES
          ( 1, '��������', NULL ) ;

INSERT INTO test 
          ( idx, title, descs ) 
  VALUES
          ( 2, '��������2', '���볻�볻��2' ) ;
          
INSERT INTO test 
          ( idx, title, descs, regdate ) 
  VALUES
          ( 3, '��������3', '���볻�볻��3', SYSDATE ) ;
          
INSERT INTO test 
          ( idx, title, descs, regdate ) 
  VALUES
          ( 4, '��������4', '���볻�볻��4', TO_DATE('2021-12-31', 'yyyy-mm-dd') ) ;
          
-- SEQUENCE : �ڵ����� �ο��� ���Ǵ�� ���ڰ� �����Ǳ� ���� ��

--- ������� scott - ������ - ������Ŭ��

SELECT SEQ_TEST.CURRVAL FROM dual ;

--������ ���� �� �� ������Ű�� �ʹٸ�

SELECT SEQ_TEST.NEXTVAL FROM dual ;

-- ���� INSERT���� SEQUENCE �� ���Ǵ� ����

INSERT INTO test 
          ( idx, title, descs, regdate ) 
  VALUES
          ( SEQ_TEST.NEXTVAL, '��������5', '���볻�볻��5', SYSDATE ) ;
          
INSERT INTO test 
          ( idx, title, descs, regdate ) 
  VALUES
          ( SEQ_TEST.NEXTVAL, '��������7', '���볻�볻��7', SYSDATE ) ;
          
-- UPDATE : ���̺��� �����͸� �����ϰ� ���� ��

---- �ݵ�� WHERE�� �Բ� �Ἥ ��� �����͸� �ϰ� �������� �ʰ� �ϱ�

UPDATE test
        SET title = '���������?'
            , descs = '������ ����˴ϴ�.'
    WHERE idx = 7;
    
COMMIT;

-- DELETE : ���̺��� �����͸� �����ϰ� ���� ��

---- �ݵ�� WHERE�� �Բ� �Ἥ ��� �����͸� �ϰ� �������� �ʰ� �ϱ�

DELETE FROM test
  WHERE idx = 7;
  
  
-- su. : SUBQUARRY ��������

--- ��ȣ() �ȿ� ��ɹ��� ���̺��� ���� ���̺�� ǥ���ϰ� ���� ��
--- ��ȣ() ���� su�� �Է�

--- ROWNUM : �� ��ȣ�� ������ ���

--- ����) ������ ��� ������ �����ϸ鼭 ���ȣ�� 1�� ������ �� 

SELECT ROWNUM, su.ename, su.job, su.sal, su.comm
  FROM (SELECT ename, job, sal, comm
              FROM emp
               ORDER BY sal DESC) su
    WHERE ROWNUM <= 1 ;
    
SELECT ROWNUM, idx, title FROM test ;