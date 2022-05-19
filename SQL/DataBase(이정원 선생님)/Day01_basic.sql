-- 테이블 생성

Create Table lprod (
    lprod_id number(5) Not Null,
    lprod_gu char(4) Not Null,
    lprod_nm varchar2(40) Not Null,
    CONSTRAINT pk_lprod Primary Key (lprod_gu)
) ;

-- 조회하기
Select lprod_id, lprod_gu, lprod_nm
From lprod ;

-- 데이터 입력
Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    1, 'P101', '컴퓨터제품'
) ;

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    2, 'P102', '전자제품'
) ;

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    3, 'P201', '여성캐쥬얼'
) ;

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    4, 'P202', '남성캐쥬얼'
) ;

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    5, 'P301', '피혁잡화'
) ;

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    6, 'P302', '화장품'
) ;

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    7, 'P401', '음반/CD'
) ;

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    8, 'P402', '도서'
) ;

Insert into lprod (
    lprod_id, lprod_gu, lprod_nm
) Values (
    9, 'P403', '문구류'
) ;

Select lprod_id, lprod_gu, lprod_nm
From lprod;

-- 상품분류정보에서 상품분류코드의 값이
-- P201보다 큰 데이터를 조회해 주세요.

Select *
From lprod
Where lprod_gu > 'P201' ; 

-- 상품분류코드가 P102에 대해서 
-- 상품분류명의 값을 향수로 수정한다.

Select *
From lprod
Where lprod_gu = 'P102' ;

Update lprod
    Set lprod_nm = '향수'
Where lprod_gu = 'P102' ;

-- 상품분류정보에서
-- 상품분류코드가 P202에 대한 데이터를 삭제한다.

Select *
From lprod
Where lprod_gu = 'P202' ;

Delete From lprod 
Where lprod_gu ='P202' ;

Commit ;

-- 거래처 정보 테이블 생성

Create Table buyer
  (buyer_id char(6) NOT NULL, -- 거래처 코드
  buyer_name varchar2(40) NOT NULL, -- 거래처명
  buyer_lgu char(4) NOT NULL, -- 취급상품 대분류
  buyer_bank varchar2(60), -- 은행
  buyer_bankno varchar2(60), -- 계좌번호
  buyer_bankname varchar2(15), -- 예금주
  buyer_zip char(7), -- 우편번호
  buyer_add1 varchar2(100), -- 주소1
  buyer_add2 varchar2(70), -- 주소2
  buyer_comtel varchar2(14) NOT NULL, -- 전화번호
  buyer_fax varchar2(20) NOT NULL ) ; -- FAX 번호

-- 테이블 속성(형태) 변경

ALTER TABLE buyer ADD (buyer_mail varchar2(60) NOT NULL,
                                        buyer_charger varchar2(20),
                                        buyer_telext varchar2(2)
                                        );

ALTER TABLE buyer MODIFY ( buyer_name varchar(60) );

-- Foreign Key 명령어로 buyer_lgu이 '자식 컬럼'이 되고 lprod_gu 컬럼이 '부모 컬럼'이 된다.
ALTER TABLE buyer
    ADD ( Constraint pk_buyer Primary Key (buyer_id),
              Constraint fr_buyer_lprod Foreign key (buyer_lgu)
                  References lprod(lprod_gu) );