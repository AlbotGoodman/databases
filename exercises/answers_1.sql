-- Ta ut data (select) fr�n tabellen GameOfThrones p� s�dant s�tt att ni f�r ut
-- en kolumn �Title� med titeln samt en kolumn �Episode� som visar episoder
-- och s�songer i formatet �S01E01�, �S01E02�, osv.
-- Tips: kolla upp funktionen format() 

select * from GameOfThrones

select 
	title,
	season,
	EpisodeInSeason,
	format(Season, 'S0#') + format(EpisodeInSeason, 'E0#') as 'Episodes',
	concat('S', format(Season, '00'), 'E', format(EpisodeInSeason, '00')) as 'Episodes'
from
	GameOfThrones

-- select format(123.456, '00.00'), format(123.456, '##.##'), format(123.456, '0000.0000'), format(123.456, '####.####')



-- Uppdatera (kopia p�) tabellen user och s�tt username f�r alla anv�ndare s�
-- den blir de 2 f�rsta bokst�verna i f�rnamnet, och de 2 f�rsta i efternamnet
-- (ist�llet f�r 3+3 som det �r i orginalet). Hela anv�ndarnamnet ska vara i sm�
-- bokst�ver. 

-- select * into users2 from users

select 
	firstname,
	lastname,
	concat(left(firstname, 2), left(lastname, 2)),
	lower(concat(left(firstname, 2), left(lastname, 2))),
	lower(left(firstname, 2)),
	concat(lower(left(firstname, 2)), left(lastname, 2))
from 
	users2

update users2 set UserName = lower(concat(left(firstname, 2), left(lastname, 2)))
update users2 set UserName = lower(left(firstname, 2) + left(lastname, 2));
UPDATE Users2 SET UserName = lower(substring (FirstName, 1, 2)) + lower(substring (LastName, 1, 2))


-- Uppdatera (kopia p�) tabellen airports s� att alla null-v�rden i kolumnerna
-- Time och DST byts ut mot �-� 


SELECT * INTO Airports2 FROM Airports
select * from Airports2
 
UPDATE Airports2 SET Time = '-' WHERE Time is NULL;
UPDATE Airports2 SET DST = '-' WHERE DST is NULL;

SELECT * INTO AirportsCopy FROM Airports
select * from AirportsCopy

update AirportsCopy set DST = isnull(DST, '-')
update AirportsCopy set Time = isnull(Time, '-')

update AirportsCopy set Time = coalesce(Time, '-'), DST = coalesce(DST, '-') where Time is null or DST is null;


-- Ta bort de rader fr�n (kopia p�) tabellen Elements d�r �Name� �r n�gon av
-- f�ljande: 'Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium', samt alla
-- rader d�r �Name� b�rjar p� n�gon av bokst�verna d, k, m, o, eller u. 

select * into elements2 from [elements];

select * from elements2

delete from elements2 where name like '[dkmou]%' or name in ('Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selentium');


-- Skapa en ny tabell med alla rader fr�n tabellen Elements. Den nya tabellen
-- ska inneh�lla �Symbol� och �Name� fr�n orginalet, samt en tredje kolumn
-- med v�rdet �Yes� f�r de rader d�r �Name� b�rjar med bokst�verna i
-- �Symbol�, och �No� f�r de rader d�r de inte g�r det.
-- Ex: �He� -> �Helium� -> �Yes�, �Mg� -> �Magnesium� -> �No�. 

drop table elements3

select 
	symbol,
	[name],
	len(symbol),
	case 
		when left(name, len(symbol)) = symbol then 'Yes'
		--when left(name, 2) = symbol then 'Yes' 
		else 'No' 
	end as 'first letter match',
	concat(Symbol, '%'),
	case
		when Name like concat(Symbol, '%') then 'Yes'
		else 'No'
	end as 'first letter match'
-- into elements3
from
	[Elements];

select * from elements3


-- Kopiera tabellen Colors till Colors2, men skippa kolumnen �Code�. G�r
-- sedan en select fr�n Colors2 som ger samma resultat som du skulle f�tt fr�n
-- select * from Colors; (Dvs, �terskapa den saknade kolumnen fr�n RGBv�rdena i resultatet). 

drop table colors2

select 
	[name], red, green, blue
into colors2
from 
	colors


select 
	*, 
	'#' + format(red, 'X2') + format(green, 'X2') + format(blue, 'X2') as 'code'
from 
colors

alter table colors2
add code as '#' + format(red, 'X2') + format(green, 'X2') + format(blue, 'X2');

select format(255, 'x4');



-- Kopiera kolumnerna �Integer� och �String� fr�n tabellen �Types� till en ny
-- tabell. G�r sedan en select fr�n den nya tabellen som ger samma resultat
-- som du skulle f�tt fr�n select * from types; 

select 
	*,
	Integer * 0.01,
	dateadd(minute, integer, dateadd(day, Integer, '2018-12-31 09:00')),
	Integer % 2

from 
	Types