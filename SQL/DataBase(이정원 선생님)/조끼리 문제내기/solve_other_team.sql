/*
조이름 : 빅데이터 조지'조'
조원: 김경수,정기영,정인철,전귀영

[1문제]

주민등록상 1월생인 회원이 지금까지 구매한 상품의 상품분류 중  
뒤 두글자가 01이면 판매가를 10%인하하고
02면 판매가를 5%인상 나머지는 동일 판매가로 도출
(판매가의 범위는 500,000~1,000,000원 사이로 내림차순으로 도출하시오. (원화표기 및 천단위구분))
(Alias 상품분류, 판매가, 변경판매가)
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
[2문제]

회원중 1975년생이고 대전 주소의 회원이 구매했던 모든상품 중에 
판매가가 판매가의 전체평균보다 높은 제품만 검색해보세요.
단  
1. 판매가를 기준으로 내림차순하고, 판매가는 천단위 구분표시
2. 상품중 삼성이 들어간 제품만 필터 
3. 상품색상중 NULL값은 '검정'으로 처리
4. 색깔별 갯수는 1이상일 것만 조회
*/

SELECT prod_name, 
          TO_CHAR(prod_sale, 'L999,999,999') AS prod_sale,
          NVL(prod_color, '검정'),
          COUNT(prod_color)
FROM prod
  WHERE prod_sale > (SELECT AVG(prod_sale) FROM prod)
      AND prod_id IN (SELECT cart_prod
                              FROM cart
                                WHERE cart_member IN (SELECT mem_id
                                                                  FROM member
                                                                    WHERE EXTRACT(YEAR FROM mem_bir) = 1975
                                                                        AND mem_add1 LIKE '대전%')) 
      AND prod_name LIKE '%삼성%'
  GROUP BY prod_name, prod_sale, prod_color
    HAVING COUNT(prod_color) >=1
ORDER BY prod_sale DESC;

---
/*
[3문제]

대전 지역에 거주하고 생일이 2월이고 구매일자가 4월 ~ 6월 사이인 회원 중 
구매수량이 전체회원의 평균 구매수량보다 높은 회원 조회 후 

"(mem_name) 회원님의 (Extract(month form mem_bir)) 월 생일을 진심으로 축하합니다. 
2마트 (mem_add 중 2글자) 점을 이용해 주셔서 감사합니다.
이번 2월 동안에는 VVIP회원으로 마일리지를 3배로 사용하실 수 있습니다.
앞으로도 많은 이용 바랍니다." 출력

(Alias 회원명, 성별, 주소, 이메일 주소, 생일 축하 문구)
*/

SELECT mem_name, 
          (CASE WHEN MOD(SUBSTR(mem_regno2, 1, 1), 2) = 1 THEN '남자'
                  WHEN MOD(SUBSTR(mem_regno2, 1, 1), 2) = 0 THEN '여자'
                  -- ELSE 
                  END) AS "sex",
          mem_add1,
          mem_mail,
          mem_name || ' 회원님의 ' || EXTRACT(MONTH FROM mem_bir) || '월 생일을 진심으로 축하합니다. 2마트 ' || SUBSTR(mem_add1,1,2) || '점을 이용해주셔서 감사합니다.' AS stn
FROM member
  WHERE mem_add1 LIKE '대전%'
      -- AND EXTRACT(MONTH FROM mem_bir) = 2 
      AND mem_id IN (SELECT cart_member
                              FROM cart
                                WHERE SUBSTR(cart_no,5,2) BETWEEN 4 AND 6
                                    AND cart_qty > (SELECT AVG(cart_qty)
                                                            FROM cart));

---------------------------------------
-- 5조
/* [문제]
1. 
'여성캐주얼'이면서 제품 이름에 '여름'이 들어가는 상품이고, 
매입수량이 30개 이상이면서 6월에 입고한 제품의
마일리지와 판매가를 합한 값을 조회하시오
Alias 상품이름,판매가격, 판매가격+마일리지
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
      AND prod_name LIKE '%여름%';

/* 2. 
거래처 코드가 'P20' 으로 시작하는 거래처가 공급하는 상품에서 
제품 등록일이 2005년 1월 31일(2월달) 이후에 이루어졌고 매입단가가 20만원이 넘는 상품을
구매한 고객의 마일리지가 2500이상이면 우수회원 아니면 일반회원으로 출력하라
컬럼 회원이름과 마일리지, 우수 또는 일반회원을 나타내는 컬럼
*/

