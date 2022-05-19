-- 선생님께서 공유해주신 sql 파일(base_table.sql, remain(재고수불).sql) 실행

/* 
lprod : 상품분류 정보
prdo : 상품 정보
buyer : 거래처 정보
member : 회원 정보
cart : 구매 정보
buyprod : 입고 상품 정보
remain : 재고 수불 정보
*/

--
SELECT mem_id, mem_name 
  FROM member ;
  
-- 상품 테이블로부터 상품코드와 상품명 검색
-- 1. 테이블 찾기 2. 조건이 있는지? 3. 어떤 컬럼을 사용하는지?
SELECT prod_id, prod_name
FROM prod ;

-- 회원 테이블의 마일리지를 12로 나눈 값을 검색
SELECT mem_mileage,
          (mem_mileage / 12) as mem_12
FROM member ;

/* 상품 테이블의 상품코드, 상품명, 판매금액을 검색한다.
판매금액은 = 판매단가*55 로 계산한다.
*/

SELECT prod_id,
          prod_name,
          (prod_sale*55) as prod_sale
      -- (prod_sale*55) "prod_sale"
      -- (prod_sale*55) prod_sale
FROM PROD ;

-- 가급적이면 컬럼명을 한글로 쓰지 않는다.

-- 상품 테이블의 거래처코드를 중복되지 않게 검색
-- Alias는 거래처

SELECT DISTINCT prod_buyer as 거래처
FROM PROD ;

-- 회원테이블에서 회원 ID, 회원명, 생일, 마일리지 검색
SELECT mem_id, mem_name, mem_bir, mem_mileage
FROM member
ORDER BY mem_id ASC;

--
SELECT mem_id AS id,
            mem_name AS nm,
            mem_bir, mem_mileage
FROM member
  ORDER BY id ASC;

--  컬럼 순번으로 정렬
SELECT mem_id AS id,
            mem_name AS nm,
            mem_bir, mem_mileage
FROM member
  ORDER BY 3 ASC;
  
-- 복수 컬럼으로 정렬
SELECT mem_id AS id,
            mem_name AS nm,
            mem_bir, mem_mileage
FROM member
  ORDER BY nm, 1 ASC;
  
-- 상품 중 판매가가 170,000원인 상품 조회
SELECT prod_name 상품, 
          prod_sale 판매가
  FROM prod 
  WHERE prod_sale = 170000 ;
  
  -- 상품 중 판매가가 170,000원이 아닌
  -- 상품 아이디와 상품명 조회
SELECT prod_id, prod_name
  FROM prod
    WHERE prod_sale != 170000 ;
    
/* 상품 판매가격이 170,000 원을 초과하는 
상품아이디와 상품명 조회 */

SELECT prod_id, prod_name
  FROM prod
    WHERE prod_sale > 170000 ;
    
/* 상품 중에 매입가격이 200,000원 이하인 상품 검색
단, 상품 코드를 기준으로 내림차순
조회 컬럼은 상품코드, 매입가격, 상품명 */

SELECT prod_id, prod_cost, prod_name
  FROM prod
    WHERE prod_cost <= 200000 
ORDER BY prod_id DESC ;
  
/* 회원 중에 76년도 1월 1일 이후에 태어난 
회원 아이디, 회원 이름, 주민등록번호 앞자리 조회
단, 회원아이디 기준 오름차순 */

SELECT mem_id, mem_name, mem_regno1
  FROM member
    WHERE mem_regno1 >= 760101
ORDER BY mem_id ASC ;

/* 상품 중 상품분류가 P201(여성 캐쥬얼)이고
판매가가 170,000원인 상품 조회 */

SELECT prod_name
  FROM prod
    WHERE prod_lgu = 'P201'
      AND prod_sale = 170000 ;

/* 상품 중 상품분류가 P201(여성 캐쥬얼) 이거나
판매가가 170000원인 상품 조회 */

SELECT prod_name
  FROM prod
    WHERE prod_lgu = 'P201'
      OR prod_sale = 170000 ;
      
/* 상품 중 판매가가 300,000원 이상 500,000원 이하인 상품을 검색
Alias는 상품코드, 상품명, 판매가 */

SELECT prod_id as 상품코드,
          prod_name as 상품명,
          prod_sale as 판매가
  FROM prod
    WHERE prod_sale >= 300000 
      AND prod_sale <= 500000 ;
      
/* 상품 중에 판매가격이 15만원, 17만원, 33만원인 상품정보 조회 
상품코드, 상품명, 판매가격을 출력
정렬은 상품명을 기준으로 오름차순 */

