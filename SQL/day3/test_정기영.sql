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
SELECT b.NAMES 책제목
        , b.AUTHOR 저자명
        , TO_CHAR(b.RELEASEDATE, 'yyyy-mm-dd') 출판일
        , b.PRICE 가격
  FROM BOOKSTBL b 
    ORDER BY b.IDX ASC ;
    
-- 3.
SELECT d.NAMES 장르
          , b.NAMES 책제목
          , b.AUTHOR 저자
          , TO_CHAR(b.RELEASEDATE, 'yyyy-mm-dd') 출판일
          , b.ISBN 책코드번호
          , TO_CHAR(b.PRICE) || '원' 가격
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
                                    , '홍길동'
                                    , 'A'
                                    , '부산시 동구 초량동'
                                    , '010-7989-0909'
                                    , 'HGD09@NAVER.COM'
                                    , 'HGD7989'
                                    , 12345
                                    , NULL
                                    , NULL
                            ) ;
COMMIT ;

-- 5.
SELECT NVL(d.NAMES, '--합계--') 장르
          , SUM(b.PRICE) 장르별합계금액
  FROM DIVTBL d, BOOKSTBL b 
    WHERE d.DIVISION = b.DIVISION
      GROUP BY ROLLUP(d.NAMES)
    ;