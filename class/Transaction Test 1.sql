/* Transaction 1 ===== 읽기 */

start transaction; 
use madang; 
select * from orders;
select * from orders where orderid = 2;
commit;

use testdb;
create table users (
	id integer, 
    name varchar(20),
    age integer
    );
    
insert into users values (1, 'Hong Gil Gong', 30); 
select * from users;

-- 오손 실험 
set transaction isolation level read uncommitted; 
start transaction;
use testdb;
select * from users; 



commit;


-- 반복 불가능 읽기 non-repeatable read 테스트
set transaction isolation level read committed; 
start transaction;
use testdb;
select * from users;  -- age : 30 
-- tr2에서 age를 21로 update // commit 하기 전 
select * from users;  -- age : 30 
-- tr2에서 commit 완료
select * from users;  -- age : 21 
commit; 













