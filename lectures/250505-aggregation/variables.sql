-- Variabler i SQL m�ste deklareras innan anv�ndning

declare @name nvarchar(max) = 'Fredrik'; -- Tilldela v�rde vid deklaration

set @name = 'Arthur'; -- Tilldela nytt v�rde

select @name;

----------
-- Man kan �ven anv�nda select f�r att tilldela v�rden till flera variabler samtidigt.

declare @firstname nvarchar(max);
declare @lastname nvarchar(max);

select top 1 @firstname = firstname, @lastname = lastname from users where firstname = @name order by FirstName;

select @firstname, @lastname;

-----------

declare @names nvarchar(max) = '';

-- Konkatenera alla v�rden i resultatet till @names.
select @names += firstname from users;

print @names

select @names 

print 'hejsan'
