-- 1�� ����
SELECT LOWER(email) email
      , mobile
      , names
      , addr
      , levels
 FROM membertbl
ORDER BY names DESC;

-- 2�� ����
SELECT names å����
     , author ����
     , TO_CHAR(releasedate, 'yyyy-mm-dd') ������
     , price ����
  FROM bookstbl
 ORDER BY idx;

-- 3�� ����
SELECT d.names �帣
     , b.names å����
     , b.author ����
     , TO_CHAR(b.releasedate, 'yyyy-mm-dd') ������
     , b.isbn å�ڵ��ȣ
     , TO_CHAR(b.price, '999,999,999') || '��' ����
  FROM bookstbl b, divtbl d
 WHERE b.division = d.division
 ORDER BY b.idx DESC;

-- 4�� ����
INSERT INTO membertbl ( idx, names, levels, addr, email, userid, password )
VALUES ( SEQ_MEMBERTBL.NEXTVAL, 'ȫ�浿', 'A', '�λ�� ���� �ʷ���', 'HGD09@NAVER.COM', 'HGD7989', '12345' );
COMMIT;
 
-- 5�� ����
SELECT NVL(d.names, '--�հ�--') �帣
     , TO_CHAR(SUM(b.price), '999,999,999') �帣���հ�ݾ�
  FROM bookstbl b, divtbl d
 WHERE b.division = d.division
 GROUP BY ROLLUP(d.names);
