/* ch03_SQL 기초 */

-- 1. 마당서점의 고객이 요구하는 다음 질문에 대해 SQL 문을 작성하시오.

-- (1) 도서번호가 1인 도서의 이름 
select bookid, bookname from book where bookid = 1; 

-- (2) 가격이 20,000원 이상인 도서의 이름
select bookname, price from book where price >= 20000;

-- (3) 박지성의 총 구매액(박지성의 고객번호는 1번으로 놓고 작성)
select sum(saleprice) 총구매액 from orders  
group by custid 
having custid = 1; 

-- (4) 박지성이 구매한 도서의 수(박지성의 고객번호는 1번으로 놓고 작성)
select count(saleprice) 구매건수 
from orders 
where custid = 1; 


-- 2. 마당서점의 운영자와 경영자가 요구하는 다음 질문에 대해 SQL 문을 작성하시오.

-- (1) 마당서점 도서의 총 개수
select count(bookid) '책의 총 권수' 
from book; 

select count(distinct bookname) '책의 종류 수' 
from book; 

-- (2) 마당서점에 도서를 출고하는 출판사의 총 개수
select count(distinct publisher) from book;

select distinct publisher, count(publisher) '출판사별 책 권수' 
from book
group by publisher; 

-- (3) 모든 고객의 이름, 주소
select name 이름, address 주소 
from customer; 

-- (4) 2023년 7월 4일~7월 7일 사이에 주문 받은 도서의 주문번호
select orderid, orderdate
from orders
where orderdate between '2023-07-04' and '2023-07-07'; 

-- (5) 2023년 7월 4일~7월 7일 사이에 주문 받은 도서를 제외한 도서의 주문번호
select orderid, orderdate
from orders
where orderdate < '2023-07-04' or orderdate > '2023-07-07';

-- (6) 성이 ‘김’ 씨인 고객의 이름과 주소
select name 이름, address 주소 
from customer 
where name like '김%';

select name 이름, address 주소 
from customer 
where substr(name, 1, 1) = '김';

-- (7) 성이 ‘김’ 씨이고 이름이 ‘아’로 끝나는 고객의 이름과 주소
select name 이름, address 주소 
from customer 
where name like '김%' and name like '%아'; 


-- 1. 마당서점의 고객이 요구하는 다음 질문에 대해 SQL 문을 작성하시오.

-- (5) 박지성이 구매한 도서의 출판사 수
select count(distinct b.publisher) 
from book b join orders o join customer c 
on b.bookid = o.bookid and c.custid = o.custid 
where c.name like '박지성' 


-- (6) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이


-- (7) 박지성이 구매하지 않은 도서의 이름







-- 1-1) 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름 

-- 1단계 : 박지성이 구매한 도서의 출판사들 ( 굿스포츠, 대한미디어, 나무수 ) 
select publisher 
from book b join orders o on b.bookid = o.bookid
join customer c on o.custid = c.custid
where c.name like '박지성';

-- 2단계 : (굿스포츠, 대한미디어, 나무수) 출판사의 책을 구매한 고객들의 이름들 
select distinct name  
from customer c join orders o on c.custid = o.custid 
join book b on o.bookid = b.bookid 
where b.publisher in ('굿스포츠', '대한미디어', '나무수');

-- 3단계 : 합치기
select distinct name  
from customer c join orders o on c.custid = o.custid 
join book b on o.bookid = b.bookid 
where b.publisher in (select publisher 
from book b join orders o on b.bookid = o.bookid
join customer c on o.custid = c.custid
where c.name like '박지성')
and c.name <> '박지성';


-- 1-2) 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름

select c.name
from customer c join orders o on c.custid = o.custid 
join book b on o.bookid = b.bookid
group by c.custid
having count(distinct b.publisher) >= 2; 


-- 1-3) 전체 고객의 30% 이상이 구매한 도서

-- 1단계: 전체 고객 수
select count(*) from customer;

-- 1.5단계: 전체 고객의 30%
select count(*) * 0.3 from customer;

-- 2단계: 각 도서를 몇 명의 고객이 샀는지
select b.bookname, count(distinct o.custid) as 판매권수
from book b join orders o on b.bookid = o.bookid
group by b.bookid, b.bookname; 

-- 3단계: 합치기 
select b.bookname 
from book b join orders o on b.bookid = o.bookid
group by b.bookid, b.bookname
having count(distinct o.custid) >= 
(select count(*) * 0.3 from customer); 


-- 2-1) 새로운 도서 ('스포츠 세계', '대한미디어', 10000원)이 마당서점에 입고되었다. 삽입이 안 될 경우 필요한 데이터가 더 있는지 찾아보자.
insert into book(bookid, bookname, publisher, price) values (11, '스포츠세계', '대한미디어', 10000);
select * from book;










