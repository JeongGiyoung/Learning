-- �����Բ��� �������ֽ� sql ����(base_table.sql, remain(������).sql) ����

/* 
lprod : ��ǰ�з� ����
prdo : ��ǰ ����
buyer : �ŷ�ó ����
member : ȸ�� ����
cart : ���� ����
buyprod : �԰� ��ǰ ����
remain : ��� ���� ����
*/

--
SELECT mem_id, mem_name 
  FROM member ;
  
-- ��ǰ ���̺�κ��� ��ǰ�ڵ�� ��ǰ�� �˻�
-- 1. ���̺� ã�� 2. ������ �ִ���? 3. � �÷��� ����ϴ���?
SELECT prod_id, prod_name
FROM prod ;

-- ȸ�� ���̺��� ���ϸ����� 12�� ���� ���� �˻�
SELECT mem_mileage,
          (mem_mileage / 12) as mem_12
FROM member ;

/* ��ǰ ���̺��� ��ǰ�ڵ�, ��ǰ��, �Ǹűݾ��� �˻��Ѵ�.
�Ǹűݾ��� = �ǸŴܰ�*55 �� ����Ѵ�.
*/

SELECT prod_id,
          prod_name,
          (prod_sale*55) as prod_sale
      -- (prod_sale*55) "prod_sale"
      -- (prod_sale*55) prod_sale
FROM PROD ;

-- �������̸� �÷����� �ѱ۷� ���� �ʴ´�.

-- ��ǰ ���̺��� �ŷ�ó�ڵ带 �ߺ����� �ʰ� �˻�
-- Alias�� �ŷ�ó

SELECT DISTINCT prod_buyer as �ŷ�ó
FROM PROD ;

-- ȸ�����̺��� ȸ�� ID, ȸ����, ����, ���ϸ��� �˻�
SELECT mem_id, mem_name, mem_bir, mem_mileage
FROM member
ORDER BY mem_id ASC;

--
SELECT mem_id AS id,
            mem_name AS nm,
            mem_bir, mem_mileage
FROM member
  ORDER BY id ASC;

--  �÷� �������� ����
SELECT mem_id AS id,
            mem_name AS nm,
            mem_bir, mem_mileage
FROM member
  ORDER BY 3 ASC;
  
-- ���� �÷����� ����
SELECT mem_id AS id,
            mem_name AS nm,
            mem_bir, mem_mileage
FROM member
  ORDER BY nm, 1 ASC;
  
-- ��ǰ �� �ǸŰ��� 170,000���� ��ǰ ��ȸ
SELECT prod_name ��ǰ, 
          prod_sale �ǸŰ�
  FROM prod 
  WHERE prod_sale = 170000 ;
  
  -- ��ǰ �� �ǸŰ��� 170,000���� �ƴ�
  -- ��ǰ ���̵�� ��ǰ�� ��ȸ
SELECT prod_id, prod_name
  FROM prod
    WHERE prod_sale != 170000 ;
    
/* ��ǰ �ǸŰ����� 170,000 ���� �ʰ��ϴ� 
��ǰ���̵�� ��ǰ�� ��ȸ */

SELECT prod_id, prod_name
  FROM prod
    WHERE prod_sale > 170000 ;
    
/* ��ǰ �߿� ���԰����� 200,000�� ������ ��ǰ �˻�
��, ��ǰ �ڵ带 �������� ��������
��ȸ �÷��� ��ǰ�ڵ�, ���԰���, ��ǰ�� */

SELECT prod_id, prod_cost, prod_name
  FROM prod
    WHERE prod_cost <= 200000 
ORDER BY prod_id DESC ;
  
/* ȸ�� �߿� 76�⵵ 1�� 1�� ���Ŀ� �¾ 
ȸ�� ���̵�, ȸ�� �̸�, �ֹε�Ϲ�ȣ ���ڸ� ��ȸ
��, ȸ�����̵� ���� �������� */

SELECT mem_id, mem_name, mem_regno1
  FROM member
    WHERE mem_regno1 >= 760101
ORDER BY mem_id ASC ;

/* ��ǰ �� ��ǰ�з��� P201(���� ĳ���)�̰�
�ǸŰ��� 170,000���� ��ǰ ��ȸ */

SELECT prod_name
  FROM prod
    WHERE prod_lgu = 'P201'
      AND prod_sale = 170000 ;

/* ��ǰ �� ��ǰ�з��� P201(���� ĳ���) �̰ų�
�ǸŰ��� 170000���� ��ǰ ��ȸ */

SELECT prod_name
  FROM prod
    WHERE prod_lgu = 'P201'
      OR prod_sale = 170000 ;
      
/* ��ǰ �� �ǸŰ��� 300,000�� �̻� 500,000�� ������ ��ǰ�� �˻�
Alias�� ��ǰ�ڵ�, ��ǰ��, �ǸŰ� */

SELECT prod_id as ��ǰ�ڵ�,
          prod_name as ��ǰ��,
          prod_sale as �ǸŰ�
  FROM prod
    WHERE prod_sale >= 300000 
      AND prod_sale <= 500000 ;
      
/* ��ǰ �߿� �ǸŰ����� 15����, 17����, 33������ ��ǰ���� ��ȸ 
��ǰ�ڵ�, ��ǰ��, �ǸŰ����� ���
������ ��ǰ���� �������� �������� */

SELECT prod_id as ��ǰ�ڵ�,
          prod_name as ��ǰ��,
          prod_sale as �ǸŰ�
  FROM prod
    WHERE prod_sale = 150000 
      OR prod_sale = 170000
      OR prod_sale = 330000 
ORDER BY prod_name ASC ;
-- IN ��ɾ ����ϱ�
SELECT prod_name ��ǰ,
        prod_sale �ǸŰ�
        FROM prod
        WHERE prod_sale NOT IN (150000, 170000, 330000)
ORDER BY prod_name ASC ;

/* ȸ�� �߿� ���̵� C001, F001, W001�� ȸ����ȸ
ȸ�����̵�, ȸ���̸� ���
������ �ֹ�ȣ ���ڸ��� �������� �������� */

