/*
���̸� : ������ ����'��'
����: ����,���⿵,����ö,���Ϳ�

[1����]

�ֹε�ϻ� 1������ ȸ���� ���ݱ��� ������ ��ǰ�� ��ǰ�з� ��  
�� �α��ڰ� 01�̸� �ǸŰ��� 10%�����ϰ�
02�� �ǸŰ��� 5%�λ� �������� ���� �ǸŰ��� ����
(�ǸŰ��� ������ 500,000~1,000,000�� ���̷� ������������ �����Ͻÿ�. (��ȭǥ�� �� õ��������))
(Alias ��ǰ�з�, �ǸŰ�, �����ǸŰ�)
*/

SELECT prod_name, prod_lgu, TO_CHAR(prod_sale, 'L999,999,999') origin_sale,
          DECODE( SUBSTR(prod_lgu,3,2),
                        '01', TO_CHAR(prod_sale * 0.9, 'L999,999,999'),
                        '02', TO_CHAR(prod_sale * 1.05, 'L999,999,999'),
                        prod_sale ) AS chg_sale                        
FROM prod 
  WHERE prod_id IN (SELECT cart_prod
                              FROM cart
                                WHERE cart_member IN (SELECT mem_id
                                                                  FROM member
                                                                    WHERE SUBSTR(mem_regno1,3,2) = 1 ))
      AND prod_sale BETWEEN 500000 AND 1000000
ORDER BY chg_sale DESC;

/*
[2����]

ȸ���� 1975����̰� ���� �ּ��� ȸ���� �����ߴ� ����ǰ �߿� 
�ǸŰ��� �ǸŰ��� ��ü��պ��� ���� ��ǰ�� �˻��غ�����.
��  
1. �ǸŰ��� �������� ���������ϰ�, �ǸŰ��� õ���� ����ǥ��
2. ��ǰ�� �Ｚ�� �� ��ǰ�� ���� 
3. ��ǰ������ NULL���� '����'���� ó��
4. ���� ������ 1�̻��� �͸� ��ȸ
*/

SELECT prod_name, 
          TO_CHAR(prod_sale, 'L999,999,999') AS prod_sale,
          NVL(prod_color, '����'),
          COUNT(prod_color)
FROM prod
  WHERE prod_sale > (SELECT AVG(prod_sale) FROM prod)
      AND prod_id IN (SELECT cart_prod
                              FROM cart
                                WHERE cart_member IN (SELECT mem_id
                                                                  FROM member
                                                                    WHERE EXTRACT(YEAR FROM mem_bir) = 1975
                                                                        AND mem_add1 LIKE '����%')) 
      AND prod_name LIKE '%�Ｚ%'
  GROUP BY prod_name, prod_sale, prod_color
    HAVING COUNT(prod_color) >=1
ORDER BY prod_sale DESC;

---
/*
[3����]

���� ������ �����ϰ� ������ 2���̰� �������ڰ� 4�� ~ 6�� ������ ȸ�� �� 
���ż����� ��üȸ���� ��� ���ż������� ���� ȸ�� ��ȸ �� 

"(mem_name) ȸ������ (Extract(month form mem_bir)) �� ������ �������� �����մϴ�. 
2��Ʈ (mem_add �� 2����) ���� �̿��� �ּż� �����մϴ�.
�̹� 2�� ���ȿ��� VVIPȸ������ ���ϸ����� 3��� ����Ͻ� �� �ֽ��ϴ�.
�����ε� ���� �̿� �ٶ��ϴ�." ���

(Alias ȸ����, ����, �ּ�, �̸��� �ּ�, ���� ���� ����)
*/

SELECT mem_name, 
          (CASE WHEN MOD(SUBSTR(mem_regno2, 1, 1), 2) = 1 THEN '����'
                  WHEN MOD(SUBSTR(mem_regno2, 1, 1), 2) = 0 THEN '����'
                  -- ELSE 
                  END) AS "sex",
          mem_add1,
          mem_mail,
          mem_name || ' ȸ������ ' || EXTRACT(MONTH FROM mem_bir) || '�� ������ �������� �����մϴ�. 2��Ʈ ' || SUBSTR(mem_add1,1,2) || '���� �̿����ּż� �����մϴ�.' AS stn
FROM member
  WHERE mem_add1 LIKE '����%'
      -- AND EXTRACT(MONTH FROM mem_bir) = 2 
      AND mem_id IN (SELECT cart_member
                              FROM cart
                                WHERE SUBSTR(cart_no,5,2) BETWEEN 4 AND 6
                                    AND cart_qty > (SELECT AVG(cart_qty)
                                                            FROM cart));

