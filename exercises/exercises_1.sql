-- a)

/*
SELECT
    CONCAT(
        'S',
        FORMAT(Season, '00'),
        'E',
        FORMAT(EpisodeInSeason, '00')
    ) AS Episode,
    Title
FROM
    GameOfThrones
*/


-- b)

/*
select * into Users2 from users;
UPDATE
    users2
SET
    username = concat(
        lower(left(translate(firstname, 'åäö', 'aao'), 2)),
        lower(left(translate(lastname, 'åäö', 'aao'), 2))
    );
GO
select top 10 * from users2;
*/



-- c)

/*
select * into Airports2 from airports;
UPDATE 
    Airports2
SET
    [Time] = ISNULL([Time], '-'),
    DST = ISNULL(DST, '-');
select count(*) as 'total' from airports2 where [time] is null and dst is null;
*/


-- d)

/*
select * into Elements2 from [Elements];
delete from Elements2
where [Name] in ('erbium', 'helium', 'nitrogen', 'platinum', 'selenium')
    or [Name] like '[dkmou]%'
select count(*) as 'total' from elements2;
*/


-- e)

/*
select 
    symbol, 
    [name], 
    case 
        when [name] like symbol + '%' then 'Yes'
        else 'No'
    end as "Name starts with symbol" 
into Elements3
from [elements];
select * from elements3;
*/


-- f)

/*
alter table colors2
add code as '#' + format(red, 'X2') + format(green, 'X2') + format(blue, 'X2')
select * from Colors2; 
*/


-- g)

/*
select [integer], [string] into Types2 from types;
select 
    [integer],
    cast(concat('0.', format([integer], '00')) as float) as [float],
    [string],
    concat('2019-01-', format([integer], '00'), ' 09:', format([integer], '00'), ':00.0000000') as [datatime]
    [integer] % 2 as [bool]
from types2;
select * from Types2;
*/