SELECT prod_id as 상품코드,
          prod_name as 상품명,
          prod_sale as 판매가
  FROM prod
    WHERE prod_sale = 150000 
      OR prod_sale = 170000
      OR prod_sale = 330000 
ORDER BY prod_name ASC ;
-- IN 명령어를 사용하기
SELECT prod_name 상품,
        prod_sale 판매가
        FROM prod
        WHERE prod_sale NOT IN (150000, 170000, 330000)
ORDER BY prod_name ASC ;

/* 회원 중에 아이디가 C001, F001, W001인 회원조회
회원아이디, 회원이름 출력
정렬은 주민호 앞자리를 기준으로 내림차순 */

SELECT mem_id, mem_name
  FROM member
    WHERE mem_id = 'c001'
      OR mem_id = 'f001'
      OR mem_id = 'w001'
ORDER BY mem_regno1 DESC ;

-- Base_table.sql 파일을 보면서 테이블 정의서, ERD 만들어 보기

-- 상품 분류테이블에서 현재 상품테이블에 존재하는 분류만 검색(분류코드, 분류명)
SELECT lprod_gu 분류코드,
      lprod_nm 분류명
      FROM lprod
      WHERE lprod_gu IN (SELECT prod_lgu FROM prod) ; 

-- 
SELECT mem_id, mem_name
  FROM member
  WHERE mem_id NOT IN (
          SELECT cart_member
            FROM cart) ;
            
/* 한번도 판매된 적이 없는 상품을 조회하려고 합니다.
판매된 적이 없는 상품이름을 조회해주세요-*/

SELECT prod_id, prod_name
  FROM prod
  WHERE prod_id NOT IN (
          SELECT cart_prod
            FROM cart) ;
            
/* 회원 중에 김은대 회원이 지금까지 구매했던
모든 상품명을 조회해 주세요. */

/* 
# 테이블 : prod, member, cart
# 조건 : mem_name = '김은대'
# 컬럼 : prod_name
*/

SELECT prod_name
  FROM prod
  WHERE prod_id IN (
          SELECT cart_prod
          FROM cart
          WHERE cart_member IN (
                  SELECT mem_id 
                  FROM member
                  WHERE mem_name = '김은대') 
                      );
 /* 
 상품 중 판매가격이 10만원 이상, 30만원 이하인 상품을 조회
 조회 컬럼은 상품명, 판매가격입니다.
 정렬은 판매가격을 기준으로 내림차순 한다. 
 */
 
 SELECT prod_name, prod_sale
  FROM prod 
  WHERE prod_sale >= 100000 
    AND prod_sale <= 300000
ORDER BY prod_sale DESC ;

-- BETWEEN : 이상, 이하 비교연산자
-- NOT BETWEEN

 SELECT prod_name, prod_sale
  FROM prod 
  WHERE prod_sale BETWEEN 100000 
    AND 300000
ORDER BY prod_sale DESC ;

/* [날짜 형식]
회원 중 생일 1975-01-01 에서 1976-12-31 사이에 태어난
회원을 검색한다.
(Alias는 회원ID, 회원 명, 생일) 
*/

SELECT mem_id AS 회원ID,
        mem_name AS 회원명,
        mem_bir AS 생일
    FROM member
    WHERE mem_bir
      BETWEEN '1975-01-01' AND '1976-12-31'
      --BETWEEN '75/01/01' AND '76/12/31'
ORDER BY mem_regno1 DESC
      ;
      
/*
거래 담당자 강남구씨가 담당하는 상품을 
구매한 회원을 조회한다.
회원 아이디, 회원 이름을 조회. 

# 테이블 : member, cart, prod, (lprod), buyer
# 조건 : buyer_charger = '강남구'
# 컬럼 : mem_id, mem_name
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
                WHERE buyer_charger = '강남구'))) ;

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
                    WHERE buyer_charger = '강남구' )))
    )
    ;

/* 
상품 중 매입가가 300,000~1,500,000이고
판매가가 800,000~2,000,000 인 상품을 검색한다.
Alias는 상품명, 매입가, 판매가
*/

SELECT prod_name AS 상품명,
          prod_cost AS 매입가,
          prod_sale AS 판매가
FROM prod 
    WHERE prod_cost BETWEEN 300000 AND 1500000
    AND prod_sale BETWEEN 800000 AND 2000000
ORDER BY 판매가 ASC ;