SELECT mem_id, mem_name
  FROM member
    WHERE mem_id = 'c001'
      OR mem_id = 'f001'
      OR mem_id = 'w001'
ORDER BY mem_regno1 DESC ;

-- Base_table.sql ������ ���鼭 ���̺� ���Ǽ�, ERD ����� ����

-- ��ǰ �з����̺��� ���� ��ǰ���̺� �����ϴ� �з��� �˻�(�з��ڵ�, �з���)
SELECT lprod_gu �з��ڵ�,
      lprod_nm �з���
      FROM lprod
      WHERE lprod_gu IN (SELECT prod_lgu FROM prod) ; 

-- 
SELECT mem_id, mem_name
  FROM member
  WHERE mem_id NOT IN (
          SELECT cart_member
            FROM cart) ;
            
/* �ѹ��� �Ǹŵ� ���� ���� ��ǰ�� ��ȸ�Ϸ��� �մϴ�.
�Ǹŵ� ���� ���� ��ǰ�̸��� ��ȸ���ּ���-*/

SELECT prod_id, prod_name
  FROM prod
  WHERE prod_id NOT IN (
          SELECT cart_prod
            FROM cart) ;
            
/* ȸ�� �߿� ������ ȸ���� ���ݱ��� �����ߴ�
��� ��ǰ���� ��ȸ�� �ּ���. */

/* 
# ���̺� : prod, member, cart
# ���� : mem_name = '������'
# �÷� : prod_name
*/

SELECT prod_name
  FROM prod
  WHERE prod_id IN (
          SELECT cart_prod
          FROM cart
          WHERE cart_member IN (
                  SELECT mem_id 
                  FROM member
                  WHERE mem_name = '������') 
                      );
 /* 
 ��ǰ �� �ǸŰ����� 10���� �̻�, 30���� ������ ��ǰ�� ��ȸ
 ��ȸ �÷��� ��ǰ��, �ǸŰ����Դϴ�.
 ������ �ǸŰ����� �������� �������� �Ѵ�. 
 */
 
 SELECT prod_name, prod_sale
  FROM prod 
  WHERE prod_sale >= 100000 
    AND prod_sale <= 300000
ORDER BY prod_sale DESC ;

-- BETWEEN : �̻�, ���� �񱳿�����
-- NOT BETWEEN

 SELECT prod_name, prod_sale
  FROM prod 
  WHERE prod_sale BETWEEN 100000 
    AND 300000
ORDER BY prod_sale DESC ;

/* [��¥ ����]
ȸ�� �� ���� 1975-01-01 ���� 1976-12-31 ���̿� �¾
ȸ���� �˻��Ѵ�.
(Alias�� ȸ��ID, ȸ�� ��, ����) 
*/

SELECT mem_id AS ȸ��ID,
        mem_name AS ȸ����,
        mem_bir AS ����
    FROM member
    WHERE mem_bir
      BETWEEN '1975-01-01' AND '1976-12-31'
      --BETWEEN '75/01/01' AND '76/12/31'
ORDER BY mem_regno1 DESC
      ;
      
/*
�ŷ� ����� ���������� ����ϴ� ��ǰ�� 
������ ȸ���� ��ȸ�Ѵ�.
ȸ�� ���̵�, ȸ�� �̸��� ��ȸ. 

# ���̺� : member, cart, prod, (lprod), buyer
# ���� : buyer_charger = '������'
# �÷� : mem_id, mem_name
*/
SELECT mem_id, mem_name
    FROM member 
    WHERE mem_id IN (
        SELECT cart_member
        FROM cart
        WHERE cart_prod IN (
            SELECT prod_id
            FROM prod
            WHERE prod_lgu IN (
                SELECT buyer_id
                FROM buyer
                WHERE buyer_charger = '������'))) ;

SELECT mem_id, mem_name
    FROM member 
    WHERE mem_id IN (
        SELECT cart_member
        FROM cart
        WHERE cart_prod IN (
            SELECT prod_id
            FROM prod
            WHERE prod_lgu IN(
                SELECT lprod_gu
                FROM lprod
                WHERE lprod_gu IN (
                    SELECT buyer_lgu
                    FROM buyer
                    WHERE buyer_charger = '������' )))
    )
    ;

/* 
��ǰ �� ���԰��� 300,000~1,500,000�̰�
�ǸŰ��� 800,000~2,000,000 �� ��ǰ�� �˻��Ѵ�.
Alias�� ��ǰ��, ���԰�, �ǸŰ�
*/

SELECT prod_name AS ��ǰ��,
          prod_cost AS ���԰�,
          prod_sale AS �ǸŰ�
FROM prod 
    WHERE prod_cost BETWEEN 300000 AND 1500000
    AND prod_sale BETWEEN 800000 AND 2000000
ORDER BY �ǸŰ� ASC ;

/*
ȸ�� �� ������ 1975�⵵ ���� �ƴ� ȸ���� �˻��Ѵ�.
Alias �� ȸ��ID, ȸ�� ��, ����
*/

SELECT mem_id AS ȸ��ID,
        mem_name AS ȸ����,
        mem_bir AS ����
FROM member
    WHERE mem_bir NOT BETWEEN '75/01/01' AND '75/12/31'
ORDER BY mem_bir ASC 
;

-- LIKE 

-- ȸ�� ���̺��� �达 ���� ���� ȸ���� �˻��Ѵ�.
-- Alias �� ȸ��ID, ����

SELECT mem_id AS ȸ��ID,
    mem_name AS ����
    FROM member
    WHERE mem_name LIKE '��%' ;
    
/* ȸ�����̺��� �ֹε�Ϲ�ȣ ���ڸ��� �˻��Ͽ�
1975����� ������ ȸ���� �˻��Ѵ�.
Alias ȸ��ID, ����, �ֹε�Ϲ�ȣ */

-- || : ���ڿ��� �����ϴ� ���� ������
SELECT mem_id AS ȸ��ID,
        mem_name AS ����,
        mem_regno1 || '-' || mem_regno2 AS �ֹε�Ϲ�ȣ
        FROM member 
        WHERE mem_regno1 NOT LIKE '75%'
        ;
        
