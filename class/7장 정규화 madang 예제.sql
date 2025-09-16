use testdb;

create table orders (
	order_id integer not null primary key, 
    cust_id integer, 
    order_date date, 
    order_qty integer,
    order_amount integer
);

SELECT * FROM orders;
SELECT * FROM order_details;
SELECT * FROM book;

insert into orders values (1, 1, '2025-09-04', 5, 22000);

create table order_details (
	order_id integer not null, 
    seq integer not null, 
    book_id integer, 
    qty integer,
    saleprice integer,    
    primary key (order_id, seq),
    foreign key (order_id) references orders(order_id),
    foreign key (book_id) references book(book_id)
);

insert into order_details values (1, 1, 1, 2, 5000);
insert into order_details values (1, 2, 2, 3, 4000);


create table book (
	book_id integer not null primary key, 
    bookname varchar(40)
);

insert into book values (1, '축구의 이해');
insert into book values (2, '야구의 이해');



