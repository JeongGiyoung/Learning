-- emp ���̺� �Ӽ� ǥ��
DESC emp;

-- emp ���̺� ���� ǥ��
SELECT * FROM emp;

-- �÷��� �����ؼ� select
SELECT ename, job, hiredate 
 FROM emp;
 
 -- DISTINCT
 --- ǥ���� �� �� �߿� �ߺ� �� �����ϰ� ���
SELECT DISTINCT deptno
FROM emp;

SELECT DISTINCT job, deptno
FROM emp;

-- DISTICT�� �۵��� ���ϴ� ���
--- EMPNO�� �ߺ��Ǵ� ��ȣ�� ���� ����
SELECT DISTINCT empno, deptno
FROM emp;

-- WHERE
--- ������
SELECT * FROM emp
WHERE empno = 7499;

-- WHERE ���ǰ��� �ѱ��� ����� ���
SELECT * FROM emp
WHERE ename = 'ȫ�浿';

SELECT * FROM emp
WHERE job = 'CLERK';

-- WHERE ���� ���� �����ڿ� ���ڸ� ���� ���
SELECT * FROM emp
WHERE sal >= 1500;
