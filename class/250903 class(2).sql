SELECT * FROM testdb.user;

use testdb;

-- (테이블은 gui로 만듬) 

insert into user values ('zzz', 'name3', 1990, '서울'); 
insert into user values ('aaa', 'name2', 1990, '서울'); 
insert into user values ('ppp', 'name1', 1990, '서울'); 

SELECT * FROM testdb.user;

show index from user;
show index from madang.book;

-- ====================

drop table user;
create table user (
	userid varchar(8) not null unique, 
    name varchar(10) not null, 
    birthYear integer not null, 
    city varchar(5) not null
);

insert into user values ('zzz', 'name3', 1990, '서울'); 
insert into user values ('aaa', 'name2', 1990, '서울'); 
insert into user values ('ppp', 'name1', 1990, '서울'); 

-- ====================

drop table user;
create table user (
	userid varchar(8) not null primary key, 
    name varchar(10) not null, 
    birthYear integer not null, 
    city varchar(5) not null,
    userid2 varchar(8) not null unique
);

show index from user;

insert into user values ('zzz', 'name3', 1990, '서울', 'aaa'); 
insert into user values ('aaa', 'name2', 1990, '서울', 'ccc'); 
insert into user values ('ppp', 'name1', 1990, '서울', 'bbb'); 

SELECT * FROM testdb.user;


/* 보조 인덱스 실습 - book */
use madang;
show index from book;

select * from book where bookname like '축구%';   -- cost : 1.65 

create index idx_bookname on book (bookname asc);
show index from book;
select * from book; 
select * from book where bookname like '축구%';   -- cost : 1.61  (데이터가 대량이면 더 줄었을 것)










