-- 조건절(WHERE)

SELECT * FROM emp
WHERE sal = 5000;

SELECT * FROM emp
WHERE job = 'CLERK';

SELECT * FROM emp
WHERE comm = 0 OR comm IS NULL;

-- WHERE 절에서 AND 사용방법

--- 보너스가 NULL이고 직업이 ANALYST인 사람만 셀렉션

SELECT * FROM emp
WHERE comm IS NULL AND job = 'ANALYST';

-- SLECT 프로젝션 : 출력할 결과물 중 표시하고 싶은 열을 정하고 싶을 때

SELECT empno, ename, deptno
FROM emp
WHERE deptno = 30;

-- 조인(JOIN) : 두 개 이상의 테이블을 하나의 테이블처럼 조회하는 방법

--- ON : JOIN 절에서 어떤 조건으로 테이블을 붙일 건지 정하는 명령문

SELECT e.empno, e.ename, e.job, e.hiredate, e.sal, d.deptno, d.dname
 FROM emp e
 JOIN dept d
  ON e.deptno = d.deptno;

-- DISTICT : 특정 열을 중복없이 출력하고 싶을 때

SELECT DISTINCT job FROM emp;

--별칭(ALIAS) : 열을 출력할 때 내가 원하는 열 이름으로 출력하고 싶을 때

--- AS 혹은 한 칸 띄우고 원하는 이름

--- ORDER BY ASC, DESC 오름차순, 내림차순

SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
  ORDER BY sal DESC; --ASC 오름차순 / DESC 내림차순
  
-- WHERE 

SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
  WHERE sal*12 >= 10000;
 
 -- 조건에서 '같지 않다'를 표현하는 방법  

-- <>  
-- !=  
-- ^=
 
SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
  WHERE sal ^= 1000; -- <>, != 많이 쓰임 ^= 거의 안쓰임

 -- WHERE NOT
 
 --- 조건에서 '아니다'를 표현하는 방법
 
SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
  WHERE NOT sal = 1000;
  
  -- IN : WHERE 절에서 여러 개 조건을 AND 명령문을 생략하면서 출력하고 싶을 때
  
  
SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
  WHERE sal IN (800, 1600, 5000); 

-- 만약 OR 절을 사용하면서 위에 출력을 표현하려면

SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
  WHERE sal = 800 OR sal=1600 OR sal=5000;
  
-- BETWEEN A AND B

-- 연산자를 생략해서 어디에서 어디까지를 표현하고 싶을 때

SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
  WHERE sal >= 1600 AND sal <= 2975;
  
SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
  WHERE sal BETWEEN 1600 AND 2975;
  
-- LIKE : 값들 중 특정 문자가 포함된 값을 출력하고 싶을 때

SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
  WHERE ename LIKE '__RD'; --J%, %ER, %E%, __RD
  
  -- NULL : 미지의 값
  
  SELECT ename, job, sal, comm
  FROM emp
  WHERE comm IS NOT NULL;
  
  -- UNION : JOIN과 다르게 아래로 표를 일괄 붙이고 싶을 때
  
  SELECT empno, ename, job FROM emp
   WHERE comm IS NOT NULL
  UNION ALL
  SELECT deptno, dname, loc FROM dept;