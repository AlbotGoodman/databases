import pandas as pd


def read_upload(Base, engine):
    table_names = [table for table in Base.metadata.tables]
    csv_paths = [f"data/{table}.csv" for table in table_names]
    column_names = [[col.name for col in cls.__table__.columns] for cls in Base.__subclasses__()]
    identity_tables = ["authors", "stores", "customers", "orders"]
    views = ["author_overview", "customer_overview"]

    for table, path, cols in zip(table_names, csv_paths, column_names):
        if table in views:
            break
        df = pd.read_csv(path, names=cols, header=0)
        if table in identity_tables and "id" in df.columns:
            df = df.drop(columns=["id"])
        df.to_sql(name=table, con=engine, if_exists="append", index=False)