/*
회원 중 생일이 1975년도 생이 아닌 회원을 검색한다.
Alias 는 회원ID, 회원 명, 생일
*/

SELECT mem_id AS 회원ID,
        mem_name AS 회원명,
        mem_bir AS 생일
FROM member
    WHERE mem_bir NOT BETWEEN '75/01/01' AND '75/12/31'
ORDER BY mem_bir ASC 
;

-- LIKE 

-- 회원 테이블에서 김씨 성을 가진 회원을 검색한다.
-- Alias 는 회원ID, 성명

SELECT mem_id AS 회원ID,
    mem_name AS 성명
    FROM member
    WHERE mem_name LIKE '김%' ;
    
/* 회원테이블의 주민등록번호 앞자리를 검색하여
1975년생을 제외한 회원을 검색한다.
Alias 회원ID, 성명, 주민등록번호 */

-- || : 문자열을 연결하는 결합 연산자
SELECT mem_id AS 회원ID,
        mem_name AS 성명,
        mem_regno1 || '-' || mem_regno2 AS 주민등록번호
        FROM member 
        WHERE mem_regno1 NOT LIKE '75%'
        ;
        
-- CONCAT : 두 문자열을 연결하여 반환

SELECT CONCAT('My Name is ', mem_name) FROM member ;

-- 
SELECT CHR(65) "CHR" , ASCII('A') "ASCII"
    FROM dual ;
    
-- LOWER, UPPER, INITCAP

SELECT lower('DATA maniqulation Language') "LOWER" ,
    UPPER('DATA maniqulation Language') "UPPER" ,
    INITCAP('DATA maniqulation Language') "INITCAP"
    FROM dual ;
    
# 회원테이블의 회원 ID를 대문자로 변환하여 검색한다.

SELECT UPPER(mem_id)
    FROM member ;


-- LPAD, RPAD

-- LTRIM, RTRIM : 공백제거

-- SUBSTR : 문자열 자르는 함수

-- TRANSLATE 

-- REPLACE
    
/* 회원테이블의 회원성명 중 성씨 '이' --> '리'로 치환하여
뒤에 이름을 붙인 후 검색한다.
Alias는 회원명, 회원명치환 */

SELECT CONCAT(SUBSTR(REPLACE(mem_name, '이', '리') , 1, 1) ,
    SUBSTR(mem_name, 2)) AS 회원명
FROM member ;

-- INSTR

-- GREATEST, LEAST

-- ROUND

-- TRUNC

-- MOD : 나눈 나머지 값

-- SYSDATE

SELECT SYSDATE -1
FROM dual ; 

-- ADD_MONTHS 

SELECT ADD_MONTHS(SYSDATE, 5) FROM dual ;

-- NEXT_DAY, LAST_DAY
Select NEXT_Day(Sysdate, '월요일'), 
        Last_day(Sysdate)
        FROM dual ;
        
-- 이번 달이 며칠이 남았는지 검색

SELECT LAST_DAY(SYSDATE) - SYSDATE
    FROM dual ;
    
-- EXTRACT : 날짜에서 필요한 부분만 추출

SELECT EXTRACT(YEAR FROM SYSDATE) "년도",
    EXTRACT(MONTH FROM SYSDATE) "월",
    EXTRACT(DAY FROM SYSDATE) "요일"
    FROM dual ; 
    
-- 생일 3월인 회원을 검색

SELECT mem_name, mem_bir, 
    EXTRACT(MONTH FROM mem_bir) AS 태어난월
    FROM member 
      WHERE EXTRACT(MONTH FROM mem_bir) = 3
ORDER BY mem_bir ASC ;

/*
회원 생일 중 1973년생이 주로 구매한 상품을 오름차순으로 조회
- 조회 컬럼 : 상품명
- 단, 상품명에 삼성이 포함된 상품만 조회,
    그리고 조회결과 중복 제거

*/

SELECT DISTINCT(prod_name)
  FROM prod
  WHERE prod_name LIKE '%삼성%'
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

-- CAST() : 명시적으로 형 변환

-- (**매우 중요**) TO_CHAR : 숫자, 문자, 날짜 형식을 문자열로 변환
-- TO_NUMBER : 숫자형식의 문자열을 숫자로 반환
-- TO_DATE : 날짜형식의 문자열을 날짜로 반환

-- TO_CHAR가 자주 쓰이는 형태
SELECT 
    TO_CHAR(CAST('2008-12-25' AS DATE),
        'YYYY.MM.DD HH24:MI')
        FROM dual ;
        
