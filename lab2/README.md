# Bookstore Database Management System

A database solution for managing a multi-store bookstore franchise, implemented using SQLAlchemy ORM and Microsoft SQL Server.

## Project Overview

This project implements a normalised database system that handles the core operations of a bookstore. The database consists of the following tables: 
- authors
- books
- inventory
- stores
- customers
- orders
- reviews

The database design follows Third Normal Form (3NF) principles to eliminate redundancy and maintain consistency. All tables include appropriate primary and foreign key relationships with referential integrity constraints to prevent orphaned records.

## Views and Analytics

The system includes two analytical views that provide business insights: 
- author overview
- customer overview

The author overview view aggregates author information with their age calculated from birth dates, title counts, and total inventory value across all stores. The customer overview compiles customer data including order history, total purchase amounts, and average review ratings, helping the bookstore understand customer behavior and value.

## Implementation Features

Data integrity is maintained through check constraints ensuring positive pricing, valid ISBN formats, proper email formatting, and rating bounds. The system uses cascade delete operations to maintain consistency when parent records are removed. All database interactions use parameterized queries through SQLAlchemy to prevent SQL injection attacks.

The Python implementation provides book search functionality with case-insensitive partial matching, returning results with current inventory levels across all stores. Inventory can also be transferred across stores using a stored procedure. 

## Setup and Usage

The system requires Microsoft SQL Server with ODBC Driver 17. Database credentials (needs to be updated for your local server) are configured in **the main notebook**, which handles database creation, table setup, demo data loading, and view creation automatically. For convenience the database is stored as a backup in the data folder. 

The included demo data contains realistic information for 10 authors, 48 books, 4 stores, and 23 customers with complete order and review history.

## Limitations

As of now the notebook handles creation of the database in sequence. Further error handling could make use of 'IF EXISTS', if-else or try-except statements to avoid such issues. Also further constraints could be implemented to make sure the tables are robust and ACID compliant. 