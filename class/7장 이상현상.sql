/* 이상현상 */ 

SELECT * FROM testdb.student;

select * from student where name like '장미란';
select * from student where name like '박지성';

set SQL_safe_updates = 0;
delete from student where name like '장미란' and classname like '스포츠경영학';
set SQL_safe_updates = 1;
select * from student where name like '장미란';

select * from student where name like '박지성' and classname like '자료구조';
set SQL_safe_updates = 0;
update student set address = '대한민국 서울' where name like '박지성' and classname like '자료구조';
set SQL_safe_updates = 1;
select * from student where name like '박지성';

insert into student(sid, name, dept, address) values (403, '박세리', '체육학과', '대한민국 대전');
select * from student where name like '박세리';


-- ========================================================
DROP TABLE IF EXISTS Summer; /* 기존 테이블이 있으면 삭제 */

CREATE TABLE Summer
( sid INTEGER,
class VARCHAR(20),
price INTEGER
);

INSERT INTO Summer VALUES (100, 'FORTRAN', 20000);
INSERT INTO Summer VALUES (150, 'PASCAL', 15000);
INSERT INTO Summer VALUES (200, 'C', 10000);
INSERT INTO Summer VALUES (250, 'FORTRAN', 20000);

/* 생성된 Summer 테이블 확인 */ 
SELECT * FROM Summer;

-- 계절학기를 듣는 학생의 학번과 수강하는 과목은?
select sid, class from summer;

-- C 강좌의 수강료는?
select price from summer where class like 'C';

-- 수강료가 가장 비싼 과목은?
select class, price from summer where price = (select max(price) from summer);

-- 계절학기를 듣는 학생 수와 수강료 총액은?
select count(*), sum(price) from summer;

-- 200번 학생의 계절학기 수강신청을 취소하시오.
select class from summer where sid = 200;
set SQL_safe_updates = 0;
delete from summer where sid = 200;
SELECT * FROM Summer;

INSERT INTO Summer VALUES (200, 'C', 10000);

-- 계절학기에 새로운 자바 강좌를 개설하시오.
insert into summer (class, price) values ('Java', 25000); 
SELECT * FROM Summer;

-- 계절학기를 듣는 학생 수와 수강료 총액은?
select count(sid), sum(price) from summer;
select count(sid), sum(price) from summer where sid is not null;

-- FORTRAN 강좌의 수강료를 20,000원에서 15,000원으로 수정하시오.
select * from summer where class like 'Fortran';
update summer set price =15000 where class like 'Fortran';
select * from summer where class like 'Fortran';
SELECT * FROM Summer;
update summer set price =20000 where class like 'Fortran';

-- sid가 null인 데이터 삭제하기 
select * from summer where sid is null;
delete from summer where sid is null;
SELECT * FROM Summer;

-- 테이블 쪼개기 
CREATE TABLE summerPrice ( 
	class VARCHAR(20),
	price INTEGER
);

INSERT INTO SummerPrice VALUES ('FORTRAN', 20000);
INSERT INTO SummerPrice VALUES ('PASCAL', 15000);
INSERT INTO SummerPrice VALUES ('C', 10000);
SELECT * FROM SummerPrice;

CREATE TABLE summerEnroll ( 
	sid integer,
	class VARCHAR(20)
);

INSERT INTO SummerEnroll VALUES (100, 'FORTRAN');
INSERT INTO SummerEnroll VALUES (150, 'PASCAL');
INSERT INTO SummerEnroll VALUES (200, 'C');
INSERT INTO SummerEnroll VALUES (250, 'FORTRAN');
SELECT * FROM SummerEnroll;


-- ============= 테이블 분리 후 이상현상 발생 여부 확인 ============================
-- 계절학기를 듣는 학생의 학번과 수강하는 과목은?
select sid '계절학기 학생 학번', class '수강과목' from summerenroll;

-- C 강좌의 수강료는?
select price 'C 강좌의 수강료' from summerprice where class like 'C';

-- 수강료가 가장 비싼 과목은?
select class '수강료가 가장 비싼 과목', price from summerprice where price = (select max(price) from summerprice);

-- 계절학기를 듣는 학생 수와 수강료 총액은?
select count(sid) '학생 수', sum(price) '수강료 총액' 
from summerenroll e 
join summerprice p on p.class = e.class;

-- 200번 학생의 계절학기 수강신청을 취소하시오.
select class from summerenroll where sid = 200;
delete from summerenroll where sid = 200;
SELECT * FROM Summerenroll;

-- C 강좌의 수강료는? 
select * from summerprice where class = 'C';

-- 계절학기에 새로운 자바 강좌를 개설하시오.
insert into summerprice (class, price) values ('Java', 25000); 
SELECT * FROM Summerprice;
SELECT * FROM Summerenroll;

-- 계절학기를 듣는 학생 수와 수강료 총액은?
select count(*), sum(price) 
from summerenroll e 
join summerprice p on p.class = e.class;

-- 100번 학생이 수강하는 FORTRAN 강좌의 수강료를 20,000원에서 15,000원으로 수정하시오.
select * 
from summerenroll e 
join summerprice p on p.class = e.class
where sid = 100 and e.class = 'Fortran';

update summerprice set price = 15000 where class = 'Fortran';

select distinct price from summerprice where class like 'Fortran';

select * 
from summerenroll e 
join summerprice p on p.class = e.class
where e.class = 'Fortran';









