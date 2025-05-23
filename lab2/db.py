from typing import Optional
from sqlalchemy.engine import URL
from sqlalchemy import create_engine, text
from sqlalchemy.exc import ProgrammingError


def get_engine(server: str, username: str, password: str, database_name: Optional[str] = None):
    if database_name:
        connection_string = f"DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database_name};UID={username};PWD={password}"
    else:
        connection_string = f"DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};UID={username};PWD={password}"
    url = URL.create("mssql+pyodbc", query={"odbc_connect": connection_string})
    return create_engine(url)


def server_connection(server_engine, database_name):
    try:
        with server_engine.connect().execution_options(isolation_level="AUTOCOMMIT") as conn:
            conn.execute(text(f"CREATE DATABASE {database_name}"))
    except ProgrammingError as err:
        err_string = str(err)
        if "'bookstore' already exists" in err_string:
            print(f"A database named \"{database_name}\" already exists.")
        else:
            print(err)