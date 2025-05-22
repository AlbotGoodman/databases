select
    c.id,
    concat(c.first_name, ' ', c.last_name) as customer,
    c.membership_level as membership_level,
    count(distinct o.id) as total_orders,
    coalesce(sum(distinct od.quantity * b.price), 0) as total_amount,
    case 
        when avg(r.rating * 1.0) is null then 'None'
        else format(avg(r.rating * 1.0), 'N2')
    end as average_rating
    -- favourite author
    -- favourite book
from customers c 
left join orders o on c.id = o.customer_id
left join order_details od on o.id = od.order_id
left join books b on od.isbn = b.isbn
left join book_authors ba on b.isbn = ba.isbn
left join authors a on ba.author_id = a.id 
left join reviews r on c.id = r.customer_id
group by 
    c.id,
    c.first_name,
    c.last_name,
    c.membership_level
order by total_amount desc