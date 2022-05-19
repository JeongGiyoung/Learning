SELECT COUNT(*) FROM divtbl;
SELECT COUNT(*) FROM bookstbl;
SELECT COUNT(*) FROM membertbl;
SELECT COUNT(*) FROM rentaltbl;

-- 1.
SELECT LOWER(EMAIL)
          , MOBILE
          , NAMES
          , ADDR
          , LEVELS
  FROM MEMBERTBL
    ORDER BY NAMES DESC;
    
-- 2. 
SELECT b.NAMES å����
        , b.AUTHOR ���ڸ�
        , TO_CHAR(b.RELEASEDATE, 'yyyy-mm-dd') ������
        , b.PRICE ����
  FROM BOOKSTBL b 
    ORDER BY b.IDX ASC ;
    
-- 3.
SELECT d.NAMES �帣
          , b.NAMES å����
          , b.AUTHOR ����
          , TO_CHAR(b.RELEASEDATE, 'yyyy-mm-dd') ������
          , b.ISBN å�ڵ��ȣ
          , TO_CHAR(b.PRICE) || '��' ����
  FROM DIVTBL d, BOOKSTBL b 
    WHERE d.DIVISION = b.DIVISION
          ORDER BY b.IDX DESC
    ;
    
-- 4.
INSERT INTO MEMBERTBL
                                    ( IDX
                                    , NAMES
                                    , LEVELS
                                    , ADDR
                                    , MOBILE
                                    , EMAIL
                                    , USERID
                                    , PASSWORD
                                    , LASTLOGINDT
                                    , LOGINIPADDR)
     VALUES
                                    ( SEQ_MEMBER.NEXTVAL
                                    , 'ȫ�浿'
                                    , 'A'
                                    , '�λ�� ���� �ʷ���'
                                    , '010-7989-0909'
                                    , 'HGD09@NAVER.COM'
                                    , 'HGD7989'
                                    , 12345
                                    , NULL
                                    , NULL
                            ) ;
COMMIT ;

-- 5.
SELECT NVL(d.NAMES, '--�հ�--') �帣
          , SUM(b.PRICE) �帣���հ�ݾ�
  FROM DIVTBL d, BOOKSTBL b 
    WHERE d.DIVISION = b.DIVISION
      GROUP BY ROLLUP(d.NAMES)
    ;