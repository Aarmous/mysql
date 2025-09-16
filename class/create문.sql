use madang; 

drop table if exists newbook;

create table NewBook (
	bookid integer auto_increment,
    bookname varchar(20), 
    publisher varchar(20), 
    price integer,
    primary key(bookid)
    );
    
    
create table NewBook (
    bookname varchar(20) not null, 
    publisher varchar(20) unique, 
    price integer default 10000 check(price >= 1000),
    primary key(bookname, publisher)
    );
    
create table newcustomer (
	custid integer primary key auto_increment,
    name varchar(40), 
    address varchar(40), 
    phone varchar(30)
);
    
    
create table neworders (
	orderid integer primary key auto_increment,
	custid integer, 
    bookid integer not null, 
    saleprice integer, 
    orderdate date,
    FOREIGN KEY (custid) REFERENCES newcustomer(custid)
	ON DELETE SET NULL 
    
);
    
select * from newbook;

insert into newbook(bookname, publisher, price) values ('스포츠 의학', '한솔의학서적', 90000); 
insert into newbook(bookname, publisher) values ('스포츠 의학', '한솔의학서적'); 

insert into book select * from imported_book;

select * from book; 

insert into newbook(bookname, publisher, price) select bookname, publisher, price from book;


