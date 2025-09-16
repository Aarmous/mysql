/* Transaction 2 ===== 읽기 */

start transaction; 
use madang; 
select * from orders where orderid = 1;
select * from orders where orderid = 2;
commit;


use testdb;
select * from users;


-- 오손 실험 
set transaction isolation level read uncommitted; 
start transaction;
use testdb;
set sql_safe_updates = 0; 
update users set age = 21 where id = 1;
select * from users;
rollback;


-- 반복 불가능 읽기 non-repeatable read 테스트
set transaction isolation level read committed; 
start transaction;
use testdb;
set sql_safe_updates = 0; 
update users set age = 21 where id = 1;
commit; 

update users set age = 30 where id = 1;





