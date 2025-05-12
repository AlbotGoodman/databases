-- KÖRDA KOMMANDON

/*
select top 10 * from users;
select top 10 FirstName as "Förnamn", LastName as "Efternamn", ID from users;
select top 10 'Fredrik' as 'Fredrik', FirstName as "Förnamn", LastName as "Efternamn", FirstName + ' ' + LastName as 'Namn', ID from users;
select * from users where FirstName <> 'Frida'; -- <> betyder "skiljt från" (is not?)
select top 5 percent * from users;
select * from users where firstname like '[ab]%' order by firstname; -- [ab] betyder alla namn som börjar med a eller b
select * from users order by firstname asc, lastname asc; -- sortera i stigande ordning
select distinct season from gameofthrones; -- distinct = unika värden
select distinct [directed by], season from gameofthrones; -- by är ett reserverat ord i SQL, så vi måste sätta det inom hakparenteser
select distinct [written by], season, episode from gameofthrones order by season asc, episode asc;
select * from gameofthrones where [written by] = 'George R. R. Martin';

select
    season,
    episode,
    title,
    [u.s. viewers(millions)],
    case 
        when [u.s. viewers(millions)] < 3 then 'few'
        when [u.s. viewers(millions)] < 6 then 'average'
        else 'many'
    end as 'Viewers'
from 
    GameOfThrones
where 
    season < 5;

select len(firstname) as 'length', firstname from users;
*/

-- NYA KOMMANDON