/*
상품테이블에서 상품입고일을 '2008-09-28'형식으로 나오게 검색
Alias 상품명, 상품판매가, 입고일 */

SELECT prod_name AS 상품명,
    prod_sale AS 상품판매가,
    TO_CHAR(CAST(prod_insdate AS DATE),
        'YYYY-MM-DD DAY') AS 입고일
    FROM prod
ORDER BY 입고일 ASC ;

/*
회원이름과 생일로 다음처럼 출력
'김은대님은 1976년 1월 출생이고 태어난 요일은 목요일'
*/

SELECT 
    mem_name || '님은 ' ||
    TO_CHAR(
        CAST(mem_bir AS DATE),
            'YYYY') || '년 ' ||
    TO_CHAR(
        CAST(mem_bir AS DATE),
            'MM') || '월 출생이고 태어난 요일은 ' ||
    TO_CHAR(
        CAST(mem_bir AS DATE),
            'DAY') AS 생일        
    FROM member ;

-- 9는 제시된 숫자에 실재하는 숫자에 대응.
-- 0은 제시된 숫자에 실재하지 않는 숫자에 대응.
SELECT TO_CHAR(1234.6, '99,999.00')
  FROM dual ;
  
-- L : 지역 화폐 기호, 
-- PR : 음수를 <> 괄호 표현
SELECT TO_CHAR(-1234.6, 'L9999.00PR')
  FROM dual ;

/* 
상품테이블에서 상품코드, 상품명, 매입가격, 소비자가격, 판매가격을 출력
단, 가격은 천단위 구분 및 원화표시
*/

SELECT prod_id AS 상품코드,
    prod_name AS 상품명,
    TO_CHAR(prod_cost, 'L999,999,999') AS 매입가격,
    TO_CHAR(prod_price, 'L999,999,999') AS 소비자가격,
    TO_CHAR(prod_sale, 'L999,999,999') AS 판매가격
    FROM prod ;
    
/*  회원테이블에서 이쁜이 회원의
회원 ID 2~4 문자열을 숫자형으로 치환한 후
10을 더하여 새로운 회원 ID로 조합한다.
*/

SELECT CONCAT(SUBSTR(mem_id, 1,2) , SUBSTR(mem_id, 3, 4) + 10)
    FROM member
    WHERE mem_name = '이쁜이'
    ;

/*
AVG : 평균
[규칙]
일반컬럼과 그룹함수(AVG, MAX, MIN, SUM, COUNT 같은)를 같이 사용할 경우에는
꼭 Group By 절을 넣어 주어야 한다.
Group by 절에는 일반컬럼이 모두 들어가야 한다.
*/

SELECT prod_lgu,
          ROUND(AVG(prod_cost), 2) "분류별 매입가격 평균"
    FROM prod
GROUP BY prod_lgu ;

-- 상품테이블의 판매가격 평균 값을 구한다.
-- Alias는 상품 판매 가격 평균

SELECT ROUND(AVG(prod_sale ), 2) "상품 판매 가격 평균"
    FROM prod ;

-- 상품테이블의 상품분류별 판매가격 평균 값을 구한다.
SELECT prod_lgu, AVG(prod_sale) as avg_sale
FROM prod
GROUP by prod_lgu;

-- COUNT()

/* 장바구니 테이블의 회원별 COUNT 집계
Alias는 회원 ID, 자료수(DISTINCT), 자료수, 자료수(*)
*/

SELECT cart_member AS "회원 ID",
            COUNT(cart_member) 자료수        
    FROM cart 
GROUP BY cart_member;

/* 구매수량의 전체평균 이상을 구매한 회원들의
아이디와 이름을 조회
단, 정렬은 주민번호(앞)를 기준으로 오름차순*/

SELECT mem_id,
            mem_name
    FROM member
        WHERE mem_id in(
            SELECT cart_member
            FROM cart
                WHERE cart_qty >= 
                    (SELECT AVG(cart_qty)  -- hint. AVG() 함수는 단독으로 사용할 수 없다.
                    FROM cart))
ORDER BY mem_regno1 ASC ;

-- COUNT(*) : 행의 개수를 센다.
-- COUNT() 는 Null 값은 제외하고 세기 때문에 다르다.

/* 
구매내역(장바구니) 정보에서 회원아이디별로 주문(수량)에 대한
평균을 조회
회원 아이디를 기준으로 내림차순
*/

SELECT cart_member AS 회원 , ROUND(AVG(cart_qty), 1) AS avg_qty
    FROM cart
    Group BY cart_member
ORDER BY cart_member DESC;