---------------------------------------
-- 5��
/* [����]
1. 
'����ĳ�־�'�̸鼭 ��ǰ �̸��� '����'�� ���� ��ǰ�̰�, 
���Լ����� 30�� �̻��̸鼭 6���� �԰��� ��ǰ��
���ϸ����� �ǸŰ��� ���� ���� ��ȸ�Ͻÿ�
Alias ��ǰ�̸�,�ǸŰ���, �ǸŰ���+���ϸ���
*/

SELECT prod_name,
          prod_sale,
          (prod_sale + NVL(prod_mileage, 0)) AS sum
FROM prod
  WHERE prod_id IN (SELECT buy_prod
                         FROM buyprod
                          WHERE buy_qty >= 30 
                              AND buy_date BETWEEN '05/06/01' AND '05/06/30')
      AND prod_lgu = 'P201'
      AND prod_name LIKE '%����%';

/* 2. 
�ŷ�ó �ڵ尡 'P20' ���� �����ϴ� �ŷ�ó�� �����ϴ� ��ǰ���� 
��ǰ ������� 2005�� 1�� 31��(2����) ���Ŀ� �̷������ ���Դܰ��� 20������ �Ѵ� ��ǰ��
������ ���� ���ϸ����� 2500�̻��̸� ���ȸ�� �ƴϸ� �Ϲ�ȸ������ ����϶�
�÷� ȸ���̸��� ���ϸ���, ��� �Ǵ� �Ϲ�ȸ���� ��Ÿ���� �÷�
*/

SELECT mem_name,
          mem_mileage,
          (CASE WHEN mem_mileage >= 2500 THEN '���ȸ��'
                   ELSE '�Ϲ�ȸ��'
                   END) AS "tier"
FROM member
  WHERE mem_id IN (SELECT cart_member
                              FROM cart
                                WHERE cart_prod IN (SELECT prod_id
                                                              FROM prod
                                                                WHERE prod_id IN (SELECT buy_prod
                                                                                                FROM buyprod
                                                                                                  WHERE buy_prod LIKE 'P20%'
                                                                                                      AND buy_cost >= 200000)
                                                                    AND prod_insdate > '05/01/31' ));

/* 3. 
6���� ����(5���ޱ���)�� �԰�� ��ǰ �߿� 
���Ư������� '��Ź ����'�̸鼭 ������ null���� ��ǰ�� �߿� 
�Ǹŷ��� ��ǰ �Ǹŷ��� ��պ��� ���� �ȸ��� ������
�达 ���� ���� �մ��� �̸��� ���� ���ϸ����� ���ϰ� ������ ����Ͻÿ�
Alias �̸�, ���� ���ϸ���, ����
*/

SELECT mem_name,
          mem_mileage,
          (CASE WHEN MOD(SUBSTR(mem_regno2, 1, 1), 2) = 1 THEN '����'
                    WHEN MOD(SUBSTR(mem_regno2, 1, 1), 2) = 0 THEN '����'
                    END) AS "sex"
FROM member
  WHERE mem_name LIKE '��%'
      AND mem_id IN(SELECT cart_member
                            FROM cart
                              WHERE cart_prod IN (SELECT prod_id
                                                            FROM prod
                                                              WHERE prod_id IN (SELECT buy_prod
                                                                                          FROM buyprod
                                                                                            WHERE buy_date < '05/06/01')
                                                                  AND prod_delivery = '��Ź ����'
                                                                  AND prod_color is null)
                                  AND cart_qty >= (SELECT AVG(cart_qty)
                                                          FROM cart)) ;
-- 1��
/*
[���� �����]
????(������������ �󵵼���) ���� ���� ��ǰ�� ������ ȸ�� �� 
�ڿ��� �ƴ� ȸ���� id�� name
*/

SELECT mem_id,
          mem_name
FROM member
  WHERE mem_id IN (SELECT cart_member
                              FROM cart
                                WHERE cart_prod IN (SELECT prod_id
                                                              FROM prod));

/* 2.
[���� �����]
��޻�ǰ�ڵ尡 'P1'�̰� '��õ'�� ��� ���� ������� ��ǰ�� ������ 
ȸ���� ��ȥ������� 8������ �ƴϸ鼭 
��ո��ϸ���(�Ҽ���°�ڸ�����) �̸��̸鼭 
�����Ͽ� ù��°�� ������ ȸ���� 
ȸ��ID, ȸ���̸�, ȸ�����ϸ����� �˻��Ͻÿ�.  
 ************ ��� ���� 0���̰ų� 2���Դϴ� ******************/

SELECT mem_id,
          mem_name,
          mem_mileage