-- CONCAT : �� ���ڿ��� �����Ͽ� ��ȯ

SELECT CONCAT('My Name is ', mem_name) FROM member ;

-- 
SELECT CHR(65) "CHR" , ASCII('A') "ASCII"
    FROM dual ;
    
-- LOWER, UPPER, INITCAP

SELECT lower('DATA maniqulation Language') "LOWER" ,
    UPPER('DATA maniqulation Language') "UPPER" ,
    INITCAP('DATA maniqulation Language') "INITCAP"
    FROM dual ;
    
# ȸ�����̺��� ȸ�� ID�� �빮�ڷ� ��ȯ�Ͽ� �˻��Ѵ�.

SELECT UPPER(mem_id)
    FROM member ;


-- LPAD, RPAD

-- LTRIM, RTRIM : ��������

-- SUBSTR : ���ڿ� �ڸ��� �Լ�

-- TRANSLATE 

-- REPLACE
    
/* ȸ�����̺��� ȸ������ �� ���� '��' --> '��'�� ġȯ�Ͽ�
�ڿ� �̸��� ���� �� �˻��Ѵ�.
Alias�� ȸ����, ȸ����ġȯ */

SELECT CONCAT(SUBSTR(REPLACE(mem_name, '��', '��') , 1, 1) ,
    SUBSTR(mem_name, 2)) AS ȸ����
FROM member ;

-- INSTR

-- GREATEST, LEAST

-- ROUND

-- TRUNC

-- MOD : ���� ������ ��

-- SYSDATE

SELECT SYSDATE -1
FROM dual ; 

-- ADD_MONTHS 

SELECT ADD_MONTHS(SYSDATE, 5) FROM dual ;

-- NEXT_DAY, LAST_DAY
Select NEXT_Day(Sysdate, '������'), 
        Last_day(Sysdate)
        FROM dual ;
        
-- �̹� ���� ��ĥ�� ���Ҵ��� �˻�

SELECT LAST_DAY(SYSDATE) - SYSDATE
    FROM dual ;
    
-- EXTRACT : ��¥���� �ʿ��� �κи� ����

SELECT EXTRACT(YEAR FROM SYSDATE) "�⵵",
    EXTRACT(MONTH FROM SYSDATE) "��",
    EXTRACT(DAY FROM SYSDATE) "����"
    FROM dual ; 
    
-- ���� 3���� ȸ���� �˻�

SELECT mem_name, mem_bir, 
    EXTRACT(MONTH FROM mem_bir) AS �¾��
    FROM member 
      WHERE EXTRACT(MONTH FROM mem_bir) = 3
ORDER BY mem_bir ASC ;

/*
ȸ�� ���� �� 1973����� �ַ� ������ ��ǰ�� ������������ ��ȸ
- ��ȸ �÷� : ��ǰ��
- ��, ��ǰ�� �Ｚ�� ���Ե� ��ǰ�� ��ȸ,
    �׸��� ��ȸ��� �ߺ� ����

*/

SELECT DISTINCT(prod_name)
  FROM prod
  WHERE prod_name LIKE '%�Ｚ%'
  AND prod_id IN(
      SELECT cart_prod
      FROM cart
          WHERE cart_member IN(
          SELECT mem_id
          FROM member
              --WHERE mem_bir BETWEEN '73/01/01' AND '73/12/31'
              WHERE EXTRACT(YEAR FROM mem_bir) = 1973
      )
  )
ORDER BY prod_name ASC ;

-- CAST() : ��������� �� ��ȯ

-- (**�ſ� �߿�**) TO_CHAR : ����, ����, ��¥ ������ ���ڿ��� ��ȯ
-- TO_NUMBER : ���������� ���ڿ��� ���ڷ� ��ȯ
-- TO_DATE : ��¥������ ���ڿ��� ��¥�� ��ȯ

-- TO_CHAR�� ���� ���̴� ����
SELECT 
    TO_CHAR(CAST('2008-12-25' AS DATE),
        'YYYY.MM.DD HH24:MI')
        FROM dual ;
        
/*
��ǰ���̺��� ��ǰ�԰����� '2008-09-28'�������� ������ �˻�
Alias ��ǰ��, ��ǰ�ǸŰ�, �԰��� */

SELECT prod_name AS ��ǰ��,
    prod_sale AS ��ǰ�ǸŰ�,
    TO_CHAR(CAST(prod_insdate AS DATE),
        'YYYY-MM-DD DAY') AS �԰���
    FROM prod
ORDER BY �԰��� ASC ;

/*
ȸ���̸��� ���Ϸ� ����ó�� ���
'��������� 1976�� 1�� ����̰� �¾ ������ �����'
*/

SELECT 
    mem_name || '���� ' ||
    TO_CHAR(
        CAST(mem_bir AS DATE),
            'YYYY') || '�� ' ||
    TO_CHAR(
        CAST(mem_bir AS DATE),
            'MM') || '�� ����̰� �¾ ������ ' ||
    TO_CHAR(
        CAST(mem_bir AS DATE),
            'DAY') AS ����        
    FROM member ;

-- 9�� ���õ� ���ڿ� �����ϴ� ���ڿ� ����.
-- 0�� ���õ� ���ڿ� �������� �ʴ� ���ڿ� ����.
SELECT TO_CHAR(1234.6, '99,999.00')
  FROM dual ;
  
-- L : ���� ȭ�� ��ȣ, 
-- PR : ������ <> ��ȣ ǥ��
SELECT TO_CHAR(-1234.6, 'L9999.00PR')
  FROM dual ;

/* 
��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, ���԰���, �Һ��ڰ���, �ǸŰ����� ���
��, ������ õ���� ���� �� ��ȭǥ��
*/

SELECT prod_id AS ��ǰ�ڵ�,
    prod_name AS ��ǰ��,
    TO_CHAR(prod_cost, 'L999,999,999') AS ���԰���,
    TO_CHAR(prod_price, 'L999,999,999') AS �Һ��ڰ���,
    TO_CHAR(prod_sale, 'L999,999,999') AS �ǸŰ���
    FROM prod ;
    
