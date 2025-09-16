/* 가격이 10,000원 이상 20,000원 이하인 도서를 검색하시오. */
select * 
from book
where price between 10000 and 20000;

/* 가격이 10,000원 이상 20,000원 이하인 도서를 검색하시오. */
select * 
from book
where price >= 10000 and price <= 20000;

/* 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오 */
select * from book where publisher = '굿스포츠' or publisher = '대한미디어';
select * from book where publisher in ('굿스포츠', '대한미디어');

/* 출판사가 '굿스포츠' 혹은 '대한미디어'가 아닌 도서를 검색하시오 */
select * from book where publisher <> '굿스포츠' and publisher <> '대한미디어';
select * from book where publisher not in ('굿스포츠', '대한미디어');

/* 패턴 like, _ , % */
/* 축구의 역사를 출간한 출판사를 검색하시오 */
select bookname,publisher from book where bookname like '%축구%';
select * from book;

/* 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오 */
select * from book
where bookname like '%축구%' and price >= 20000;

/* 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오 */
select * from book
where publisher like '굿스포츠' or publisher like '대한미디어';

/* 도서를 이름순으로 검색하시오 */
select *
from book
order by bookname ;

/* 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오 */
select *
from book
order by price desc, bookname asc;

/* 고객이 주문한 도서의 총 판매액을 구하시오 */
select sum(saleprice) as 총판매액
from orders;

/* 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오 */
select sum(saleprice) as 총판매액
from orders
where custid = 2;

/* 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오 */
select sum(saleprice) as Total, avg(saleprice) as Average,
min(saleprice) as Minimum, max(saleprice) as Maximum
from orders;

/* 마당서점의 도서 판매 건수를 구하시오 */
select count(orderid) from orders;
select count(custid) from customer ;
select count(distinct publisher) as 출판사수 from book ;

select count(*) as 고객수 
from customer 
where custid >= 1
having count(*) > 0;

/* 고객별로 구매한 도서의 건수를 구하되, 단 구매건수가 3건 이상인 내용만 출력해줘 */
select custid, count(*) as 구매건수 from orders
group by custid
having 구매건수 >= 2;

/* 고객별로 구매한 도서의 건수를 구하되, 단 구매총액이 35000 원 이상인 주문내역만 출력해줘 */
select custid, count(*) , sum(saleprice) as 총액 
from orders
group by custid
having 총액 >= 35000;

/* 각 고객별로 구매한 도서 중 가장 비싼 책의 가격을 구하시오. 단 2만원 이상인 것만 출력하시오. */
select max(saleprice) as 최고가
from orders
group by custid
having 최고가 >= 20000;

/* 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오.
단, 두 권 이상 구매한 고객만 구한다. */
select custid, count(*) as 총수량
from orders
where saleprice > 8000
group by custid
having 총수량 >= 2
order by custid;
/* 3장 연습문제 */
-- 1-1)
select bookname from book where bookid = 1;
-- 1-2)
select bookname from book where price >= 20000;
-- 1-3)
select sum(saleprice) as 총구매액
from orders
where custid = 1;
-- 1-4)
select count(saleprice) as 구매건수
from orders
where custid = 1;
/* 2. 마당서점의 운영자와 경영자가 요구하는 질문 */
-- 2-1) 
select count(*) from book;
-- 2-2) 
select count(distinct publisher) from book;
-- 2-3) 
select name, address from customer;
-- 2-4) 
select orderid from orders
where orderdate between '2023-07-04' and '2023-07-07';
-- 2-5) 
select orderid from orders
where orderdate < '2023-07-04' or orderdate > '2023-07-07';
-- 2-6) 
select name, address from customer
where name like '김%' ;
-- 2-7) 
select name, address from customer
where name like '김%' and name like '%아';