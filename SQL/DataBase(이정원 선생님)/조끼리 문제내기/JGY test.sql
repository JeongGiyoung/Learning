/* [문제]
신용환님의 2005년 월별로 판매된 총 상품 갯수,
평균판매수량을 조회
2005년 월이 큰 순으로 내림차순 정렬
단 전체 기간 평균 판매 갯수 보다 미만인 수만 조회
Alias 판매일자, 월별 수량 합계 , 월별 합계 
*/

SELECT 
          SUBSTR(cart_no, 1, 6) AS YYYYMM,
          SUM(cart_qty) AS sum_qty,
          AVG(cart_qty) AS avg_qty
FROM cart
  WHERE cart_member = (SELECT mem_id
                                   FROM member
                                    WHERE mem_name = '신용환')
  GROUP BY SUBSTR(cart_no, 1, 6)
  HAVING AVG(cart_qty) < (SELECT AVG(cart_qty) 
                                        FROM cart)
ORDER BY YYYYMM DESC;