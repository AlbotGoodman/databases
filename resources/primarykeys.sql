-- Primary key �r oftast ett l�pnummer som r�knas upp automatisk (identity)
drop table teachers

create table teachers (
	id int primary key identity(100, 5),
	name nvarchar(max),
	birthdate datetime2
)

insert into teachers values('Teacher', getdate());
select * from teachers;

delete from teachers where id between 4 and 7

truncate table teachers

-- Alternativ �r att primarykey ett globalt unikt id (GUID) som i SQL kan genereras med newid() funktionen. 

select newid()

create table products(
	id uniqueidentifier,
	name nvarchar(max)
)

insert into products values(newid(), 'product name');
select * from products;


-- Ett tredje alternativ �r att primarykey �r ett redan unikt v�rde, t.ex ISBN eller personnummer.