/* [문제]
상품정보에서 판매가격의 평균 값을 구한다.
단, 평균값은 소수점 2째 자리까지 표현한다.
*/

SELECT ROUND(AVG(prod_sale), 2) AS avg_sale
    FROM prod ;
    
/* [문제]
상품정보에서 상품분류별 판매가격의 평균값을 구한다.
조회 컬럼은 상품분류코드, 상품분류별 판매가격의 평균
단, 평균값은 소수점 2 번째 자리까지 표현
*/

SELECT prod_lgu, ROUND(AVG(prod_sale), 2) AS avg_sale
  FROM prod
  GROUP BY prod_lgu
ORDER BY prod_lgu, avg_sale  ;

-- 회원테이블의 취미종류수를 COUNT 집계
-- Alias 취미종류수

SELECT count(mem_like) 취미종류수
  FROM member ;
  
/* 회원테이블의 취미별 COUNT 집계
(Alias는 취미, 자료수, 자료수(*) ) */

SELECT mem_like AS "취미", 
          count(mem_like) AS 자료수,
          count(*) AS "자료수(*)"
  FROM member
  GROUP BY mem_like ;
  
/* 회원테이블의 직업종류수를 COUNT집계
(Alias는 직업종류수) */

SELECT COUNT(DISTINCT(mem_job)) AS 직업종류수
  FROM member ;
  
/* [문제]
회원 전체의 마일리지 평균보다 큰 회원에 대한
아이디, 이름, 마일리지를 조회
마일리지가 높은 순으로 정렬
*/

SELECT mem_id, mem_name, mem_mileage
FROM member
    WHERE mem_mileage >= (SELECT AVG(mem_mileage) FROM member)
ORDER BY mem_mileage DESC ;

/* [문제]
오늘이 2005년도 7월 11일이라 가정하고 
장바구니 테이블에 발생될 추가주문번호 검색
Alias 는 현재년월일 기준 가장 높은 주문번호, 추가주문번호
*/

SELECT MAX(cart_no), max(cart_no) +1
FROM cart
  WHERE cart_no LIKE '20050711%' ;
  
/* [문제]
구매정보에서 년도별로 판매된 상품의 갯수,
평균구매수량을 조회
년도 기준 내림차순 정렬
*/

SELECT SUBSTR(cart_no, 1, 4) AS yyyy,
          SUM(cart_qty) AS sum_qty,
          AVG(cart_qty) AS avg_qty
FROM cart
  GROUP BY SUBSTR(cart_no, 1, 4)
ORDER BY yyyy DESC;

/* [문제]
구매정보에서 년도별, 상품분류코드별로 상품의 갯수를 조회
년도를 기준으로 내림차순 정렬 
*/

SELECT SUBSTR(cart_no, 1, 4) AS yyyy,
          SUBSTR(cart_prod, 1, 4) AS lgu,
          COUNT(cart_prod)
FROM cart
  GROUP BY SUBSTR(cart_no, 1, 4), 
                  SUBSTR(cart_prod, 1, 4)
ORDER BY yyyy DESC
;

/* [문제]
회원테이블의 회원전체의 
마일리지 평균, 마일리지 합계, 최고 마일리지, 최소 마일리지, 인원수 검색
Alias 위에 제시된 대로
*/

SELECT AVG(mem_mileage) AS 마일리지평균,
          SUM(mem_mileage) AS 마일리지합계, 
          MAX(mem_mileage) AS 최고마일리지,
          MIN(mem_mileage) AS 최소마일리지,
          COUNT(*) AS 인원수
FROM member
;

/* [문제]
상품테이블에서 상품분류별 판매가 전체의
평균,합계,최고값, 최저값, 자료수를 검색
Alias 는 위에 제시된 대로
단, 자료수가 20개 이상인 것
*/

SELECT prod_lgu,
          TO_CHAR(ROUND(AVG(prod_sale), 2), 'L999,999,999')  평균,
          TO_CHAR(SUM(prod_sale), 'L999,999,999') 합계,
          TO_CHAR(MAX(prod_sale), 'L999,999,999') 최고값,
          TO_CHAR(MIN(prod_sale), 'L999,999,999') 최저값,
          COUNT(prod_sale) 자료수
FROM prod
  GROUP BY prod_lgu
    HAVING COUNT(prod_sale) >= 20
;

-- WHERE 절 : 일반조건으로만 사용
-- HAVING 절 : 그룹조건으로만 사용

