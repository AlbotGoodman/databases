use master;
alter database "bookstore" set single_user with rollback immediate;
drop database "bookstore";