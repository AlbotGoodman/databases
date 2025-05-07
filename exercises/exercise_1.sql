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
*/





-- select 
--     [name],
--     red, 
--     green,
--     blue 
-- into Colors2
-- from colors;


select * from Colors2;

/*

Heres how I would do it in Python:

hex = "#"
dic = {10: "A", 11: "B", 12: "C", 13: "D", 14: "E", 15: "F"}
for i in [red, green, blue]:
    result = i / 16
    integer = int(result)
    decimal = int((result - integer) * 16)
    for j in [integer, decimal]:
        if j < 10:
            hex += str(j)
        else: 
            hex += str(dic[j])

*/