/*  ȸ�����̺��� �̻��� ȸ����
ȸ�� ID 2~4 ���ڿ��� ���������� ġȯ�� ��
10�� ���Ͽ� ���ο� ȸ�� ID�� �����Ѵ�.
*/

SELECT CONCAT(SUBSTR(mem_id, 1,2) , SUBSTR(mem_id, 3, 4) + 10)
    FROM member
    WHERE mem_name = '�̻���'
    ;

/*
AVG : ���
[��Ģ]
�Ϲ��÷��� �׷��Լ�(AVG, MAX, MIN, SUM, COUNT ����)�� ���� ����� ��쿡��
�� Group By ���� �־� �־�� �Ѵ�.
Group by ������ �Ϲ��÷��� ��� ���� �Ѵ�.
*/

SELECT prod_lgu,
          ROUND(AVG(prod_cost), 2) "�з��� ���԰��� ���"
    FROM prod
GROUP BY prod_lgu ;

-- ��ǰ���̺��� �ǸŰ��� ��� ���� ���Ѵ�.
-- Alias�� ��ǰ �Ǹ� ���� ���

SELECT ROUND(AVG(prod_sale ), 2) "��ǰ �Ǹ� ���� ���"
    FROM prod ;

-- ��ǰ���̺��� ��ǰ�з��� �ǸŰ��� ��� ���� ���Ѵ�.
SELECT prod_lgu, AVG(prod_sale) as avg_sale
FROM prod
GROUP by prod_lgu;

-- COUNT()

/* ��ٱ��� ���̺��� ȸ���� COUNT ����
Alias�� ȸ�� ID, �ڷ��(DISTINCT), �ڷ��, �ڷ��(*)
*/

SELECT cart_member AS "ȸ�� ID",
            COUNT(cart_member) �ڷ��        
    FROM cart 
GROUP BY cart_member;

/* ���ż����� ��ü��� �̻��� ������ ȸ������
���̵�� �̸��� ��ȸ
��, ������ �ֹι�ȣ(��)�� �������� ��������*/

SELECT mem_id,
            mem_name
    FROM member
        WHERE mem_id in(
            SELECT cart_member
            FROM cart
                WHERE cart_qty >= 
                    (SELECT AVG(cart_qty)  -- hint. AVG() �Լ��� �ܵ����� ����� �� ����.
                    FROM cart))
ORDER BY mem_regno1 ASC ;

-- COUNT(*) : ���� ������ ����.
-- COUNT() �� Null ���� �����ϰ� ���� ������ �ٸ���.

/* 
���ų���(��ٱ���) �������� ȸ�����̵𺰷� �ֹ�(����)�� ����
����� ��ȸ
ȸ�� ���̵� �������� ��������
*/

SELECT cart_member AS ȸ�� , ROUND(AVG(cart_qty), 1) AS avg_qty
    FROM cart
    Group BY cart_member
ORDER BY cart_member DESC;

/* [����]
��ǰ�������� �ǸŰ����� ��� ���� ���Ѵ�.
��, ��հ��� �Ҽ��� 2° �ڸ����� ǥ���Ѵ�.
*/

SELECT ROUND(AVG(prod_sale), 2) AS avg_sale
    FROM prod ;
    
/* [����]
��ǰ�������� ��ǰ�з��� �ǸŰ����� ��հ��� ���Ѵ�.
��ȸ �÷��� ��ǰ�з��ڵ�, ��ǰ�з��� �ǸŰ����� ���
��, ��հ��� �Ҽ��� 2 ��° �ڸ����� ǥ��
*/

SELECT prod_lgu, ROUND(AVG(prod_sale), 2) AS avg_sale
  FROM prod
  GROUP BY prod_lgu
ORDER BY prod_lgu, avg_sale  ;

-- ȸ�����̺��� ����������� COUNT ����
-- Alias ���������

SELECT count(mem_like) ���������
  FROM member ;
  
/* ȸ�����̺��� ��̺� COUNT ����
(Alias�� ���, �ڷ��, �ڷ��(*) ) */

SELECT mem_like AS "���", 
          count(mem_like) AS �ڷ��,
          count(*) AS "�ڷ��(*)"
  FROM member
  GROUP BY mem_like ;
  
/* ȸ�����̺��� ������������ COUNT����
(Alias�� ����������) */

SELECT COUNT(DISTINCT(mem_job)) AS ����������
  FROM member ;
  
/* [����]
ȸ�� ��ü�� ���ϸ��� ��պ��� ū ȸ���� ����
���̵�, �̸�, ���ϸ����� ��ȸ
���ϸ����� ���� ������ ����
*/

SELECT mem_id, mem_name, mem_mileage
FROM member
    WHERE mem_mileage >= (SELECT AVG(mem_mileage) FROM member)
ORDER BY mem_mileage DESC ;

/* [����]
������ 2005�⵵ 7�� 11���̶� �����ϰ� 
��ٱ��� ���̺� �߻��� �߰��ֹ���ȣ �˻�
Alias �� �������� ���� ���� ���� �ֹ���ȣ, �߰��ֹ���ȣ
*/

SELECT MAX(cart_no), max(cart_no) +1
FROM cart
  WHERE cart_no LIKE '20050711%' ;
  
/* [����]
������������ �⵵���� �Ǹŵ� ��ǰ�� ����,
��ձ��ż����� ��ȸ
�⵵ ���� �������� ����
*/

SELECT SUBSTR(cart_no, 1, 4) AS yyyy,
          SUM(cart_qty) AS sum_qty,
          AVG(cart_qty) AS avg_qty
FROM cart
  GROUP BY SUBSTR(cart_no, 1, 4)
ORDER BY yyyy DESC;

/* [����]
������������ �⵵��, ��ǰ�з��ڵ庰�� ��ǰ�� ������ ��ȸ
�⵵�� �������� �������� ���� 
*/

SELECT SUBSTR(cart_no, 1, 4) AS yyyy,
          SUBSTR(cart_prod, 1, 4) AS lgu,
          COUNT(cart_prod)