SELECT mem_name,
          mem_mileage,
          (CASE WHEN mem_mileage >= 2500 THEN '우수회원'
                   ELSE '일반회원'
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
6월달 이전(5월달까지)에 입고된 상품 중에 
배달특기사항이 '세탁 주의'이면서 색상이 null값인 제품들 중에 
판매량이 제품 판매량의 평균보다 많이 팔린걸 구매한
김씨 성을 가진 손님의 이름과 보유 마일리지를 구하고 성별을 출력하시오
Alias 이름, 보유 마일리지, 성별
*/

SELECT mem_name,
          mem_mileage,
          (CASE WHEN MOD(SUBSTR(mem_regno2, 1, 1), 2) = 1 THEN '남자'
                    WHEN MOD(SUBSTR(mem_regno2, 1, 1), 2) = 0 THEN '여자'
                    END) AS "sex"
FROM member
  WHERE mem_name LIKE '김%'
      AND mem_id IN(SELECT cart_member
                            FROM cart
                              WHERE cart_prod IN (SELECT prod_id
                                                            FROM prod
                                                              WHERE prod_id IN (SELECT buy_prod
                                                                                          FROM buyprod
                                                                                            WHERE buy_date < '05/06/01')
                                                                  AND prod_delivery = '세탁 주의'
                                                                  AND prod_color is null)
                                  AND cart_qty >= (SELECT AVG(cart_qty)
                                                          FROM cart)) ;
-- 1조
/*
[문제 만들기]
????(안전재고수량별 빈도수가) 가장 높은 상품을 구매한 회원 중 
자영업 아닌 회원의 id와 name
*/

SELECT mem_id,
          mem_name
FROM member
  WHERE mem_id IN (SELECT cart_member
                              FROM cart
                                WHERE cart_prod IN (SELECT prod_id
                                                              FROM prod));

/* 2.
[문제 만들기]
취급상품코드가 'P1'이고 '인천'에 사는 구매 담당자의 상품을 구매한 
회원의 결혼기념일이 8월달이 아니면서 
평균마일리지(소수두째자리까지) 미만이면서 
구매일에 첫번째로 구매한 회원의 
회원ID, 회원이름, 회원마일리지를 검색하시오.  
 ************ 결과 값이 0명이거나 2명입니다 ******************/

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
                                                                                                      AND buyer_add1 LIKE '인천%' ))
                                    AND SUBSTR(cart_no, -2, 2) = 1)
      AND EXTRACT(MONTH FROM mem_bir) <> 8
      AND mem_mileage < (SELECT ROUND(AVG(mem_mileage),2) 
                                    FROM member) ;
--JOIN 이용
SELECT M.mem_id,
          M.mem_name,
          M.mem_mileage
FROM member M INNER JOIN cart C
                                    ON M.mem_id = C.cart_member
                          INNER JOIN prod P
                                    ON P.prod_id = C.cart_prod
                          INNER JOIN buyer B
                                    ON B.buyer_id = P.prod_buyer
  WHERE B.buyer_add1 LIKE '인천%'
      AND  SUBSTR(B.buyer_lgu,1,2) = 'P1'
      AND EXTRACT(MONTH FROM M.mem_bir) <> 8
      AND M.mem_mileage < (SELECT ROUND(AVG(M.mem_mileage),2) 
                                    FROM member)
      AND SUBSTR(cart_no, -2, 2) = 1;




/* 3.
[문제 만들기]
주소지가 대전인 거래처 담당자가 담당하는 상품을 
구매하지 않은 대전 여성 회원 중에 2월에 결혼기념일이 있는
회원 아이디, 회원 이름 조회 
이름 오름차순 정렬
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
                                                                                                  WHERE buyer_add1 LIKE '대전%')))
      AND mem_add1 LIKE '대전%'
      AND SUBSTR(mem_regno2,1,1) =2
      AND mem_memorial = '결혼기념일'
      AND EXTRACT(MONTH FROM mem_memorialday) = 12 ;

/* 4. 
[문제 만들기]
컴퓨터제품을 주관하며 수도권(서울,인천)에 살고 주소에 '마' 가 들어간 곳에 사는 담당자가 담당하는
제품 중에서 판매가격이 전체판매가격 이상인 상품을 구매한 회원들이 사는 곳(지역)을  분류하고
지역별 회원들이 생각하는 기념일별 가장 많은 기념일은 어떤것인지 알아내시오
--서울: 수도권
--충남, 대전 : 충청도 나머지는 경상도
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
                                                                                            Where buyer_add1 like '인천%'
                                                                                            AND buyer_lgu like 'P1%')))
AND mem_memorial = '결혼기념일'
AND extract(month from mem_memorialday) != '8'   
AND mem_mileage < (SELECT avg(mem_mileage) FROM member) 
GROUP BY mem_id, mem_name;
-------------------------------------------------
/* 3조
1. 오철희가 산 물건 중 TV 가 고장나서 교환받으려고 한다
교환받으려면 거래처 전화번호를 이용해야 한다.
구매처와 전화번호를 조회하시오.
*/

