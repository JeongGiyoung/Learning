-- 문자열 함수

-- UPPER : 대문자

SELECT * FROM emp
 WHERE job = UPPER('analyst');
 
 SELECT UPPER('analyst') FROM dual;

-- LOWER : 소문자

SELECT LOWER(ename) ename,
        INITCAP(job) job
    FROM emp
  WHERE comm IS NOT NULL;
  
-- LENGTH 단어 음절

--- LENGTHB 단어 바이트 수

  SELECT ename, 
    LENGTH(ename) 글자수
  , LENGTHB(ename) 바이트수
    
    FROM emp;
    
-- SUBSTRING 

--- 출력될 글자를 자르는 기능 ( '출력될 글자', 시작되는 곳, 몇 글자로 자를지)

SELECT SUBSTR('안녕하세요, 한가람IT전문학원 빅데이터반입니다.', 18, 4) phase FROM dual;

-- REPLACE 

--- 글자 대체

SELECT REPLACE('안녕하세요, 한가람IT전문학원 빅데이터반입니다.', '안녕하세요', '저리가세요') phase 
  FROM dual;
  
-- || , CONCATATION 

--- 두 문자열 합치기

SELECT 'A' || 'B' FROM dual;
SELECT CONCAT('A', 'B') FROM dual;

-- TRIM, LTRIM, RTRIM

--- 문자열 여백 없애기

SELECT '     안녕하세요.     ' FROM dual;
SELECT LTRIM('    안녕하세요.     ') FROM dual;
SELECT RTRIM('     안녕하세요.     ') FROM dual;
SELECT TRIM('     안녕 하세요.     ') FROM dual;

-- ROUND

--- 소수점 반올림 (숫자, 몇 자리까지 반올림 할건지 적기)

SELECT ROUND(15.193, 1) FROM dual;

-- SYSDATE : 오늘 날짜 출력

SELECT SYSDATE FROM dual;

-- TO_CHAR : 문자열로 만들기

SELECT ename, hiredate, TO_CHAR(hiredate, 'yyyy-mm-dd'), 
  TO_CHAR(sal) || '$'
    FROM emp;
    
-- TO_NUMBER : 숫자열로 만들기

SELECT TO_NUMBER(REPLACE('2400$', '$', '')) + 100 FROM dual;
SELECT TO_NUMBER('이천사백') FROM dual;

-- TO_DATE : 날짜 양식으로 바꾸기

SELECT TO_DATE('2022-01-12') FROM dual;
SELECT TO_DATE('01/12/22') FROM dual;
SELECT TO_DATE('01/12/22', 'mm/dd/yy') FROM dual;

-- NVL : Null 값 일괄변경

--- (바꾸고 싶은 테이블 이름, 대체할 값)

SELECT ename, job, sal, NVL(comm,0) comm,
      (sal*12) + NVL(comm,0) AS annsal
  FROM emp
  ORDER BY annsal DESC;
  
-- 집계함수 

-- SUM, COUNT, MIN, MAX, AVG(평균)

SElECT sal, NVL(comm, 0) comm FROM emp;

SElECT SUM(SAL) totalsalary FROM emp;
SElECT SUM(NVL(comm, 0)) totalcommision FROM emp;
SElECT SUM(comm) totalcommision FROM emp;

SELECT MAX(sal) FROM emp;

SELECT MIN(SAL) FROM emp;

SELECT AVG(sal) FROM emp;
SELECT ROUND(AVG(sal),0) sal_avg FROM emp;

-- Group by : 특정 테이블을 기준으로 그룹 묶기

SELECT MAX(sal) 월급최대, SUM(sal) 직업군당급여합계, job
  FROM emp
  GROUP by job;

-- HAVING : GROUP BY 명령문의 WHERE(조건)절

SELECT MAX(sal) 월급최대, SUM(sal) 직업군당급여합계, job
  FROM emp
  GROUP by job
  HAVING MAX(sal) > 4000;

--
SELECT deptno, job, AVG(sal) 직군별급여평균, MAX(sal), MIN(sal), SUM(sal), Count(*)
  FROM emp
  GROUP BY deptno, job
  HAVING AVG(sal) >= 1000
  ORDER BY deptno, job;
  
-- ROLLUP : 그룹으로 묶은 값의 전체 묶음 값

SELECT deptno, NVL(job, '합계') JOB, 
        ROUND(AVG(sal),2) 급여평균, MAX(sal) 급여최대,
        SUM(sal) 급여합계, Count(*) 그룹별직원수
  FROM emp
  GROUP BY ROLLUP(deptno, job);
  
