-- INNER JOIN : 서로 붙일 테이블이 서로 기준이 되어서, 조건에 맞는 값만 출력

-- ON : INNER JOIN 명령문의 조건

--- NULL 값이 출력되지 않는다

SELECT e.empno
         , e.ename
         , e.job
         , TO_CHAR(e.hiredate, 'yyyy-mm-dd') hiredate
         , e.deptno
         , d.dname
    FROM emp e
    INNER JOIN dept d
      ON e.deptno = d.deptno
    WHERE e.job = 'SALESMAN';
    
-- PL/SQL 이너조인(INNER JOIN)

--- TIP) WHERE 절에는 1이 1이다라는 항상 참값을 적어 놓고, 밑으로 AND를 두어서 조건을 추가하기 좋게 

SELECT e.empno
         , e.ename
         , e.job
         , TO_CHAR(e.hiredate, 'yyyy-mm-dd') hiredate
         , e.deptno
         , d.dname
    FROM emp e, dept d
      WHERE 1=1 -- TIP  
        AND e.deptno = d.deptno
        AND e.job = 'SALESMAN';
        
-- LEFT OUTER JOIN : 왼쪽 테이블을 기준으로, 조건에 맞지 않는 테이블 값도 NULL로 출력해서 붙이는 것

SELECT e.empno
         , e.ename
         , e.job
         , TO_CHAR(e.hiredate, 'yyyy-mm-dd') hiredate
         , e.deptno
         , d.dname
  FROM emp e
    LEFT OUTER JOIN dept d
      ON e.deptno = d.deptno;
      
-- RIGHT OUTER JOIN : 오른쪽 테이블을 기준으로, 조건에 맞지 않는 테이블 값도 NULL로 출력해서 붙이는 것

SELECT e.empno
         , e.ename
         , e.job
         , TO_CHAR(e.hiredate, 'yyyy-mm-dd') hiredate
         , e.deptno
         , d.dname
  FROM emp e
    RIGHT OUTER JOIN dept d
      ON e.deptno = d.deptno;
      
-- PL/SQL 형식의 right outer join 

--- (+)이 붙어있지 않는 쪽이 기준(Right가 된다는 말)

SELECT e.empno
         , e.ename
         , e.job
         , TO_CHAR(e.hiredate, 'yyyy-mm-dd') hiredate
         , e.deptno
         , d.dname
    FROM emp e, dept d
      WHERE e.deptno (+) = d.deptno ;  -- d.deptno가 기준
--    WHERE e.deptno  = d.deptno (+) ; -- e.deptno가 기준

-- 3개 테이블 이너조인(INNER JOIN) : 조건에 일치하는 값만 출력

SELECT e.empno
         , e.ename
         , e.job
         , TO_CHAR(e.hiredate, 'yyyy-mm-dd') hiredate
         , e.deptno
         , d.dname
         , b.comm
    FROM emp e, dept d, bonus b
      WHERE e.deptno = d.deptno
        AND e.ename = b.ename ;
        
-- 3개 테이블 아우터 조인(OUTER JOIN) : 조건에 일치하지 않는 값도 NULL 출력

SELECT e.empno
         , e.ename
         , e.job
         , TO_CHAR(e.hiredate, 'yyyy-mm-dd') hiredate
         , e.deptno
         , d.dname
         , b.comm
    FROM emp e, dept d, bonus b
      WHERE e.deptno (+) = d.deptno
        AND e.ename = b.ename (+);