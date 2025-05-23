select 
    a.id,
    concat(a.first_name, ' ', a.last_name) as name,
    cast(datediff(year, a.birth_date, cast(getdate() AS date)) as nvarchar(max)) + ' years' as age,
    cast(count(distinct b.isbn) as nvarchar(max)) + ' copies' as titles,
    cast(sum(i.amount * b.price) as nvarchar(max)) + ' SEK' as inventory
from 
    authors a 
join
    book_authors ba on a.id = ba.author_id
join
    books b on ba.isbn = b.isbn
join 
    inventory i on b.isbn = i.isbn
group by
    a.id,
    a.first_name,
    a.last_name,
    a.birth_date