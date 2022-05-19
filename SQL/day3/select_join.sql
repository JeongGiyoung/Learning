-- INNER JOIN : ���� ���� ���̺��� ���� ������ �Ǿ, ���ǿ� �´� ���� ���

-- ON : INNER JOIN ��ɹ��� ����

--- NULL ���� ��µ��� �ʴ´�

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
    
-- PL/SQL �̳�����(INNER JOIN)

--- TIP) WHERE ������ 1�� 1�̴ٶ�� �׻� ������ ���� ����, ������ AND�� �ξ ������ �߰��ϱ� ���� 

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
        
-- LEFT OUTER JOIN : ���� ���̺��� ��������, ���ǿ� ���� �ʴ� ���̺� ���� NULL�� ����ؼ� ���̴� ��

SELECT e.empno
         , e.ename
         , e.job
         , TO_CHAR(e.hiredate, 'yyyy-mm-dd') hiredate
         , e.deptno
         , d.dname
  FROM emp e
    LEFT OUTER JOIN dept d
      ON e.deptno = d.deptno;
      
-- RIGHT OUTER JOIN : ������ ���̺��� ��������, ���ǿ� ���� �ʴ� ���̺� ���� NULL�� ����ؼ� ���̴� ��

SELECT e.empno
         , e.ename
         , e.job
         , TO_CHAR(e.hiredate, 'yyyy-mm-dd') hiredate
         , e.deptno
         , d.dname
  FROM emp e
    RIGHT OUTER JOIN dept d
      ON e.deptno = d.deptno;
      
-- PL/SQL ������ right outer join 

--- (+)�� �پ����� �ʴ� ���� ����(Right�� �ȴٴ� ��)

SELECT e.empno
         , e.ename
         , e.job
         , TO_CHAR(e.hiredate, 'yyyy-mm-dd') hiredate
         , e.deptno
         , d.dname
    FROM emp e, dept d
      WHERE e.deptno (+) = d.deptno ;  -- d.deptno�� ����
--    WHERE e.deptno  = d.deptno (+) ; -- e.deptno�� ����

-- 3�� ���̺� �̳�����(INNER JOIN) : ���ǿ� ��ġ�ϴ� ���� ���

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
        
-- 3�� ���̺� �ƿ��� ����(OUTER JOIN) : ���ǿ� ��ġ���� �ʴ� ���� NULL ���

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