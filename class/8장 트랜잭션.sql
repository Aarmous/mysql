/* 트랜잭션 */ 

start transaction;
use madang; 
select * from book where bookid = 1; 
update book set price = 7100 where bookid = 1;
select * from book where bookid = 1; 
commit;


START TRANSACTION;
USE madang;
SELECT * FROM Book WHERE bookid=1;
UPDATE Book SET price=price+100 WHERE bookid=1;
SELECT * FROM Book WHERE bookid=1;
COMMIT;

start transaction;
use testdb;
insert into orders values (2, 2, '2025-09-05', 2, 12000);
insert into book values (3, '축구의 역사');
insert into book values (4, '야구의 역사');
insert into order_details values (2, 3, 3, 1, 6000);
insert into order_details values (2, 4, 4, 1, 6000);
commit;




