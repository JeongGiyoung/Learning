-- ���ڿ� �Լ�

-- UPPER : �빮��

SELECT * FROM emp
 WHERE job = UPPER('analyst');
 
 SELECT UPPER('analyst') FROM dual;

-- LOWER : �ҹ���

SELECT LOWER(ename) ename,
        INITCAP(job) job
    FROM emp
  WHERE comm IS NOT NULL;
  
-- LENGTH �ܾ� ����

--- LENGTHB �ܾ� ����Ʈ ��

  SELECT ename, 
    LENGTH(ename) ���ڼ�
  , LENGTHB(ename) ����Ʈ��
    
    FROM emp;
    
-- SUBSTRING 

--- ��µ� ���ڸ� �ڸ��� ��� ( '��µ� ����', ���۵Ǵ� ��, �� ���ڷ� �ڸ���)

SELECT SUBSTR('�ȳ��ϼ���, �Ѱ���IT�����п� �����͹��Դϴ�.', 18, 4) phase FROM dual;

-- REPLACE 

--- ���� ��ü

SELECT REPLACE('�ȳ��ϼ���, �Ѱ���IT�����п� �����͹��Դϴ�.', '�ȳ��ϼ���', '����������') phase 
  FROM dual;
  
-- || , CONCATATION 

--- �� ���ڿ� ��ġ��

SELECT 'A' || 'B' FROM dual;
SELECT CONCAT('A', 'B') FROM dual;

-- TRIM, LTRIM, RTRIM

--- ���ڿ� ���� ���ֱ�

SELECT '     �ȳ��ϼ���.     ' FROM dual;
SELECT LTRIM('    �ȳ��ϼ���.     ') FROM dual;
SELECT RTRIM('     �ȳ��ϼ���.     ') FROM dual;
SELECT TRIM('     �ȳ� �ϼ���.     ') FROM dual;

-- ROUND

--- �Ҽ��� �ݿø� (����, �� �ڸ����� �ݿø� �Ұ��� ����)

SELECT ROUND(15.193, 1) FROM dual;

-- SYSDATE : ���� ��¥ ���

SELECT SYSDATE FROM dual;

-- TO_CHAR : ���ڿ��� �����

SELECT ename, hiredate, TO_CHAR(hiredate, 'yyyy-mm-dd'), 
  TO_CHAR(sal) || '$'
    FROM emp;
    
-- TO_NUMBER : ���ڿ��� �����

SELECT TO_NUMBER(REPLACE('2400$', '$', '')) + 100 FROM dual;
SELECT TO_NUMBER('��õ���') FROM dual;

-- TO_DATE : ��¥ ������� �ٲٱ�

SELECT TO_DATE('2022-01-12') FROM dual;
SELECT TO_DATE('01/12/22') FROM dual;
SELECT TO_DATE('01/12/22', 'mm/dd/yy') FROM dual;

-- NVL : Null �� �ϰ�����

--- (�ٲٰ� ���� ���̺� �̸�, ��ü�� ��)

SELECT ename, job, sal, NVL(comm,0) comm,
      (sal*12) + NVL(comm,0) AS annsal
  FROM emp
  ORDER BY annsal DESC;
  
-- �����Լ� 

-- SUM, COUNT, MIN, MAX, AVG(���)

SElECT sal, NVL(comm, 0) comm FROM emp;

SElECT SUM(SAL) totalsalary FROM emp;
SElECT SUM(NVL(comm, 0)) totalcommision FROM emp;
SElECT SUM(comm) totalcommision FROM emp;

SELECT MAX(sal) FROM emp;

SELECT MIN(SAL) FROM emp;

SELECT AVG(sal) FROM emp;
SELECT ROUND(AVG(sal),0) sal_avg FROM emp;

-- Group by : Ư�� ���̺��� �������� �׷� ����

SELECT MAX(sal) �����ִ�, SUM(sal) ��������޿��հ�, job
  FROM emp
  GROUP by job;

-- HAVING : GROUP BY ��ɹ��� WHERE(����)��

SELECT MAX(sal) �����ִ�, SUM(sal) ��������޿��հ�, job
  FROM emp
  GROUP by job
  HAVING MAX(sal) > 4000;

--
SELECT deptno, job, AVG(sal) �������޿����, MAX(sal), MIN(sal), SUM(sal), Count(*)
  FROM emp
  GROUP BY deptno, job
  HAVING AVG(sal) >= 1000
  ORDER BY deptno, job;
  
-- ROLLUP : �׷����� ���� ���� ��ü ���� ��

SELECT deptno, NVL(job, '�հ�') JOB, 
        ROUND(AVG(sal),2) �޿����, MAX(sal) �޿��ִ�,
        SUM(sal) �޿��հ�, Count(*) �׷캰������
  FROM emp
  GROUP BY ROLLUP(deptno, job);
  
