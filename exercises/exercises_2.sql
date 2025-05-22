-- a)

select
    period,
     min(number) as "from",
     max(number) as "to",
     format(avg(stableisotopes * 1.0), '.00') as average_isotopes,
     string_agg(symbol, ', ') as symbols
from elements 
group by period


-- b)

select 
    region,
    country,
    city,
    count(CompanyName) as customers
from company.customers
group by 
    region,
    country,
    city
having count(CompanyName) > 1


-- c)

declare @message as nvarchar(max);
declare @counter as int = 1;
while @counter < 9
begin 
    set @message = 
        'Säsong ' + 
        (select top 1 cast(season as nvarchar) + 
        ' sändes från ' + 
        format(min([Original air date]), 'MMMM', 'sv') + 
        ' till ' + 
        format(max([Original air date]), 'MMMM', 'sv') + 
        ' ' +
        format(min([Original air date]), 'yyyy') +
        '. Totalt sändes ' + 
        cast(count(episode) as nvarchar) + 
        ' avsnitt, som i genomsnitt sågs av ' +
        cast(format(avg([U.S. viewers(millions)]), '.00') as nvarchar) +
        ' miljoner människor i USA.' + 
        char(13)
        from GameOfThrones 
        where season = @counter
        group by season);
    set @counter = @counter + 1;
    print @message;
end


-- d

select 
    concat(firstname, ' ', lastname) as 'name',
    cast(
        datediff(year, 
        cast('19' + left([id], 2) + '-' + substring([id], 3, 2) + '-' + substring([id], 5, 2) as date), 
        cast(getdate() as date)) as nvarchar(max)
    ) + ' years' as age,
    CASE 
        WHEN CAST(SUBSTRING(ID, 10, 1) AS INT) % 2 = 0 THEN 'female'
        ELSE 'male'
    END AS gender
from users
order by 
    FirstName,
    LastName