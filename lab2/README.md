# Bookstore Database Management System

A database solution for managing a multi-store bookstore chain, implemented using SQLAlchemy ORM and Microsoft SQL Server.

## Project Overview

This project implements a normalized database system that handles the core operations of a bookstore. The database consists of the following tables: 
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

The Python implementation provides book search functionality with case-insensitive partial matching, returning results with current inventory levels across all stores.

## Setup and Usage

The system requires Microsoft SQL Server with ODBC Driver 17. Database credentials are configured in the main notebook (needs to be changed for your local server), which handles database creation, table setup, demo data loading, and view creation automatically. The included demo data contains realistic information for 10 authors, 48 books, 4 stores, and 23 customers with complete order and review history.

Users can search for books through the provided search function and access analytical data through pandas DataFrames connected to the database views. The implementation demonstrates proper ORM usage with SQLAlchemy while maintaining the flexibility to execute raw SQL when needed for complex analytical queries or further calculations with pandas. 