/* [문제]
회원테이블에서
지역(주소1의 처음 2자리) , 생일년도별로 
마일리지 평균, 마일리지 합계, 최고 마일리지, 최소 마일리지, 자료수 검색
Alias 적절히 영어 단축어로 
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

--거래처 담당자 성씨가 '김'이면 NULL 갱신(commit X)

UPDATE buyer SET buyer_charger = NULL
  WHERE buyer_charger LIKE '김%' ;
  
SELECT buyer_name 거래처, buyer_charger 담당자
FROM buyer
  WHERE buyer_charger LIKE '김%' ;
  
-- 거래처 담당자 성씨가 '성'이면 Whiter Space로 갱신(commit X)
UPDATE buyer SET buyer_charger =''
  WHERE buyer_charger LIKE '성%' ;
  
SELECT buyer_name 거래처, buyer_charger 담당자
FROM buyer
  WHERE buyer_charger LIKE '성%' ;
  
--
SELECT buyer_name 거래처, buyer_charger 담당자
FROM buyer
  WHERE buyer_charger = NULL ;

--
SELECT buyer_name 거래처, buyer_charger 담당자
FROM buyer
  WHERE buyer_charger IS NOT NULL ;
  
-- 
SELECT buyer_name 거래처, buyer_charger 담당자
FROM buyer ;

SELECT buyer_name 거래처, 
          NVL(buyer_charger, '-') 담당자
FROM buyer;

-- NVL( , )
/* 회원 마일리지에 100을 더한 수치를 검색
 성명, 마일리지, 변경 마일리지
*/
SELECT mem_name,
            mem_mileage,
            (NVL(mem_mileage, 0) + 100)
FROM member
;

-- NVL2( , , )

/*[문제]
회원 마일리지가 있으면 '정상 회원' 
NULL이면 '비정상 회원'으로 검색
성명, 마일리지, 회원상태 조회
*/

SELECT mem_name, 
            mem_mileage, 
            NVL2(mem_mileage, '정상 회원', '비정상 회원') AS stat_mem
FROM member;

--[중요] DECODE ( , ... , ) : if 문과 같다

SELECT DECODE ( SUBSTR(prod_lgu, 1, 2) ,
                        'P1', '컴퓨터/전자 제춤', -- 한 쌍씩
                        'P2', '의류',
                        'P3', '잡화', 
                        '기타' ) -- 조건에 포함되지 않을 때 출력되는 값
FROM prod ;

/*[문제]
상품 분류 중 앞의 두 글자가 'P1'이면 판매가를 10% 인상하고,
'P2' 이면 판매가를 15%인상하고, 나머지는 동일 판매가로 검색
(DECODE 함수 이용, Alias 는 적절히)
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

/* [문제]
회원정보테이블의 주민등록 뒷자리에서 
성별 구분 검색
(CASE 구문 사용, Alias 회원명, 주민등록번호, 성별)
*/

SELECT mem_name AS "성 함" ,
          (mem_regno1 || '-' || mem_regno2) AS "regno",
          (CASE WHEN MOD(SUBSTR(mem_regno2, 1, 1), 2) = 1 THEN '남자'
                  WHEN MOD(SUBSTR(mem_regno2, 1, 1), 2) = 0 THEN '여자'
                  -- ELSE 
                  END) AS "sex"
FROM member
;

/* [문제]
회원정보 중에 구매내역이 있는 회원에 대한
회원아이디, 회원이름, 생일(0000-00-00 형태)을 조회
생일을 기준으로 오름차순 정렬
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
IN 함수하고 기능은 거의 비슷하지만, 
IN은 조회되는 데이터가 많아서 조회시간이 길어진다.
그래서 IN은 권장되지 않는다.*/

SELECT prod_id, prod_name, prod_lgu
FROM prod
  WHERE prod_lgu IN (SELECT lprod_gu
                                FROM lprod
                                  WHERE lprod_nm = '피혁잡화') ;
                                  
SELECT prod_id, prod_name, prod_lgu
FROM prod
  WHERE EXISTS (SELECT lprod_gu
                        FROM lprod
                          WHERE lprod_gu = prod.prod_lgu
                                    AND lprod_gu = 'P301') ;

/* 
# SELECT * FROM lprod, prod : Cartesian Product / Cross Join 
  * 모든 데이터를 조합한다.
  * 경우의수가 매우 많아지는 상태를 초래하기 때문에 실무에서는 거의 쓰는 일이 없다.
*/

SELECT COUNT(*)
FROM lprod, prod, buyer;

-- CROSS JOIN
-- 테이블에 별칭을 붙일 때는 'AS'를 쓰지 않는다.

