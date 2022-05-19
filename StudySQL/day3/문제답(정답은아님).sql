-- 1번 문제
SELECT LOWER(email) email
      , mobile
      , names
      , addr
      , levels
 FROM membertbl
ORDER BY names DESC;

-- 2번 문제
SELECT names 책제목
     , author 저자
     , TO_CHAR(releasedate, 'yyyy-mm-dd') 출판일
     , price 가격
  FROM bookstbl
 ORDER BY idx;

-- 3번 문제
SELECT d.names 장르
     , b.names 책제목
     , b.author 저자
     , TO_CHAR(b.releasedate, 'yyyy-mm-dd') 출판일
     , b.isbn 책코드번호
     , TO_CHAR(b.price, '999,999,999') || '원' 가격
  FROM bookstbl b, divtbl d
 WHERE b.division = d.division
 ORDER BY b.idx DESC;

-- 4번 문제
INSERT INTO membertbl ( idx, names, levels, addr, email, userid, password )
VALUES ( SEQ_MEMBERTBL.NEXTVAL, '홍길동', 'A', '부산시 동구 초량동', 'HGD09@NAVER.COM', 'HGD7989', '12345' );
COMMIT;
 
-- 5번 문제
SELECT NVL(d.names, '--합계--') 장르
     , TO_CHAR(SUM(b.price), '999,999,999') 장르별합계금액
  FROM bookstbl b, divtbl d
 WHERE b.division = d.division
 GROUP BY ROLLUP(d.names);
