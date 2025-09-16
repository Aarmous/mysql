select bookname 
from book 
where price = (select min(price) from book);


-- 박지성이 구매하지 않은 도서의 이름 ? 
select bookname 
from customer c join orders o join book b on o.custid = c.custid and o.bookid = b.bookid
where name <> '박지성'; 

-- 주문하지 않은 고객의 이름 
select * from orders;
select * from customer;

-- 출판사별로 출판사의 평균 도서가격보다 비싼 도서를 구하시오. 
-- 출판사별 평균도서가격 
select publisher, avg(price) from book
group by publisher;

select b1.bookname 
from book b1
where b1.price > (SELECT avg(b2.price)
	FROM Book b2
	WHERE b2.publisher=b1.publisher);

-- 매출테이블에서 각 브랜드별 제품 판매가 각 브랜드별 평균판매보다 높은 매출을 구하시오.(demo_sales.sql 실행)
select brand, avg(saleprice)
from sales 
group by brand;

SELECT 
    s1.brand, s1.saleprice
FROM
    sales s1
WHERE
    s1.saleprice > (SELECT 
            AVG(s2.saleprice)
        FROM
            sales s2
        WHERE
            s1.brand = s2.brand)
ORDER BY brand; 


-- 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
-- 1단계 : 도서가격과 판매가격 차이의 max 구하기
select max(abs(price-saleprice))
from book b 
join orders o 
on b.bookid = o.bookid;  -- 이게 6000이 나온다.
-- 2단계 : 차이가 가장 큰 주문의 내역 출력하기 
select * 
from book b 
join orders o on b.bookid = o.bookid
where abs(price - saleprice) = 6000;
-- 3단계 : 합치기
select * 
from book b 
join orders o on b.bookid = o.bookid
where abs(price - saleprice) = 
	(select max(abs(price-saleprice))
	from book b 
	join orders o 
	on b.bookid = o.bookid);

-- 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
-- 1단계 : 도서의 판매액 평균 구하기
select avg(saleprice) from orders;
-- 2단계 : 자신의 구매액 평균이 도서판매액 평균보다 더 높은 고객의 이름 구하기 
select name, avg(saleprice) as 구매액평균 
from customer c join orders o on c.custid = o.custid
group by name
having 구매액평균 > 11800;
-- 3단계 : 합치기
select name, avg(saleprice) as 구매액평균 
from customer c join orders o on c.custid = o.custid
group by name
having 구매액평균 > (select avg(saleprice) from orders);

/* 연습문제 1 */
select bookname 
from book
where bookid = 1;



