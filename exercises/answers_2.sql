-- Ta ut (select) en rad f�r varje (unik) period i tabellen �Elements� med
-- f�ljande kolumner: �period�, �from� med l�gsta atomnumret i perioden,
-- �to� med h�gsta atomnumret i perioden, �average isotopes� med
-- genomsnittligt antal isotoper visat med 2 decimaler, �symbols� med en
-- kommaseparerad lista av alla �mnen i perioden. 
-- 

select * from Elements

select
	Period,
	min(Number) as 'from',
	max(Number) as 'to',
	format(avg(convert(float, Stableisotopes)), 'N2') as 'average isotopes', -- formaterar som nummer med 2 decimaler
	string_agg(Symbol,',')
from
	Elements
group by
	Period;

-- SQL har inte // operatorn (floor division), utan g�r den automatisk om b�de n�mnare och t�ljare �r heltal (integers)
select 
	5 / 2, 
	5 % 2,
	5.0 / 2.0


-- F�r varje stad som har 2 eller fler kunder i tabellen Customers, ta ut
-- (select) f�ljande kolumner: �Region�, �Country�, �City�, samt
-- �Customers� som anger hur m�nga kunder som finns i staden. 

select * from company.customers

select
    Region,
    Country,
    City,
    count(*) as 'Number of Customers'
from
    company.customers
group by
    Region,
    Country,
    City
having
    count(*) > 1
order by
	count(*);


-- Skapa en varchar-variabel och skriv en select-sats som s�tter v�rdet: �S�song 1 s�ndes fr�n april till juni 2011. Totalt
-- s�ndes 10 avsnitt, som i genomsnitt s�gs av 2.5 miljoner m�nniskor i USA.�, f�ljt av radbyte/char(13), f�ljt av
-- �S�song 2 s�ndes �� osv. N�r du sedan skriver (print) variabeln till messages ska du allts� f� en rad
-- f�r varje s�song enligt ovan, med data sammanst�llt fr�n tabellen GameOfThrones.
-- Tips: Ange �sv� som tredje parameter i format() f�r svenska m�nader

select * from GameOfThrones

DECLARE @report NVARCHAR(MAX) = '';
 
WITH SeasonSummary AS (
    SELECT
        Season,
        MIN([Original air date]) AS StartDate, -- H�mtar det tidigaste datumet f�r s�songen
        MAX([Original air date]) AS EndDate, -- H�mtar det senaste datumet f�r s�songen
        COUNT(*) AS EpisodeCount,
        CAST(AVG(CAST([U.S. viewers(millions)] AS FLOAT)) AS DECIMAL(10,2)) AS AvgViewers -- Ber�knar genomsnittet och formaterar till tv� decimaler
    FROM
        GameOfThrones
    GROUP BY
        Season
)

SELECT @report = @report +
    'S�song ' + CAST(Season AS VARCHAR) + ' s�ndes fr�n ' +
    FORMAT(StartDate, 'MMMM', 'sv') + ' till ' +
    FORMAT(EndDate, 'Y', 'sv') + '. Totalt s�ndes ' +
    CAST(EpisodeCount AS VARCHAR) + ' avsnitt, som i genomsnitt s�gs av ' +
    CAST(AvgViewers AS VARCHAR) + ' miljoner m�nniskor i USA.' + CHAR(13) + CHAR(10)
FROM
    SeasonSummary
ORDER BY
    Season;
 
PRINT @report;


-- Ta ut (select) alla anv�ndare i tabellen �Users� s� du f�r tre kolumner:
-- �Namn� som har fulla namnet; ��lder� som visar hur m�nga �r personen
-- �r idag (ex. �45 �r�); �K�n� som visar om det �r en man eller kvinna.
-- Sortera raderna efter f�r- och efternamn. 

select
	concat(FirstName, ' ', LastName) as 'Namn',
	id, 
	left(ID, 6),
	convert(date, left(ID, 6)),
	floor((datediff(day, convert(date, left(ID, 6)), getdate())) / 365.25) as '�lder',
	case
		when substring(right(ID,2), 1, 1) % 2 = 0 then 'Kvinna'
		else 'Man'
	end as 'K�n'
from
	Users
order by
	FirstName,
	LastName;


-- Ta ut en lista �ver regioner i tabellen �Countries� d�r det f�r varje region
-- framg�r regionens namn, antal l�nder i regionen, totalt antal inv�nare,
-- total area, befolkningst�theten med 2 decimaler, samt
-- sp�dbarnsd�dligheten per 100.000 f�dslar avrundat till heltal. 

select * from Countries;

SELECT
    [Region],
    count([Country]) as 'Number of Countries',
    SUM(convert(bigint, [Population])) as 'Total Population',
    sum([Area (sq# mi#)]) as 'Total Area',
    sum(convert(bigint, [Population]))/sum([Area (sq# mi#)]) as 'Population Density',
    round(avg(convert(float, replace([Infant mortality (per 1000 births)], ',', '.'))), 2) as 'Average Infant Mortality'
from
    countries
group by
    [Region];



-- Fr�n tabellen �Airports�, gruppera per land och ta ut kolumner som visar:
-- land, antal flygplatser (IATA-koder), antal som saknar ICAO-kod, samt hur
-- m�nga procent av flygplatserna i varje land som saknar ICAO-kod.

select * from Airports


select
--	[Location served],
--	charindex(',', [Location served]),
--	reverse(rtrim([Location served]))+',',
--	charindex(',', reverse(rtrim([Location served]))+',')-1,
	right(rtrim([Location served]), charindex(',', reverse(rtrim([Location served]))+',')-1) as Country,
	count(IATA) as 'number of airports',
	sum(case when ICAO is null then 1 else 0 end) as 'number of ICAO nulls',
	format(sum(case when ICAO is null then 1 else 0 end) / cast(count(IATA) as float), 'p') as 'Percentage of ICAO'
from
	Airports
group by
	right(rtrim([Location served]), charindex(',', reverse(rtrim([Location served]))+',')-1)
