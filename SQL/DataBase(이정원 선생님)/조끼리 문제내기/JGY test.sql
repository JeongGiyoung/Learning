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
  WHERE cart_member = (SELECT mem_id
                                   FROM member
                                    WHERE mem_name = '�ſ�ȯ')
  GROUP BY SUBSTR(cart_no, 1, 6)
  HAVING AVG(cart_qty) < (SELECT AVG(cart_qty) 
                                        FROM cart)
ORDER BY YYYYMM DESC;