FROM cart
  GROUP BY SUBSTR(cart_no, 1, 4), 
                  SUBSTR(cart_prod, 1, 4)
ORDER BY yyyy DESC
;

/* [����]
ȸ�����̺��� ȸ����ü�� 
���ϸ��� ���, ���ϸ��� �հ�, �ְ� ���ϸ���, �ּ� ���ϸ���, �ο��� �˻�
Alias ���� ���õ� ���
*/

SELECT AVG(mem_mileage) AS ���ϸ������,
          SUM(mem_mileage) AS ���ϸ����հ�, 
          MAX(mem_mileage) AS �ְ��ϸ���,
          MIN(mem_mileage) AS �ּҸ��ϸ���,
          COUNT(*) AS �ο���
FROM member
;

/* [����]
��ǰ���̺��� ��ǰ�з��� �ǸŰ� ��ü��
���,�հ�,�ְ�, ������, �ڷ���� �˻�
Alias �� ���� ���õ� ���
��, �ڷ���� 20�� �̻��� ��
*/

SELECT prod_lgu,
          TO_CHAR(ROUND(AVG(prod_sale), 2), 'L999,999,999')  ���,
          TO_CHAR(SUM(prod_sale), 'L999,999,999') �հ�,
          TO_CHAR(MAX(prod_sale), 'L999,999,999') �ְ�,
          TO_CHAR(MIN(prod_sale), 'L999,999,999') ������,
          COUNT(prod_sale) �ڷ��
FROM prod
  GROUP BY prod_lgu
    HAVING COUNT(prod_sale) >= 20
;

-- WHERE �� : �Ϲ��������θ� ���
-- HAVING �� : �׷��������θ� ���

/* [����]
ȸ�����̺���
����(�ּ�1�� ó�� 2�ڸ�) , ���ϳ⵵���� 
���ϸ��� ���, ���ϸ��� �հ�, �ְ� ���ϸ���, �ּ� ���ϸ���, �ڷ�� �˻�
Alias ������ ���� ������ 
*/

SELECT SUBSTR(mem_add1, 1, 2) AS reg, 
          TO_CHAR(mem_bir, 'YYYY') AS YYYY,
          AVG(mem_mileage) avg_m,
          SUM(mem_mileage) sum_m,
          MAX(mem_mileage) max_m,
          MIN(mem_mileage) min_m,
          COUNT(mem_mileage) cnt_m
FROM member
  GROUP BY SUBSTR(mem_add1, 1, 2), 
                  TO_CHAR(mem_bir, 'YYYY')
ORDER BY reg, YYYY
;

--�ŷ�ó ����� ������ '��'�̸� NULL ����(commit X)

UPDATE buyer SET buyer_charger = NULL
  WHERE buyer_charger LIKE '��%' ;
  
SELECT buyer_name �ŷ�ó, buyer_charger �����
FROM buyer
  WHERE buyer_charger LIKE '��%' ;
  
-- �ŷ�ó ����� ������ '��'�̸� Whiter Space�� ����(commit X)
UPDATE buyer SET buyer_charger =''
  WHERE buyer_charger LIKE '��%' ;
  
SELECT buyer_name �ŷ�ó, buyer_charger �����
FROM buyer
  WHERE buyer_charger LIKE '��%' ;
  
--
SELECT buyer_name �ŷ�ó, buyer_charger �����
FROM buyer
  WHERE buyer_charger = NULL ;

--
SELECT buyer_name �ŷ�ó, buyer_charger �����
FROM buyer
  WHERE buyer_charger IS NOT NULL ;
  
-- 
SELECT buyer_name �ŷ�ó, buyer_charger �����
FROM buyer ;

SELECT buyer_name �ŷ�ó, 
          NVL(buyer_charger, '-') �����
FROM buyer;

-- NVL( , )
/* ȸ�� ���ϸ����� 100�� ���� ��ġ�� �˻�
 ����, ���ϸ���, ���� ���ϸ���
*/
SELECT mem_name,
            mem_mileage,
            (NVL(mem_mileage, 0) + 100)
FROM member
;

-- NVL2( , , )

/*[����]
ȸ�� ���ϸ����� ������ '���� ȸ��' 
NULL�̸� '������ ȸ��'���� �˻�
����, ���ϸ���, ȸ������ ��ȸ
*/

SELECT mem_name, 
            mem_mileage, 
            NVL2(mem_mileage, '���� ȸ��', '������ ȸ��') AS stat_mem
FROM member;

--[�߿�] DECODE ( , ... , ) : if ���� ����

SELECT DECODE ( SUBSTR(prod_lgu, 1, 2) ,
                        'P1', '��ǻ��/���� ����', -- �� �־�
                        'P2', '�Ƿ�',
                        'P3', '��ȭ', 
                        '��Ÿ' ) -- ���ǿ� ���Ե��� ���� �� ��µǴ� ��
FROM prod ;

/*[����]
��ǰ �з� �� ���� �� ���ڰ� 'P1'�̸� �ǸŰ��� 10% �λ��ϰ�,
'P2' �̸� �ǸŰ��� 15%�λ��ϰ�, �������� ���� �ǸŰ��� �˻�
(DECODE �Լ� �̿�, Alias �� ������)
*/

SELECT prod_name,
           prod_sale,
          DECODE(SUBSTR(prod_lgu, 1, 2) , 
                      'P1', prod_sale * 1.1,
                      -- 'P1', prod_sale + (prod_sale * (10/100)),
                      'P2', prod_sale * 1.15,
                      prod_sale) AS chg_sale
FROM prod
ORDER BY chg_sale ASC
;

-- CASE WHEN THEN ELSE END

/* [����]
ȸ���������̺��� �ֹε�� ���ڸ����� 
���� ���� �˻�
(CASE ���� ���, Alias ȸ����, �ֹε�Ϲ�ȣ, ����)
*/

SELECT mem_name AS "�� ��" ,
          (mem_regno1 || '-' || mem_regno2) AS "regno",
          (CASE WHEN MOD(SUBSTR(mem_regno2, 1, 1), 2) = 1 THEN '����'
                  WHEN MOD(SUBSTR(mem_regno2, 1, 1), 2) = 0 THEN '����'
                  -- ELSE 
                  END) AS "sex"