FROM member 
  WHERE mem_id IN (SELECT cart_member
                              FROM cart
                                WHERE cart_prod IN (SELECT prod_id
                                                              FROM prod
                                                                WHERE prod_buyer IN (SELECT buyer_id
                                                                                                FROM buyer
                                                                                                  WHERE buyer_lgu LIKE 'P1%'
                                                                                                      AND buyer_add1 LIKE '��õ%' ))
                                    AND SUBSTR(cart_no, -2, 2) = 1)
      AND EXTRACT(MONTH FROM mem_bir) <> 8
      AND mem_mileage < (SELECT ROUND(AVG(mem_mileage),2) 
                                    FROM member) ;
--JOIN �̿�
SELECT M.mem_id,
          M.mem_name,
          M.mem_mileage
FROM member M INNER JOIN cart C
                                    ON M.mem_id = C.cart_member
                          INNER JOIN prod P
                                    ON P.prod_id = C.cart_prod
                          INNER JOIN buyer B
                                    ON B.buyer_id = P.prod_buyer
  WHERE B.buyer_add1 LIKE '��õ%'
      AND  SUBSTR(B.buyer_lgu,1,2) = 'P1'
      AND EXTRACT(MONTH FROM M.mem_bir) <> 8
      AND M.mem_mileage < (SELECT ROUND(AVG(M.mem_mileage),2) 
                                    FROM member)
      AND SUBSTR(cart_no, -2, 2) = 1;




/* 3.
[���� �����]
�ּ����� ������ �ŷ�ó ����ڰ� ����ϴ� ��ǰ�� 
�������� ���� ���� ���� ȸ�� �߿� 2���� ��ȥ������� �ִ�
ȸ�� ���̵�, ȸ�� �̸� ��ȸ 
�̸� �������� ����
*/

SELECT mem_id,
          mem_name
FROM member
  WHERE mem_id IN (SELECT cart_member
                              FROM cart
                                WHERE cart_prod IN (SELECT prod_id
                                                              FROM prod
                                                                WHERE prod_buyer NOT IN (SELECT buyer_id
                                                                                                FROM buyer
                                                                                                  WHERE buyer_add1 LIKE '����%')))
      AND mem_add1 LIKE '����%'
      AND SUBSTR(mem_regno2,1,1) =2
      AND mem_memorial = '��ȥ�����'
      AND EXTRACT(MONTH FROM mem_memorialday) = 12 ;

/* 4. 
[���� �����]
��ǻ����ǰ�� �ְ��ϸ� ������(����,��õ)�� ��� �ּҿ� '��' �� �� ���� ��� ����ڰ� ����ϴ�
��ǰ �߿��� �ǸŰ����� ��ü�ǸŰ��� �̻��� ��ǰ�� ������ ȸ������ ��� ��(����)��  �з��ϰ�
������ ȸ������ �����ϴ� ����Ϻ� ���� ���� ������� ������� �˾Ƴ��ÿ�
--����: ������
--�泲, ���� : ��û�� �������� ���
*/


SELECT mem_id,
           mem_name,
           round(avg(mem_mileage),2) 
FROM member
WHERE mem_id IN(
                            SELECT cart_member  
                            FROM cart
                            WHERE cart_prod IN(
                                                            SELECT prod_id
                                                            FROM prod
                                                            WHERE prod_buyer IN(
                                                                                            SELECT buyer_id
                                                                                            FROM buyer
                                                                                            Where buyer_add1 like '��õ%'
                                                                                            AND buyer_lgu like 'P1%')))
AND mem_memorial = '��ȥ�����'
AND extract(month from mem_memorialday) != '8'   
AND mem_mileage < (SELECT avg(mem_mileage) FROM member) 
GROUP BY mem_id, mem_name;
-------------------------------------------------
/* 3��
1. ��ö�� �� ���� �� TV �� ���峪�� ��ȯ�������� �Ѵ�
��ȯ�������� �ŷ�ó ��ȭ��ȣ�� �̿��ؾ� �Ѵ�.
����ó�� ��ȭ��ȣ�� ��ȸ�Ͻÿ�.
*/

SELECT B.buyer_name,
          B.buyer_comtel
FROM buyer B INNER JOIN prod P
                              ON B.buyer_id = P.prod_buyer
                    INNER JOIN cart C
                              ON P.prod_id = C.cart_prod
                    INNER JOIN member M
                              ON M.mem_id = C.cart_member                              
  WHERE mem_name = '��ö��' 
      AND prod_name LIKE '%TV%';
--

SELECT buyer_name, buyer_comtel
FROM buyer
  WHERE buyer_id IN (SELECT prod_buyer
                              FROM prod
                                WHERE prod_id IN (SELECT cart_prod
                                                            FROM cart
                                                              WHERE cart_member IN (SELECT mem_id
                                                                                                FROM member
                                                                                                  WHERE mem_name = '��ö��' ))
                                    AND prod_name LIKE '%TV%' );