--일반 방식
SELECT m.mem_id, c.cart_member, p.prod_id
FROM member m, cart c, prod p, lprod lp, buyer b;

--[국제표준방식(ANSI)] : 다른 DBMS 에서도 동일하게 사용

SELECT *
FROM member Cross Join cart 
                      Cross Join prod
                      Cross Join lprod
                      Cross Join buyer;
                      
/*
[Equi Join (Simple Join 혹은 Inner Join) ]
# 관계조건(PK, FK의 관계)식(조건식)이 필요하다
# Column명에는 Table명을 붙여야 한다.
# FROM으로 불러드리는 테이블 n개의 -1개만큼 WHERE 절에 조건식이 최소한 필요하다.
*/

--(일반방식) 상품테이블에서 상품코드, 상품명, 분류명을 조회
SELECT prod.prod_id "상품코드",
          prod.prod_name "상품명",
          lprod.lprod_nm "분류명"
FROM prod, lprod
-- 관계조건식을 제일 먼저 작성
  WHERE prod.prod_lgu = lprod.lprod_gu;
  
--(ANSI 국제표준방식) 
SELECT prod.prod_id "상품코드",
          prod.prod_name "상품명",
          lprod.lprod_nm "분류명"
FROM prod INNER JOIN lprod
                ON (prod.prod_lgu = lprod.lprod_gu);

--일반방식
SELECT A.prod_id "상품코드",
          A.prod_name "상품명",
          B.lprod_nm "분류명",
          C.buyer_name "거래처명"
FROM prod A, lprod B, buyer C
  WHERE A.prod_lgu = B.lprod_gu
            AND A.prod_buyer = C.buyer_id;
            
-- ANSI
SELECT A.prod_id "상품코드",
          A.prod_name "상품명",
          B.lprod_nm "분류명",
          C.buyer_name "거래처명"
FROM prod A INNER JOIN lprod B
                      ON (A.prod_lgu = B.lprod_gu)
                   INNER JOIN buyer C
                      ON (A.prod_buyer = C.buyer_id);

/*[문제]
회원이 구매한 거래처 정보를 조회
회원아이디, 회원이름, 상품거래처명, 상품분류명을 조회
*/

/* [풀이]
# 사용할 테이블 : member, cart, prod, buyer, lprod
# 조회할 컬럼 : mem_id, mem_name, buyer_name, lprod_nm
# 관계조건 : 
  * mem_id = cart_member
  * cart_prod = prod_id
  * prod_buyer = buyer_id 
  * prod_lgu = lprod_gu
# 일반방식 : 없음
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
            
--ANSI 방식            
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

/* [문제]
거래처가 '삼성전자'인 자료에 대한
상품코드, 상품명, 거래처명을 조회
*/

/*[풀이]
# 테이블 : prod, buyer
# 조회컬럼 : prod_id, prod_name, buyer_name
# 관계조건 : prod_buyer = buyer_id
# 일반조건 : buyer_name = '삼성전자'
*/

SELECT P.prod_id,
          P.prod_name,
          B.buyer_name
FROM prod P, buyer B
  WHERE B.buyer_id = P.prod_buyer
      AND B.buyer_name = '삼성전자';

--

SELECT P.prod_id,
          P.prod_name,
          B.buyer_name
FROM prod P INNER JOIN buyer B
                              ON (B.buyer_id = P.prod_buyer)
  WHERE B.buyer_name = '삼성전자' ;

--  

SELECT P.prod_id,
          P.prod_name,
          B.buyer_name
FROM prod P INNER JOIN buyer B
                              ON (B.buyer_id = P.prod_buyer
                                    AND B.buyer_name = '삼성전자');
                                    
/* [문제]
상품테이블에서 상품코드, 상품명, 분류명, 거래처명, 거래처주소 조회
1) 판매가격이 10만원 이하이고
2) 거래처 주소가 부산인 경우만 조회
*/

/*[풀이]
# 테이블 : prod, lprod, buyer
# 조회컬럼 : prod_id, prod_name, lprod_nm, buyer_name
# 관계조건 : prod_lgu = lprod_gu,
                prod_buyer = buyer_id
# 일반조건 : prod_sale <= 100000,
                buyer_add1 LIKE '%부산%'
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
      AND B.buyer_add1 LIKE '%부산%' ;

SELECT P.prod_id,
          P.prod_name,
          L.lprod_nm,
          B.buyer_name,
          B.buyer_add1
FROM prod P, lprod L, buyer B
  WHERE L.lprod_gu = P.prod_lgu
      AND P.prod_buyer = B.buyer_id
      AND P.prod_sale <= 100000
      AND SUBSTR(B.buyer_add1,1,2) = '부산';

/* [문제]
상품분류코드가 P101 인 것에 대한
상품분류명, 상품아이디, 판매가, 거래처담당자, 회원아이디, 주문수량 조회
단, 상품분류명을 기준으로 내림차순, 상품아이디를 기준으로 오름차순
일반/표준 방식 모두 표현
*/