SELECT B.buyer_name,
          B.buyer_comtel
FROM buyer B INNER JOIN prod P
                              ON B.buyer_id = P.prod_buyer
                    INNER JOIN cart C
                              ON P.prod_id = C.cart_prod
                    INNER JOIN member M
                              ON M.mem_id = C.cart_member                              
  WHERE mem_name = '오철희' 
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
                                                                                                  WHERE mem_name = '오철희' ))
                                    AND prod_name LIKE '%TV%' );

/*
2. 대전에 사는 73년이후에 태어난 주부들 중
2005년 4월에 구매한 물품을 조회하고, 
그 상품을 거래하는 각 거래처의 계좌 은행명과 계좌번호를 뽑으시오.
(단, 은행명-계좌번호).*/

SELECT B.buyer_bankname,
          B.buyer_bankno
FROM buyer B INNER JOIN prod P
                                ON B.buyer_id = P.prod_buyer
                    INNER JOIN cart C
                                ON P.prod_id = C.cart_prod
                    INNER JOIN member M
                                ON M.mem_id = C.cart_member
  WHERE M.mem_add1 LIKE '대전%'
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
                                                                                                  WHERE mem_add1 LIKE '대전%'
                                                                                                      AND mem_bir >= '73/01/01')
                                                                  AND cart_no LIKE '200504%'));
/*3.
물건을 구매한 회원들 중
5개이상 구매한 회원과
4개이하로 구매한 회원에게
쿠폰을 할인율이 다른 쿠폰을 발행할 예정이다. 
???(회원들을 구매횟수에 따라  오름차순으로 정렬하고)
회원들의 회원id와 전화번호(HP)를 조회하라.
*/

SELECT mem_id, mem_hp
FROM member 
  WHERE mem_id IN (SELECT cart_member
                              FROM cart
                                WHERE cart_qty >= 5
                                    OR cart_qty <= 4);
----------------------------------------------------

/* 4조
<태영>
김성욱씨는 주문했던 제품의 배송이 지연되어 불만이다.
구매처에 문의한 결과, 제품 공급에 차질이 생겨 배송이 늦어진다는 답변을 받았다.
김성욱씨는 해당 제품의 공급 담당자에게 직접 전화하여 항의하고 싶다.
어떤 번호로 전화해야 하는가?
*/

SELECT buyer_charger, buyer_comtel
FROM buyer
  WHERE buyer_id IN (SELECT prod_buyer
                              FROM prod
                                WHERE prod_id IN (SELECT cart_prod
                                                            FROM cart
                                                              WHERE cart_member IN (SELECT mem_id
                                                                                                FROM member
                                                                                                  WHERE mem_name ='김성욱')));
/*
<태경>
서울 외 타지역에 살며
외환은행을 사용하는 거래처 담당자가
담당하는 상품을 구매한 회원들의 이름, 생일을 조회 하며 
이름이 '이'로 시작하는 회원명을 '리' 로 치환해서 출력해라 
*/

SELECT (DECODE(SUBSTR(mem_name, 1, 1) , 
                      '이', '리' || SUBSTR(mem_name,2,2),
                      mem_name)) AS name,
          mem_bir
FROM member
  WHERE mem_id IN (SELECT cart_member
                              FROM cart
                                WHERE cart_prod IN (SELECT prod_id
                                                              FROM prod
                                                                WHERE prod_buyer IN (SELECT buyer_id
                                                                                                FROM buyer
                                                                                                  WHERE buyer_add1 NOT LIKE '서울%'
                                                                                                  AND buyer_bank = '외환은행')));

/*
<덕현>
짝수 달에 구매된 상품들 중
세탁 주의가 필요 없는 상품들의 ID, 이름, 판매 마진을 출력하시오.
마진 출력 시 마진이 가
장 높은 값은 10퍼센트 인하된 값으로, 
가장 낮은 값은 10퍼센트 추가된 값으로 출력하시오.
정렬은 ID, 이름 순으로 정렬하시오.
(단, 마진은 소비자가 - 매입가로 계산한다.)*/

SELECT prod_id,
          prod_name,
          DECODE( (prod_price - prod_sale) ,
                         (SELECT MAX(prod_price - prod_sale)
                        FROM prod) , ( prod_price - prod_sale) * 0.9,
                         (SELECT MIN(prod_price - prod_sale)
                        FROM prod) , ( prod_price - prod_sale ) * 1.1,
                          prod_price - prod_sale) AS margin
FROM prod;