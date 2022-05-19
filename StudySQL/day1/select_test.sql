-- emp 테이블 속성 표시
DESC emp;

-- emp 테이블 전부 표시
SELECT * FROM emp;

-- 컬럼을 구분해서 select
SELECT ename, job, hiredate 
 FROM emp;
 
 -- DISTINCT
 --- 표시할 열 값 중에 중복 값 제거하고 출력
SELECT DISTINCT deptno
FROM emp;

SELECT DISTINCT job, deptno
FROM emp;

-- DISTICT가 작동을 안하는 경우
--- EMPNO에 중복되는 번호가 없기 때문
SELECT DISTINCT empno, deptno
FROM emp;

-- WHERE
--- 조건절
SELECT * FROM emp
WHERE empno = 7499;

-- WHERE 조건값에 한글을 사용할 경우
SELECT * FROM emp
WHERE ename = '홍길동';

SELECT * FROM emp
WHERE job = 'CLERK';

-- WHERE 조건 값에 연산자와 숫자를 쓰는 경우
SELECT * FROM emp
WHERE sal >= 1500;
