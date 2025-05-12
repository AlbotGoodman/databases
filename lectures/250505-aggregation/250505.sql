create table teachers (
    id int primary key identity(100, 5),
    name nvarchar(max),
    birthdate datetime2
);

insert into teachers values ('Teacher', getdate());
select * from teachers;

delete from teachers where id between 4 and 7; -- nothing
delete from teachers where id between 99 and 187; -- 1 row affected

truncate table teachers;

select newid(); -- GUI, general unique identifier

create table products (
    id uniqueidentifier primary key,
    name nvarchar(max)
);

insert into products values  (newid(), 'produktnamn');
select * from products;