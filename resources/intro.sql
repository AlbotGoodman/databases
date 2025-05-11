-- select * from [Server Name].[Database name].[Schema name].[Table name]

-- radkommentar

/*
	blockkommentar
*/

-- select column names from table name

select FirstName as 'F�rnamn', LastName, ID, FirstName, 'Fredrik' as 'Fredrik', FirstName + ' ' + LastName as 'Fullname' from users;

select 5 + 3 as '�tta', 4-2 as 'Tv�', 'Fredrik' + 'Johansson';
--       [ projection ]                [ selection ]
-- select column names from table name where FirstName = 'Frida';

select * from users where FirstName <> 'Frida';


-- Begr�nsa antal rader:
-- T-SQL skiljer sig h�r fr�n ISO-SQL som anv�nder:
-- select * from users limit 5;

-- T-SQL:
select top 5 * from users;			-- "F�rsta" 5 raderna
select top 5 percent * from users;  -- 5 procent av raderna

select * from GameOfThrones;

-- Uppgift 1
-- Ta ut namnet p� f�rsta avsnittet i varje s�song samt en kolumn med antalet tittare med hela siffran (t.ex 2,22 => 2220000)
select [U.S. viewers(millions)] * 1000000 as 'U.S. viewers', Title from GameOfThrones where EpisodeInSeason = 1;

-- Uppgift 2
-- Ta ut alla avsnitt (alla kolumnner) utom de i s�song 2, 5 och 7
select * from GameOfThrones where Season not in (2, 5, 7);

-- Uppgift 3
-- Ta ut "S�song", "Avsnitt" och "Titel" (d.v.s med kolumnnamnen p� svenska) f�r alla avsnitt som har mellan 4 och 5 miljoner tittare.
select Season as 'S�song', Episode as 'Avsnitt', Title as 'Titel' from GameOfThrones where [U.S. viewers(millions)] between 4 and 5;
select Season as 'S�song', Episode as 'Avsnitt', Title as 'Titel' from GameOfThrones where [U.S. viewers(millions)] >= 4 and [U.S. viewers(millions)] <= 5;


-- Pattern matching (LIKE)

-- Anv�nd inte LIKE f�r att matcha exakta v�rden t.ex:
select * from Users where FirstName like 'Frida'; -- anv�nd ist�llet =

-- Uppgift 4
-- Ta ut alla anv�ndare vars f�rnamn b�rjar p� A eller B from tabellen 'users'
select * from users where FirstName like '[ab]%';

-- Uppgift 5
-- Ta ut alla anv�ndare (fr�n 'users') d�r andra bokstaven i f�rnamnet �r en vokal.
select * from users where FirstName like '_[aeiouy���]%';

-- Uppgift 6
-- Ta ut alla anv�ndare (fr�n 'users') d�r efternamnet slutar p� 'son' eller f�rnamnet �r 2 bokst�ver.
select * from users where LastName like '%son' or FirstName like replicate('[a-�]', 5);


-- Order by

-- Filtrering med where anger bara vilka rader man f�r ut, inte ordningen p� dem.
select * from users where FirstName like '[ab]%' order by FirstName;

-- Sortering sker innan top 5 appliceras
select top 5 * from Users order by FirstName desc;

-- Sortering i f�rsta hand p� lastname, andra hand p� firstname. Asc och desc anges per kolumn
select * from Users order by LastName desc, FirstName desc

-- distinct
select distinct Season from GameOfThrones
select distinct [Directed by], [Written by] from GameOfThrones
select distinct [Written by] from GameOfThrones where [Written by] like 'David%'

select
	Episode, 
	Title,
	[U.S. viewers(millions)],
	case
		when [U.S. viewers(millions)] < 3 then 'Few'
		when [U.S. viewers(millions)] < 6 then 'Average'
		else 'Many'
	end as 'Viewers'
from 
	GameOfThrones
where
	Season < 5;