-- Tempor�ra tabeller lagras i system databasen 'tempdb'
select Id, FirstName + ' ' + LastName as 'Name' into #newusers from users where firstname like 'a%';
select * from #newusers;

-- Globala tempor�ra tabeller g�r att komma �t av andra �n den session som skapat dem.
select Id, FirstName + ' ' + LastName as 'Name' into ##globalnewusers from users where firstname like 'b%';
select * from ##globalnewusers;

-----------------
-- Tabell-variabler

DECLARE @people as TABLE
(
	name nvarchar(max),
	age int
);

insert into @people values('Fredrik', 30);
insert into @people values('Thomas', 23);
insert into @people values('Anders', 33);


select * from @people