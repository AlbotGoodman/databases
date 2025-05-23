from datetime import date
from typing import Optional, List
from sqlalchemy import Integer, BigInteger, Float, String, ForeignKey, Date, CheckConstraint
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship


class Base(DeclarativeBase):
    pass


class Authors(Base):
    __tablename__ = "authors"

    id: Mapped[int] = mapped_column(primary_key=True)
    first_name: Mapped[str] = mapped_column(String(30))
    last_name: Mapped[str] = mapped_column(String(30))
    birth_date: Mapped[Optional[date]] = mapped_column(Date)

    book_authors: Mapped[List["BookAuthors"]] = relationship(back_populates="authors", cascade="all, delete-orphan")  # deleting an author deletes it and related items in the junction table


class Books(Base):
    __tablename__ = "books"
    __table_args__ = (
        CheckConstraint("price > 0", name="check_price_positive"),
        CheckConstraint("isbn between 1000000000000 and 9999999999999", name="check_isbn_length")
    )

    isbn: Mapped[int] = mapped_column(BigInteger, primary_key=True, autoincrement=False)
    title: Mapped[str] = mapped_column(String(100))
    language: Mapped[Optional[str]] = mapped_column(String(30))
    price: Mapped[int] = mapped_column(Integer)
    publication_date: Mapped[Optional[date]] = mapped_column(Date)

    inventory: Mapped[List["Inventory"]] = relationship(back_populates="books", cascade="all, delete-orphan")  # deleting a book deletes its inventory
    book_authors: Mapped[List["BookAuthors"]] = relationship(back_populates="books", cascade="all, delete-orphan")  # deleting a book deletes it and related items in the junction table
    order_details: Mapped["OrderDetails"] = relationship(back_populates="books")
    reviews: Mapped[List["Reviews"]] = relationship(back_populates="books", cascade="all, delete-orphan")  # deleting a book deletes its reviews


class Stores(Base):
    __tablename__ = "stores"

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(50))
    address: Mapped[Optional[str]] = mapped_column(String(100))

    inventory: Mapped[List["Inventory"]] = relationship(back_populates="stores", cascade="all, delete-orphan")  # deleting a store deletes it's inventory


class Inventory(Base):
    __tablename__ = "inventory"

    store_id: Mapped[int] = mapped_column(ForeignKey("stores.id"), primary_key=True)
    isbn: Mapped[int] = mapped_column(BigInteger, ForeignKey("books.isbn"), primary_key=True)
    amount: Mapped[int] = mapped_column(Integer, default=0)

    books: Mapped["Books"] = relationship(back_populates="inventory")
    stores: Mapped["Stores"] = relationship(back_populates="inventory")


class BookAuthors(Base):
    __tablename__ = "book_authors"

    isbn: Mapped[int] = mapped_column(BigInteger, ForeignKey("books.isbn"), primary_key=True)
    author_id: Mapped[int] = mapped_column(ForeignKey("authors.id"), primary_key=True)
    role: Mapped[Optional[str]] = mapped_column(String(20))

    books: Mapped["Books"] = relationship(back_populates="book_authors")
    authors: Mapped["Authors"] = relationship(back_populates="book_authors")


class Customers(Base):
    __tablename__ = "customers"
    __table_args__ = (
        CheckConstraint("email like '%@%.%'", name="check_customers_email_format"),
    )

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    first_name: Mapped[str] = mapped_column(String(30))
    last_name: Mapped[str] = mapped_column(String(30))
    email: Mapped[str] = mapped_column(String(80))
    membership_level: Mapped[str] = mapped_column(String(8))

    orders: Mapped[List["Orders"]] = relationship(back_populates="customers", cascade="all, delete-orphan")  # deleting a customer deletes their orders
    reviews: Mapped[List["Reviews"]] = relationship(back_populates="customers", cascade="all, delete-orphan")  # deleting a customer deletes their reviews


class Orders(Base):
    __tablename__ = "orders"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    customer_id: Mapped[int] = mapped_column(ForeignKey("customers.id"))
    order_date: Mapped[date] = mapped_column(Date)

    customers: Mapped["Customers"] = relationship(back_populates="orders")
    order_details: Mapped[List["OrderDetails"]] = relationship(back_populates="orders", cascade="all, delete-orphan")  # deleting an order deletes its order details


class OrderDetails(Base):
    __tablename__ = "order_details"

    order_id: Mapped[int] = mapped_column(ForeignKey("orders.id"), primary_key=True)
    isbn: Mapped[int] = mapped_column(BigInteger, ForeignKey("books.isbn"), primary_key=True)
    quantity: Mapped[int] = mapped_column(Integer)

    orders: Mapped["Orders"] = relationship(back_populates="order_details")
    books: Mapped["Books"] = relationship(back_populates="order_details")


class Reviews(Base):
    __tablename__ = "reviews"
    __table_args__ = (
        CheckConstraint("rating between 1 and 5", name="check_reviews_rating_value"),
    )

    isbn: Mapped[int] = mapped_column(BigInteger, ForeignKey("books.isbn"), primary_key=True)
    customer_id: Mapped[int] = mapped_column(ForeignKey("customers.id"), primary_key=True)
    rating: Mapped[int] = mapped_column(Integer)

    books: Mapped["Books"] = relationship(back_populates="reviews")
    customers: Mapped["Customers"] = relationship(back_populates="reviews")


class AuthorOverview(Base):
    __tablename__ = "author_overview"
    __table_args__ = {'extend_existing': True}

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(64))
    age: Mapped[str] = mapped_column(String(9))
    titles: Mapped[str] = mapped_column(String(14))
    inventory: Mapped[str] = mapped_column(String(12))


class CustomerOverview(Base):
    __tablename__ = "customer_overview"
    __table_args__ = {'extend_existing': True}

    # id, customer, membership_level, total_orders, total_amount, average_rating
    id: Mapped[int] = mapped_column(primary_key=True)
    customer: Mapped[str] = mapped_column(String(64))
    membership_level: Mapped[str] = mapped_column(String(10))
    total_orders: Mapped[int] = mapped_column(Integer)
    total_amount: Mapped[int] = mapped_column(Integer)
    average_rating: Mapped[float] = mapped_column(Float)