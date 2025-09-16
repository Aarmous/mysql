select abs(-78);
select 1+1;

select replace('야구의 추억', '야구', '축구');   -- 축구의 추억

select char_length('야구의 추억');   -- 6
select length('야구의 추억');  -- 16

select substr("hello", 3, 2);  -- 3번째 자리부터 2글자를 짤라 보여줘 
select substr("김연아", 1, 1);   -- 이름의 성을 구하기 

use madang; 
select * from customer where name like '박%';   --  박씨를 구해줘 
select * from customer where substr(name, 1, 1) = '김';   -- 김씨를 구해줘 

select adddate('2025-09-03', interval 10 day) '10일 후 날짜';   -- '10일 후' 전에 as 생략 
select date_format(sysdate(), '%Y-%m-%d') '오늘 날짜'; 
select str_to_date('20250903', '%Y%m%d') '입력된 날짜'; 

-- 모든 결제일을 '주문일'로 바꾸고, 거기에 10일을 더한 '확정일'을 구해라. 
select orderid, orderdate '주문일', adddate(orderdate, 10) '확정일' from orders;


-- =========================================================
create table mybook (
	bookid integer primary key, 
    price integer 
);
select * from mybook; 
select count(price), sum(price), avg(price) from mybook where bookid = 3;
select count(*), count(price), sum(price), avg(price) from mybook;

select * from mybook where price = null;  -- null 은 비교연산 불가능 / 값이 안 나온다. 
select * from mybook where price is null;
select * from mybook where price is not null;

select * from customer; 
select name, phone, ifnull(phone, '연락처 없음') '전화번호' from customer;   -- null 이 보여질때만 '연락처 없음'으로 보인다. (값이 변경된게 아님) 


-- =========================================================
/* 사용자 정의 변수 */ 
set @seq := 0; 
select @seq; 
select @seq := @seq +1; 
select @seq; 

set @seq := 0; 
select (@seq := @seq +1) no, name, phone
from customer; 

set @seq := 0; 
select (@seq := @seq +1) no, name, phone
from customer
where @seq < 3; 

set @seq := 0; 
select (@seq := @seq +1) no, name, phone
from customer
where substr(name, 1, 1) = '박';  -- 박씨인 데이터를 번호(no)를 매겨 가져와. 


-- =========================================================
/* 스칼라 부속질의 - select 문에서 사용됨 */ 
-- 마당서점의 고객별 판매액을 보이시오. 
select orderid, sum(saleprice) 
from orders 
group by orderid;

select (select name from customer c where c.custid = o.custid) 고객명, sum(saleprice) 
from orders o
group by 고객명; 

select name, sum(saleprice) 
from orders o, customer c
where o.custid = c.custid 
group by name;


select * from orders;
set sql_safe_updates = 0;
update orders o set bname = 
	(select bookname from book b where b.bookid = o.bookid);
set sql_safe_updates = 1;
select * from orders;


-- =========================================================
/* 인라인 뷰 부속질의 - from 절에서 사용되는 서브쿼리 */ 
-- 고객번호가 2 이하인 고객의 판매액을 보이시오. (고객이름과 고객별 판매액 출력) 
select name, sum(saleprice)  -- cost : 2.41
from customer c, orders o 
where c.custid = o.custid 
and c.custid <= 2
group by name;

select name, sum(saleprice)  -- cost : 2.41 (데이터가 소량이라 그렇지, 대량이면 이 방법이 더 빠름)
from (select custid, name from customer where custid <= 2) c, 
	orders o 
where c.custid = o.custid 
group by name;


/* 뷰 - 가상의 테이블 */ 
create view v_orders (orderid, custid, name, bookid, bookname, saleprice, orderdate) 
as 
select orderid, o.custid, name, o.bookid, bookname, saleprice, orderdate
from orders o join customer c join book b
on c.custid = o.custid and o.bookid = b.bookid;

select * from v_orders;
select * from v_orders where name like '김연아';

drop view v_orders; 

-- 대한민국에 거주하는 고객들로 구성된 뷰 만들기 
create view v_customer 
as 
select *
from customer 
where address like '대한민국%'; 

select * from v_customer;
desc v_customer; 
show create view v_customer; 















