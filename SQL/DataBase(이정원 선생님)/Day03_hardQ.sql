/* [����]
������ 2005�⵵ 7�� 11���̶� �����ϰ� 
��ٱ��� ���̺� �߻��� �߰��ֹ���ȣ �˻�
Alias �� �������� ���� ���� ���� �ֹ���ȣ, �߰��ֹ���ȣ
*/

SELECT MAX(cart_no), max(cart_no) +1
FROM cart
  WHERE cart_no LIKE '20050711%' ;
  
  /* [��¥ ����]
ȸ�� �� ���� 1975-01-01 ���� 1976-12-31 ���̿� �¾
ȸ���� �˻��Ѵ�.
(Alias�� ȸ��ID, ȸ�� ��, ����) 
*/

/* ȸ�� �߿� ������, �̻��� ȸ���� ���ݱ��� �����ߴ�
��� ��ǰ�� ��ǰ�� ��ȸ�� �ּ���. */

SELECT prod_name
  FROM prod
  WHERE prod_id IN (
          SELECT cart_prod
          FROM cart
          WHERE cart_member IN (
                  SELECT mem_id 
                  FROM member
                  WHERE mem_name = '������'
                      OR mem_name = '�̻���') 
                      )
GROUP BY prod_name
                      ;

------------------------------------------------------
/* [����]
�ſ�ȯ���� 2005�� ������ �Ǹŵ� �� ��ǰ ����,
����Ǹż����� ��ȸ
2005�� ���� ū ������ �������� ����
�� ��ü �Ⱓ ��� �Ǹ� ���� ���� �̸��� ���� ��ȸ
Alias �Ǹ�����, ���� ���� �հ� , ���� �հ� 
*/

SELECT 
          SUBSTR(cart_no, 1, 6) AS YYYYMM,
          SUM(cart_qty) AS sum_qty,
          AVG(cart_qty) AS avg_qty
FROM cart
  WHERE cart_member = 'c001'
  GROUP BY SUBSTR(cart_no, 1, 6)
  HAVING AVG(cart_qty) < 5
ORDER BY YYYYMM DESC;

SELECT cart_member
FROM cart
  WHERE cart_member = 'c001'
  GROUP BY cart_member;
------------------------------------
/* ������ ȸ���� ���� ���ż��� 
-----------------------------------
/*[����]
�ֹε�ϻ� 1������ ȸ���� ���ݱ��� ������ ��ǰ�� ��ǰ�з� ��  
�� �α��ڰ� 01�̸� �ǸŰ��� 10%�����ϰ�
02�� �ǸŰ��� 5%�λ� �������� ���� �ǸŰ��� ����
(�����ǸŰ��� ������ 500,000~1,000,000�� ���̷� ������������ �����Ͻÿ�. (��ȭǥ�� �� õ��������))
*/

SELECT prod_lgu, prod_sale
FROM prod
    WHERE prod_lgu IN(
                                SELECT SUBSTR(cart_prod, 1, 4)
                                FROM cart
                                    WHERE cart_member IN(
                                                                      SELECT mem_id
                                                                      FROM member 
                                                                          WHERE SUBSTR(mem_regno1, 3, 2) = '01')) ;

SELECT SUBSTR(mem_regno1, 3,2)
FROM member;

SELECT prod_name,
           prod_sale,
          DECODE(SUBSTR(prod_lgu, 1, 2) , 
                      'P1', prod_sale * 1.1,
                      -- 'P1', prod_sale + (prod_sale * (10/100)),
                      'P2', prod_sale * 1.15,
                      prod_sale) AS chg_sale
FROM prod
ORDER BY chg_sale ASC;
