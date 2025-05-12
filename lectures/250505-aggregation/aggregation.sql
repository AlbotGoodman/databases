
select 
	count(*) as 'Antal rader', 
	count(Meltingpoint) as 'Antal v�rden i Meltingpoint', 
	count(Boilingpoint) as 'Antal v�rden i Boilingpoint',
	count(*) - count(Meltingpoint) as 'Antal nullv�rden i Meltingpoint',
	count(*) - count(Boilingpoint) as 'Antal nullv�rden i Boilingpoint'
from 
	Elements
where
	Number <= 20

-- select count(*) from Elements where Meltingpoint is null

select * from Elements;

select
	[Group],
	sum(Mass) as 'Total massa',
	min(Meltingpoint) as 'Minsta sm�ltpunkt',
	max(Meltingpoint) as 'H�gsta sm�ltpunkt',
	avg(Meltingpoint) as 'Genomsnittlig sm�ltpunkt',
	count(Meltingpoint) as 'Antal v�rden meltingpoint',
	sum(Meltingpoint) / count(Meltingpoint),
	string_agg(Symbol, ', ') as 'Symbols'
from
	Elements
group by
	[Group];


select * from company.orders where OrderDate < '2013-01-01' order by ShipCountry;

-- Uppgift 1
-- Skriv en query som ger en kolumn med alla olika l�nder, samt en kolumn med antalet ordrar till vardera land, sortera p� antal ordrar.
select 
	ShipCountry, 
	count(*) as 'Amount of orders' 
from 
	company.orders 
group by 
	ShipCountry 
order by
	'Amount of orders'

-- Uppgift 2
-- Skriv en query som listar de olika regionerna, samt tv� kolumner som visar f�rsta, respektive senaste order som lagts i varje region.
select
	ShipRegion,
	min(OrderDate) as 'First Order',
	max(OrderDate) as 'Last Order'
from
	company.orders
group by
	ShipRegion

select * from company.orders order by ShipRegion, OrderDate;

select 
	ShipRegion, 
	ShipCountry, 
	ShipCity, 
	count(*) as 'Number of orders' 
from 
	company.orders 
group by 
	ShipRegion, 
	ShipCountry, 
	ShipCity






select 
	ShipCountry, 
	count(*) as 'Amount of orders' 
from 
	company.orders 
where 
	OrderDate < '2013-01-01'
group by 
	ShipCountry 
having
	count(*) between 10 and 20
order by
	'Amount of orders' desc