/*
2. ������ ��� 73�����Ŀ� �¾ �ֺε� ��
2005�� 4���� ������ ��ǰ�� ��ȸ�ϰ�, 
�� ��ǰ�� �ŷ��ϴ� �� �ŷ�ó�� ���� ������ ���¹�ȣ�� �����ÿ�.
(��, �����-���¹�ȣ).*/

SELECT B.buyer_bankname,
          B.buyer_bankno
FROM buyer B INNER JOIN prod P
                                ON B.buyer_id = P.prod_buyer
                    INNER JOIN cart C
                                ON P.prod_id = C.cart_prod
                    INNER JOIN member M
                                ON M.mem_id = C.cart_member
  WHERE M.mem_add1 LIKE '����%'
      AND M.mem_bir >= '73/01/01'
      AND C.cart_no LIKE '200504%';
--
SELECT buyer_bankname,
          buyer_bankno
FROM buyer 
  WHERE buyer_id IN (SELECT prod_buyer
                              FROM prod
                                WHERE prod_id IN (SELECT cart_prod
                                                            FROM cart
                                                              WHERE cart_member IN(SELECT mem_id
                                                                                                FROM member
                                                                                                  WHERE mem_add1 LIKE '����%'
                                                                                                      AND mem_bir >= '73/01/01')
                                                                  AND cart_no LIKE '200504%'));
/*3.
������ ������ ȸ���� ��
5���̻� ������ ȸ����
4�����Ϸ� ������ ȸ������
������ �������� �ٸ� ������ ������ �����̴�. 
???(ȸ������ ����Ƚ���� ����  ������������ �����ϰ�)
ȸ������ ȸ��id�� ��ȭ��ȣ(HP)�� ��ȸ�϶�.
*/

SELECT mem_id, mem_hp
FROM member 
  WHERE mem_id IN (SELECT cart_member
                              FROM cart
                                WHERE cart_qty >= 5
                                    OR cart_qty <= 4);
----------------------------------------------------

/* 4��
<�¿�>
�輺���� �ֹ��ߴ� ��ǰ�� ����� �����Ǿ� �Ҹ��̴�.
����ó�� ������ ���, ��ǰ ���޿� ������ ���� ����� �ʾ����ٴ� �亯�� �޾Ҵ�.
�輺���� �ش� ��ǰ�� ���� ����ڿ��� ���� ��ȭ�Ͽ� �����ϰ� �ʹ�.
� ��ȣ�� ��ȭ�ؾ� �ϴ°�?
*/

SELECT buyer_charger, buyer_comtel
FROM buyer
  WHERE buyer_id IN (SELECT prod_buyer
                              FROM prod
                                WHERE prod_id IN (SELECT cart_prod
                                                            FROM cart
                                                              WHERE cart_member IN (SELECT mem_id
                                                                                                FROM member
                                                                                                  WHERE mem_name ='�輺��')));
/*
<�°�>
���� �� Ÿ������ ���
��ȯ������ ����ϴ� �ŷ�ó ����ڰ�
����ϴ� ��ǰ�� ������ ȸ������ �̸�, ������ ��ȸ �ϸ� 
�̸��� '��'�� �����ϴ� ȸ������ '��' �� ġȯ�ؼ� ����ض� 
*/

SELECT (DECODE(SUBSTR(mem_name, 1, 1) , 
                      '��', '��' || SUBSTR(mem_name,2,2),
                      mem_name)) AS name,
          mem_bir
FROM member
  WHERE mem_id IN (SELECT cart_member
                              FROM cart
                                WHERE cart_prod IN (SELECT prod_id
                                                              FROM prod
                                                                WHERE prod_buyer IN (SELECT buyer_id
                                                                                                FROM buyer
                                                                                                  WHERE buyer_add1 NOT LIKE '����%'
                                                                                                  AND buyer_bank = '��ȯ����')));

/*
<����>
¦�� �޿� ���ŵ� ��ǰ�� ��
��Ź ���ǰ� �ʿ� ���� ��ǰ���� ID, �̸�, �Ǹ� ������ ����Ͻÿ�.
���� ��� �� ������ ��
�� ���� ���� 10�ۼ�Ʈ ���ϵ� ������, 
���� ���� ���� 10�ۼ�Ʈ �߰��� ������ ����Ͻÿ�.
������ ID, �̸� ������ �����Ͻÿ�.
(��, ������ �Һ��ڰ� - ���԰��� ����Ѵ�.)*/

SELECT prod_id,
          prod_name,
          DECODE( (prod_price - prod_sale) ,
                         (SELECT MAX(prod_price - prod_sale)
                        FROM prod) , ( prod_price - prod_sale) * 0.9,
                         (SELECT MIN(prod_price - prod_sale)
                        FROM prod) , ( prod_price - prod_sale ) * 1.1,
                          prod_price - prod_sale) AS margin
FROM prod;