FROM member
;

/* [����]
ȸ������ �߿� ���ų����� �ִ� ȸ���� ����
ȸ�����̵�, ȸ���̸�, ����(0000-00-00 ����)�� ��ȸ
������ �������� �������� ����
*/

SELECT mem_id, 
          mem_name, 
          TO_CHAR(mem_bir, 'YYYY-MM-DD') AS bir_date
FROM member
  WHERE mem_id IN (
                              SELECT cart_member
                              FROM cart)
ORDER BY bir_date ASC
;

/*
EXISTS ()
IN �Լ��ϰ� ����� ���� ���������, 
IN�� ��ȸ�Ǵ� �����Ͱ� ���Ƽ� ��ȸ�ð��� �������.
�׷��� IN�� ������� �ʴ´�.*/

SELECT prod_id, prod_name, prod_lgu
FROM prod
  WHERE prod_lgu IN (SELECT lprod_gu
                                FROM lprod
                                  WHERE lprod_nm = '������ȭ') ;
                                  
SELECT prod_id, prod_name, prod_lgu
FROM prod
  WHERE EXISTS (SELECT lprod_gu
                        FROM lprod
                          WHERE lprod_gu = prod.prod_lgu
                                    AND lprod_gu = 'P301') ;

/* 
# SELECT * FROM lprod, prod : Cartesian Product / Cross Join 
  * ��� �����͸� �����Ѵ�.
  * ����Ǽ��� �ſ� �������� ���¸� �ʷ��ϱ� ������ �ǹ������� ���� ���� ���� ����.
*/

SELECT COUNT(*)
FROM lprod, prod, buyer;

-- CROSS JOIN
-- ���̺� ��Ī�� ���� ���� 'AS'�� ���� �ʴ´�.

--�Ϲ� ���
SELECT m.mem_id, c.cart_member, p.prod_id
FROM member m, cart c, prod p, lprod lp, buyer b;

--[����ǥ�ع��(ANSI)] : �ٸ� DBMS ������ �����ϰ� ���

SELECT *
FROM member Cross Join cart 
                      Cross Join prod
                      Cross Join lprod
                      Cross Join buyer;
                      
/*
[Equi Join (Simple Join Ȥ�� Inner Join) ]
# ��������(PK, FK�� ����)��(���ǽ�)�� �ʿ��ϴ�
# Column���� Table���� �ٿ��� �Ѵ�.
# FROM���� �ҷ��帮�� ���̺� n���� -1����ŭ WHERE ���� ���ǽ��� �ּ��� �ʿ��ϴ�.
*/

--(�Ϲݹ��) ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з����� ��ȸ
SELECT prod.prod_id "��ǰ�ڵ�",
          prod.prod_name "��ǰ��",
          lprod.lprod_nm "�з���"
FROM prod, lprod
-- �������ǽ��� ���� ���� �ۼ�
  WHERE prod.prod_lgu = lprod.lprod_gu;
  
--(ANSI ����ǥ�ع��) 
SELECT prod.prod_id "��ǰ�ڵ�",
          prod.prod_name "��ǰ��",
          lprod.lprod_nm "�з���"
FROM prod INNER JOIN lprod
                ON (prod.prod_lgu = lprod.lprod_gu);

--�Ϲݹ��
SELECT A.prod_id "��ǰ�ڵ�",
          A.prod_name "��ǰ��",
          B.lprod_nm "�з���",
          C.buyer_name "�ŷ�ó��"
FROM prod A, lprod B, buyer C
  WHERE A.prod_lgu = B.lprod_gu
            AND A.prod_buyer = C.buyer_id;
            
-- ANSI
SELECT A.prod_id "��ǰ�ڵ�",
          A.prod_name "��ǰ��",
          B.lprod_nm "�з���",
          C.buyer_name "�ŷ�ó��"
FROM prod A INNER JOIN lprod B
                      ON (A.prod_lgu = B.lprod_gu)
                   INNER JOIN buyer C
                      ON (A.prod_buyer = C.buyer_id);

/*[����]
ȸ���� ������ �ŷ�ó ������ ��ȸ
ȸ�����̵�, ȸ���̸�, ��ǰ�ŷ�ó��, ��ǰ�з����� ��ȸ
*/

/* [Ǯ��]
# ����� ���̺� : member, cart, prod, buyer, lprod
# ��ȸ�� �÷� : mem_id, mem_name, buyer_name, lprod_nm
# �������� : 
  * mem_id = cart_member
  * cart_prod = prod_id
  * prod_buyer = buyer_id 
  * prod_lgu = lprod_gu
# �Ϲݹ�� : ����
*/

SELECT M.mem_id,
          M.mem_name, 
          B.buyer_name, 
          L.lprod_nm
FROM member M, buyer B, cart C, prod P, lprod L
  WHERE M.mem_id = C.cart_member
      AND P.prod_id = C.cart_prod
      AND B.buyer_id = P.prod_buyer
      AND L.lprod_gu = B.buyer_lgu ;
            
--ANSI ���            
SELECT M.mem_id,
          M.mem_name, 
          B.buyer_name, 
          L.lprod_nm
FROM member M INNER JOIN cart C
                              ON (M.mem_id = C.cart_member)
                          INNER JOIN prod P
                              ON (P.prod_id = C.cart_prod)
                           INNER JOIN buyer B 
                              ON (B.buyer_id = P.prod_buyer)
                           INNER JOIN lprod L
                              ON (L.lprod_gu = B.buyer_lgu) ;

/* [����]
�ŷ�ó�� '�Ｚ����'�� �ڷῡ ����
��ǰ�ڵ�, ��ǰ��, �ŷ�ó���� ��ȸ
*/

/*[Ǯ��]
# ���̺� : prod, buyer
# ��ȸ�÷� : prod_id, prod_name, buyer_name
# �������� : prod_buyer = buyer_id
# �Ϲ����� : buyer_name = '�Ｚ����'
*/

