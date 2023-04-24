--javadb

--usertbl 테이블 생성
--no(번호-숫자(4)), username(이름-한글(4)), birthYear(년도-숫자(4)), addr(주소-문자(한글,숫자)), mobile(010-1234-1234)
--no pk 제약조건 지정(제약조건명 pk_userTbL)
CREATE TABLE usertbl (
    no NUMBER(4) CONSTRAINT pk_userTbL PRIMARY KEY,
    username NVARCHAR2(10) NOT NULL,
    birthYear NUMBER(4) NOT NULL,
    ADDR NVARCHAR2(50) NOT NULL,
    mobile NVARCHAR2(15)
);


--select(+서브쿼리, 조인) + DML(insert,delete, update)
--전체조회
select * from usertbl;

--개별조회(특정번호, 특정이름.....)
--여러행이 나오는 상태냐? 하나의 행이 결과로 나올것이냐?
select * from usertbl where no=1;
select * from usertbl where username='홍길동';

--like : _ or %
select * from usertbl where username like '_길동%';

--insert into 테이블명(필드명1,필드명2...)
--values();

--update 테이블명
--set 업데이트할 필드명 = 값, 업데이트할 필드명 = 값....
--where 조건

--delete 테이블명 where 조건
--delete from 테이블명 where 조건  







--시퀀스 생성
--user_seq 생성(기본)
CREATE SEQUENCE user_seq;

--INSERT 
--NO : USER_SEQ 값 넣기
INSERT INTO userTBL(no,username, birthYear, ADDR, mobile)
values(user_seq.NEXTVAL, '홍길동', 2010, '서울시 종로구 123', '010-1234-5678');

COMMIT;





--모든 컬럼 not null
--paytype : pay_no(숫자-1 pk), info(문자-card,cash)
CREATE TABLE paytype(
    pay_no number(1) PRIMARY KEY,
    info nvarchar2(10) NOT NULL
);

--paytype_seq 생성
CREATE SEQUENCE paytype_seq;

INSERT INTO paytype VALUES(paytype_seq.NEXTVAL, 'card');
INSERT INTO paytype VALUES(paytype_seq.NEXTVAL, 'cash');

SELECT * FROM paytype;  --1: card,  2 : cash

--shop
--suser : user_id(숫자-4 pk), name(문자-한글), pay_no(숫자-1 : paytype 테이블에 있는 pay_no 참조 해서 사용)
CREATE TABLE suser(
    user_id number(4) PRIMARY KEY,
    name nvarchar2(20) NOT NULL,
    pay_no number(1) NOT NULL REFERENCES paytype(pay_no)
);

--product
--product_id(숫자-8 pk), pname(문자), price(숫자), content(문자)
CREATE TABLE product(
    product_id number(8) PRIMARY KEY,
    pname nvarchar2(30) NOT NULL,
    price number(10) NOT NULL,
    content nvarchar2(50) NOT NULL
);

CREATE SEQUENCE product_SEQ;

--sorder
--order_id(숫자-8 pk), user_id(suser 테이블의 user_id 참조), product_id(product 테이블의 product_id 참조)
CREATE TABLE sorder(
    order_id number(8) PRIMARY KEY,
    user_id number(4) NOT NULL REFERENCES suser(user_id),
    product_id number(8) NOT NULL REFERENCES product(product_id)
);

ALTER TABLE sorder ADD order_date DATE; --구매날짜

--order_sqe 생성
CREATE SEQUENCE order_seq;

--INSERT INTO sorder VALUES(order_seq.nextval

--DROP TABLE sorder;
--DROP TABLE product;
--DROP TABLE suser;
--DROP TABLE paytype;
--
--
--DROP SEQUENCE paytype_seq;
--DROP SEQUENCE order_sqe;

commit;

SELECT * FROM sorder;

SELECT u.user_id, u.name, u.pay_no, p.info 
FROM suser u, paytype p 
WHERE u.pay_no = p.pay_no AND u.user_id=1000;

--주문정보 전체 조회
SELECT * FROM sorder;

--주문목록 조회
--user_id, name, card/cash, product_id, pname, price, content

--기준 : sorder
--suser 테이블 : name, 
--paytype 테이블 : card/cash
--product 테이블 : product_id, pname, price, content

--전체 주문목록
SELECT s.user_id, u.name, t.info, s.product_id, p.pname, p.price, p.content, s.order_date 
FROM sorder s, suser u, paytype t, product p 
WHERE s.user_id=u.user_id AND u.pay_no=t.pay_no AND s.product_id=p.product_id;

--홍길동 주문목록 조회  
SELECT s.user_id, u.name, t.info, s.product_id, p.pname, p.price, p.content, s.order_date 
FROM sorder s, suser u, paytype t, product p 
WHERE s.user_id=u.user_id AND u.pay_no=t.pay_no AND s.product_id=p.product_id AND s.user_id = 1000;

commit;

--도서 테이블
-- code, title, writer, price
-- code : 1001(pk)
-- title : '자바의 신'
-- writer : '홍길동'
-- price : 25000

--bookTBL 테이블 생성
CREATE TABLE booktbl(
    code number(6) PRIMARY KEY,
    title NVARCHAR2(50) NOT NULL,
    writer NVARCHAR2(20) NOT NULL,
    price NUMBER(8) NOT NULL    
);

insert into booktbl(code, title, writer, price) values(1001,'이것이 자바다','신용균',25000);
insert into booktbl(code, title, writer, price) values(1002,'자바의 신','강신용',28000);
insert into booktbl(code, title, writer, price) values(1003,'오라클로 배우는 데이터베이스','이지훈',28000);
insert into booktbl(code, title, writer, price) values(1004,'자바 1000제','김용만',29000);
insert into booktbl(code, title, writer, price) values(1005,'자바 프로그래밍 입문','박은종',30000);

commit;

alter table booktbl add description nvarchar2(100);

--열삭제
alter table booktbl drop column desctiption;