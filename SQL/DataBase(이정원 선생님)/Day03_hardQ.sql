/* [문제]
오늘이 2005년도 7월 11일이라 가정하고 
장바구니 테이블에 발생될 추가주문번호 검색
Alias 는 현재년월일 기준 가장 높은 주문번호, 추가주문번호
*/

SELECT MAX(cart_no), max(cart_no) +1
FROM cart
  WHERE cart_no LIKE '20050711%' ;
  
  /* [날짜 형식]
회원 중 생일 1975-01-01 에서 1976-12-31 사이에 태어난
회원을 검색한다.
(Alias는 회원ID, 회원 명, 생일) 
*/

/* 회원 중에 김은대, 이쁜이 회원이 지금까지 구매했던
모든 상품을 상품명별 조회해 주세요. */

SELECT prod_name
  FROM prod
  WHERE prod_id IN (
          SELECT cart_prod
          FROM cart
          WHERE cart_member IN (
                  SELECT mem_id 
                  FROM member
                  WHERE mem_name = '김은대'
                      OR mem_name = '이쁜이') 
                      )
GROUP BY prod_name
                      ;

------------------------------------------------------
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
  WHERE cart_member = 'c001'
  GROUP BY SUBSTR(cart_no, 1, 6)
  HAVING AVG(cart_qty) < 5
ORDER BY YYYYMM DESC;

SELECT cart_member
FROM cart
  WHERE cart_member = 'c001'
  GROUP BY cart_member;
------------------------------------
/* 김윤희 회원의 월별 구매수량 
-----------------------------------
/*[문제]
주민등록상 1월생인 회원이 지금까지 구매한 상품의 상품분류 중  
뒤 두글자가 01이면 판매가를 10%인하하고
02면 판매가를 5%인상 나머지는 동일 판매가로 도출
(변경판매가의 범위는 500,000~1,000,000원 사이로 내림차순으로 도출하시오. (원화표기 및 천단위구분))
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