SELECT P.prod_id,
          P.prod_name,
          B.buyer_name
FROM prod P, buyer B
  WHERE B.buyer_id = P.prod_buyer
      AND B.buyer_name = '�Ｚ����';

--

SELECT P.prod_id,
          P.prod_name,
          B.buyer_name
FROM prod P INNER JOIN buyer B
                              ON (B.buyer_id = P.prod_buyer)
  WHERE B.buyer_name = '�Ｚ����' ;

--  

SELECT P.prod_id,
          P.prod_name,
          B.buyer_name
FROM prod P INNER JOIN buyer B
                              ON (B.buyer_id = P.prod_buyer
                                    AND B.buyer_name = '�Ｚ����');
                                    
/* [����]
��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з���, �ŷ�ó��, �ŷ�ó�ּ� ��ȸ
1) �ǸŰ����� 10���� �����̰�
2) �ŷ�ó �ּҰ� �λ��� ��츸 ��ȸ
*/

/*[Ǯ��]
# ���̺� : prod, lprod, buyer
# ��ȸ�÷� : prod_id, prod_name, lprod_nm, buyer_name
# �������� : prod_lgu = lprod_gu,
                prod_buyer = buyer_id
# �Ϲ����� : prod_sale <= 100000,
                buyer_add1 LIKE '%�λ�%'
*/

SELECT P.prod_id,
          P.prod_name,
          L.lprod_nm,
          B.buyer_name,
          B.buyer_add1
FROM prod P INNER JOIN lprod L
                                ON L.lprod_gu = P.prod_lgu
                   INNER JOIN buyer B
                                ON L.lprod_gu = B.buyer_lgu
  WHERE P.prod_sale <= 100000
      AND B.buyer_add1 LIKE '%�λ�%' ;

SELECT P.prod_id,
          P.prod_name,
          L.lprod_nm,
          B.buyer_name,
          B.buyer_add1
FROM prod P, lprod L, buyer B
  WHERE L.lprod_gu = P.prod_lgu
      AND P.prod_buyer = B.buyer_id
      AND P.prod_sale <= 100000
      AND SUBSTR(B.buyer_add1,1,2) = '�λ�';

/* [����]
��ǰ�з��ڵ尡 P101 �� �Ϳ� ����
��ǰ�з���, ��ǰ���̵�, �ǸŰ�, �ŷ�ó�����, ȸ�����̵�, �ֹ����� ��ȸ
��, ��ǰ�з����� �������� ��������, ��ǰ���̵� �������� ��������
�Ϲ�/ǥ�� ��� ��� ǥ��
*/

/* [Ǯ��]
# ���̺� : lprod, prod, buyer, cart
# ��ȸ�÷� : lprod_nm, prod_id, prod_sale, buyer_charger, cart_member, cart_qty
# �������� : 
  * lprod_gu = prod_lgu
  * buyer_id = prod_buyer
  * prod_id = cart_prod
# �Ϲ����� :
  * lprod_gu = 'P101'
# ���� : 
  * ORDER BY lprod_nm DESC, prod_id ASC
*/

SELECT L.lprod_nm,
           P.prod_id,
           P.prod_sale,
           B.buyer_charger,
           C.cart_member,
            C.cart_qty
FROM lprod L, prod P, buyer B, cart C
  WHERE  L.lprod_gu = P.prod_lgu
        AND B.buyer_id = P.prod_buyer
        AND P.prod_id = C.cart_prod
        AND L.lprod_gu = 'P101'
ORDER BY L.lprod_nm DESC, P.prod_id ASC;

--

SELECT L.lprod_nm,
           P.prod_id,
           P.prod_sale,
           B.buyer_charger,
           C.cart_member,
            C.cart_qty
FROM lprod L INNER JOIN prod P
                              ON L.lprod_gu = P.prod_lgu
                    INNER JOIN buyer B
                              ON B.buyer_id = P.prod_buyer
                    INNER JOIN cart C
                              ON P.prod_id = C.cart_prod
  WHERE L.lprod_gu = 'P101'
ORDER BY L.lprod_nm DESC, P.prod_id ASC;

--
/* ����
��ǰ�з���, ��ǰ��, ��ǰ����, ���Լ���, �ֹ�����, �ŷ�ó���� ��ȸ
��, ��ǰ�з� �ڵ尡 'P101', 'P201', 'P301' �� �͵鿡 ���� ��ȸ�ϰ� 
���Լ����� 15�� �̻��� �͵��, 
'����'�� ��� �ִ� ȸ�� �߿� ���� 1974�� ���� ����鿡 ���� ��ȸ
������ ȸ�����̵� �������� ��������, ���Լ����� �������� ��������
*Join�� �Ϲ�/ǥ�ع�� ��� �ۼ�
*/

SELECT L.lprod_nm,
          P.prod_name,
          P.prod_color,
          Bp.buy_qty,
          C.cart_qty,
          B.buyer_name
FROM prod P INNER JOIN buyer B
                                ON B.buyer_id = P.prod_buyer
                   INNER JOIN lprod L
                                ON L.lprod_gu = P.prod_lgu
                   INNER JOIN buyprod Bp
                                ON P.prod_id = Bp.buy_prod
                   INNER JOIN cart C
                                ON P.prod_id = C.cart_prod
                   INNER JOIN member M
                                ON M.mem_id = C.cart_member
  WHERE L.lprod_gu IN ('P101', 'P201', 'P301')
      AND Bp.buy_qty >= 15
      AND M.mem_add1 LIKE '����%'
      AND EXTRACT(YEAR FROM M.mem_bir) = 1974
          -- TO_CHAR(mem_bir, 'yyyy') = '1974'
ORDER BY M.mem_id DESC, Bp.buy_qty DESC;
--
SELECT L.lprod_nm,
          P.prod_name,
          P.prod_color,
          Bp.buy_qty,
          C.cart_qty,
          B.buyer_name
