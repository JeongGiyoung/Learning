-- ������(WHERE)

SELECT * FROM emp
WHERE sal = 5000;

SELECT * FROM emp
WHERE job = 'CLERK';

SELECT * FROM emp
WHERE comm = 0 OR comm IS NULL;

-- WHERE ������ AND �����

--- ���ʽ��� NULL�̰� ������ ANALYST�� ����� ������

SELECT * FROM emp
WHERE comm IS NULL AND job = 'ANALYST';

-- SLECT �������� : ����� ����� �� ǥ���ϰ� ���� ���� ���ϰ� ���� ��

SELECT empno, ename, deptno
FROM emp
WHERE deptno = 30;

-- ����(JOIN) : �� �� �̻��� ���̺��� �ϳ��� ���̺�ó�� ��ȸ�ϴ� ���

--- ON : JOIN ������ � �������� ���̺��� ���� ���� ���ϴ� ��ɹ�

SELECT e.empno, e.ename, e.job, e.hiredate, e.sal, d.deptno, d.dname
 FROM emp e
 JOIN dept d
  ON e.deptno = d.deptno;

-- DISTICT : Ư�� ���� �ߺ����� ����ϰ� ���� ��

SELECT DISTINCT job FROM emp;

--��Ī(ALIAS) : ���� ����� �� ���� ���ϴ� �� �̸����� ����ϰ� ���� ��

--- AS Ȥ�� �� ĭ ���� ���ϴ� �̸�

--- ORDER BY ASC, DESC ��������, ��������

SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
  ORDER BY sal DESC; --ASC �������� / DESC ��������
  
-- WHERE 

SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
  WHERE sal*12 >= 10000;
 
 -- ���ǿ��� '���� �ʴ�'�� ǥ���ϴ� ���  

-- <>  
-- !=  
-- ^=
 
SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
  WHERE sal ^= 1000; -- <>, != ���� ���� ^= ���� �Ⱦ���

 -- WHERE NOT
 
 --- ���ǿ��� '�ƴϴ�'�� ǥ���ϴ� ���
 
SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
  WHERE NOT sal = 1000;
  
  -- IN : WHERE ������ ���� �� ������ AND ��ɹ��� �����ϸ鼭 ����ϰ� ���� ��
  
  
SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
  WHERE sal IN (800, 1600, 5000); 

-- ���� OR ���� ����ϸ鼭 ���� ����� ǥ���Ϸ���

SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
  WHERE sal = 800 OR sal=1600 OR sal=5000;
  
-- BETWEEN A AND B

-- �����ڸ� �����ؼ� ��𿡼� �������� ǥ���ϰ� ���� ��

SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
  WHERE sal >= 1600 AND sal <= 2975;
  
SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
  WHERE sal BETWEEN 1600 AND 2975;
  
-- LIKE : ���� �� Ư�� ���ڰ� ���Ե� ���� ����ϰ� ���� ��

SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
  WHERE ename LIKE '__RD'; --J%, %ER, %E%, __RD
  
  -- NULL : ������ ��
  
  SELECT ename, job, sal, comm
  FROM emp
  WHERE comm IS NOT NULL;
  
  -- UNION : JOIN�� �ٸ��� �Ʒ��� ǥ�� �ϰ� ���̰� ���� ��
  
  SELECT empno, ename, job FROM emp
   WHERE comm IS NOT NULL
  UNION ALL
  SELECT deptno, dname, loc FROM dept;