/* [풀이]
# 테이블 : lprod, prod, buyer, cart
# 조회컬럼 : lprod_nm, prod_id, prod_sale, buyer_charger, cart_member, cart_qty
# 관계조건 : 
  * lprod_gu = prod_lgu
  * buyer_id = prod_buyer
  * prod_id = cart_prod
# 일반조건 :
  * lprod_gu = 'P101'
# 정렬 : 
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
/* 문제
상품분류명, 상품명, 상품색상, 매입수량, 주문수량, 거래처명을 조회
단, 상품분류 코드가 'P101', 'P201', 'P301' 인 것들에 대해 조회하고 
매입수량이 15개 이상인 것들과, 
'서울'에 살고 있는 회원 중에 생일 1974년 생인 사람들에 대해 조회
정렬은 회원아이디를 기준으로 내림차순, 매입수량을 기준으로 내림차순
*Join은 일반/표준방식 모두 작성
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
      AND M.mem_add1 LIKE '서울%'
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
      AND M.mem_add1 LIKE '서울%'
      AND EXTRACT(YEAR FROM M.mem_bir) = 1974
ORDER BY M.mem_id DESC, Bp.buy_qty DESC;

/* OUTER JOIN
# INNER JOIN의 경우 조건식을 만족하지 않는 데이터는 누락된다.
# 이런 누락된 데이터도 필요할 때 OUTER JOIN을 사용
# 일반방식 : (+) 연산자 기호가 붙어있는 쪽에서 NULL 이 있더라도 출력
  * FK 쪽에 (+) 가 붙는다.
    - PK 쪽에 (+)가 붙일 수는 있지만, 결과에 변화를 주지 않기 때문에 OUTER JOIN의 의미가 없다.
      + PK 테이블은  FK 테이블 컬럼을 모두 가지고 있기 때문
# 주로 LEFT OUTER JOIN 을 사용하지만 기준을 오른쪽에 두고 싶다면 RIGHT OUTER JOIN을 쓴다.

/* 전체 분류의 상품자료 수를 검색
(분류코드, 분류명, 상품자료수) */

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

/* [문제]
전체상품의 2005년 1월 입고수량을 검색. null 값 제거
(상품코드, 상품명, 입고수량 조회) */

/* 일반 방식에서 WHERE 절이 들어가면 OUTER JOIN 이 깨져버려서
OUTER JOIN을 사용할 때는 WHERE 절을 사용하지 않는다. */

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

/* 전체 회원의 2005년도 4월의 구매현황 조회
(회원 ID, 성명, 구매수량의 합) */

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
  
/* 2005년도 월별 판매 현황 검색
(판매월, 판매수량, 판매금액(판매수량*상품테이블의 판매가))
*/

SELECT SUBSTR(cart_no, 5,2) AS mm,
          SUM(cart_qty),
          TO_CHAR(SUM(cart_qty * prod_sale), 'L999,999,999') AS sum_sale
FROM cart , prod
  WHERE cart_prod = prod_id
      AND cart_no LIKE '2005%'
  GROUP BY SUBSTR(cart_no, 5,2)
ORDER BY mm;

-- GROUP 함수를 사용한 경우에 추가 조건이 있다면

/* 상품분류가 컴퓨터제품('P101')인 상품의 2005년도 일자별 판매 조회
(판매일, 판매금액(5,000,000 초과의 경우만), 판매수량 조회)
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
  
  
/* [서브쿼리] 
# SQL 구문 안에 또다른 SELECT 구문이 있는 것.
# 가능하면 JOIN을 사용하고 JOIN 이 안될 때 사용
# ANY = 여러 값들 중 1개라도 참일 때
# ALL = 여러 값들 중 모두 참일 때
-
SELECT (1개 컬럼, 1개 행)
FROM (다중 컬럼, 다중 행)
  WHERE >= (1개 컬럼, 1개 행)
        IN (1개, 다중 행)
    EXIST (다중 컬럼, 다중 행
*/