FROM prod P, buyer B, lprod L, buyprod Bp, cart C, member M
  WHERE B.buyer_id = P.prod_buyer
      AND L.lprod_gu = P.prod_lgu
      AND P.prod_id = Bp.buy_prod
      AND P.prod_id = C.cart_prod
      AND M.mem_id = C.cart_member
      AND L.lprod_gu IN ('P101', 'P201', 'P301')
      AND Bp.buy_qty >= 15
      AND M.mem_add1 LIKE '����%'
      AND EXTRACT(YEAR FROM M.mem_bir) = 1974
ORDER BY M.mem_id DESC, Bp.buy_qty DESC;

/* OUTER JOIN
# INNER JOIN�� ��� ���ǽ��� �������� �ʴ� �����ʹ� �����ȴ�.
# �̷� ������ �����͵� �ʿ��� �� OUTER JOIN�� ���
# �Ϲݹ�� : (+) ������ ��ȣ�� �پ��ִ� �ʿ��� NULL �� �ִ��� ���
  * FK �ʿ� (+) �� �ٴ´�.
    - PK �ʿ� (+)�� ���� ���� ������, ����� ��ȭ�� ���� �ʱ� ������ OUTER JOIN�� �ǹ̰� ����.
      + PK ���̺���  FK ���̺� �÷��� ��� ������ �ֱ� ����
# �ַ� LEFT OUTER JOIN �� ��������� ������ �����ʿ� �ΰ� �ʹٸ� RIGHT OUTER JOIN�� ����.

/* ��ü �з��� ��ǰ�ڷ� ���� �˻�
(�з��ڵ�, �з���, ��ǰ�ڷ��) */

SELECT * FROM lprod;

SELECT lprod_gu,
          lprod_nm,
          COUNT(prod_lgu) AS cnt_lgu
FROM lprod, prod
  WHERE lprod_gu = prod_lgu(+)
  GROUP By lprod_gu, lprod_nm;
--
SELECT lprod_gu,
          lprod_nm,
          COUNT(prod_lgu) AS cnt_lgu
FROM lprod, prod
  WHERE lprod_gu(+) = prod_lgu
  GROUP By lprod_gu, lprod_nm;

-- ANSI
SELECT lprod_gu,
          lprod_nm,
          COUNT(prod_lgu) AS cnt_lgu
FROM lprod LEFT OUTER JOIN prod
                                    ON (lprod_gu = prod_lgu)
    GROUP By lprod_gu, lprod_nm;

/* [����]
��ü��ǰ�� 2005�� 1�� �԰������ �˻�. null �� ����
(��ǰ�ڵ�, ��ǰ��, �԰���� ��ȸ) */

/* �Ϲ� ��Ŀ��� WHERE ���� ���� OUTER JOIN �� ����������
OUTER JOIN�� ����� ���� WHERE ���� ������� �ʴ´�. */

SELECT prod_id,
          prod_name,
          SUM(buy_qty)
FROM lprod, buyprod
  WHERE lprod_gu = prod_lgu(+)
      AND buy_date BETWEEN 20050101 AND 20050131
    GROUP By lprod_gu, lprod_nm, buy_qty ;

-- ANSI
SELECT prod_id,
          prod_name,
          NVL(SUM(buy_qty),0) AS sum_buy
FROM prod LEFT OUTER JOIN buyprod
                        ON (prod_id = buy_prod
                              AND buy_date BETWEEN '2005-01-01' 
                                                        AND '2005-01-31')
GROUP BY prod_id, prod_name
ORDER BY prod_id, prod_name;

/* ��ü ȸ���� 2005�⵵ 4���� ������Ȳ ��ȸ
(ȸ�� ID, ����, ���ż����� ��) */

SELECT mem_id,
          mem_name,
          NVL(SUM(cart_qty),0)
FROM member LEFT OUTER JOIN cart
                                        ON (mem_id = cart_member
                                              AND CAST(SUBSTR(cart_no,1,8) AS DATE)  
                                              -- AND SUBSTR(cart_no,1,6) = '200504'
                                                                                                      BETWEEN '2005-04-01' 
                                                                                                              AND '2005-04-30')
  GROUP BY mem_id, mem_name;
  
/* 2005�⵵ ���� �Ǹ� ��Ȳ �˻�
(�Ǹſ�, �Ǹż���, �Ǹűݾ�(�Ǹż���*��ǰ���̺��� �ǸŰ�))
*/

SELECT SUBSTR(cart_no, 5,2) AS mm,
          SUM(cart_qty),
          TO_CHAR(SUM(cart_qty * prod_sale), 'L999,999,999') AS sum_sale
FROM cart , prod
  WHERE cart_prod = prod_id
      AND cart_no LIKE '2005%'
  GROUP BY SUBSTR(cart_no, 5,2)
ORDER BY mm;

-- GROUP �Լ��� ����� ��쿡 �߰� ������ �ִٸ�

/* ��ǰ�з��� ��ǻ����ǰ('P101')�� ��ǰ�� 2005�⵵ ���ں� �Ǹ� ��ȸ
(�Ǹ���, �Ǹűݾ�(5,000,000 �ʰ��� ��츸), �Ǹż��� ��ȸ)
*/
SELECT SUBSTR(cart_no, 1, 8),
          SUM(cart_qty * prod_sale) AS sum_sale,
          SUM(cart_qty) AS sum_qty
FROM cart, prod
  WHERE prod_id = cart_prod
      AND prod_lgu = 'P101'
      AND SUBSTR(cart_no, 1, 4) = '2005'
  GROUP BY SUBSTR(cart_no, 1, 8)
    HAVING SUM(cart_qty * prod_sale) > 5000000
ORDER BY SUBSTR(cart_no, 1, 8) ASC;
  
  
/* [��������] 
# SQL ���� �ȿ� �Ǵٸ� SELECT ������ �ִ� ��.
# �����ϸ� JOIN�� ����ϰ� JOIN �� �ȵ� �� ���
# ANY = ���� ���� �� 1���� ���� ��
# ALL = ���� ���� �� ��� ���� ��
-
SELECT (1�� �÷�, 1�� ��)
FROM (���� �÷�, ���� ��)
  WHERE >= (1�� �÷�, 1�� ��)
        IN (1��, ���� ��)
    EXIST (���� �÷�, ���� ��
*/

