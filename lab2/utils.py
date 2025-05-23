import pandas as pd
from sqlalchemy import DDL, select
from models import Books


def read_upload(Base, engine):
    table_names = [table for table in Base.metadata.tables]
    csv_paths = [f"data/{table}.csv" for table in table_names]
    column_names = [[col.name for col in cls.__table__.columns] for cls in Base.__subclasses__()]
    identity_tables = ["authors", "stores", "customers", "orders"]  # these already contain an incrementing id in the CSV files
    views = ["author_overview", "customer_overview"]  # exclusion list for views that are not supposed to be filled with CSV data

    for table, path, cols in zip(table_names, csv_paths, column_names):
        if table in views:
            break
        df = pd.read_csv(path, names=cols, header=0)
        if table in identity_tables and "id" in df.columns:
            df = df.drop(columns=["id"])
        df.to_sql(name=table, con=engine, if_exists="append", index=False)


def search_books(session, search_term):
    result = session.scalars(select(Books).where(Books.title.ilike(f"%{search_term}%"))).all()
    titles = []
    stock = []

    for i in result:
        n_books = 0
        titles.append(i.title)
        for j in i.inventory:
            n_books += j.amount
        stock.append(n_books)
    
    df = pd.DataFrame(columns=["Title", "Inventory"])
    df["Title"] = titles
    df["Inventory"] = stock 

    if len(titles) == 0:
        return "No similar books can be found."
    else:
        return df


author_overview_ddl = DDL("""
    create view author_overview as
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
""")


customer_overview_ddl = DDL("""
    create view customer_overview as
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
""")