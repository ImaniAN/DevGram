-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:52:59.16

-- tables
-- Table: author
CREATE TABLE author (
    id int NOT NULL AUTO_INCREMENT,
    author_name varchar(255) NOT NULL,
    author_surname varchar(255) NOT NULL,
    date_birth date NULL,
    date_death date NULL,
    CONSTRAINT author_pk PRIMARY KEY (id)
);

-- Table: autorship_role
CREATE TABLE autorship_role (
    id int NOT NULL AUTO_INCREMENT,
    role_name varchar(255) NOT NULL,
    UNIQUE INDEX autorship_role_ak_1 (role_name),
    CONSTRAINT autorship_role_pk PRIMARY KEY (id)
);

-- Table: book
CREATE TABLE book (
    isbn int NOT NULL AUTO_INCREMENT,
    book_title varchar(255) NOT NULL,
    literature_category_id int NOT NULL,
    publishing_house_id int NOT NULL,
    year_published date NOT NULL,
    UNIQUE INDEX book_ak_1 (book_title),
    CONSTRAINT book_pk PRIMARY KEY (isbn)
);

-- Table: book_authorship
CREATE TABLE book_authorship (
    book_id int NOT NULL AUTO_INCREMENT,
    author_id int NOT NULL,
    autorship_role_id int NOT NULL,
    CONSTRAINT book_authorship_pk PRIMARY KEY (book_id,author_id,autorship_role_id)
);

-- Table: book_item
CREATE TABLE book_item (
    id int NOT NULL AUTO_INCREMENT,
    isbn int NOT NULL,
    library_id int NOT NULL,
    CONSTRAINT book_item_pk PRIMARY KEY (id)
);

-- Table: city
CREATE TABLE city (
    id int NOT NULL AUTO_INCREMENT,
    postal_code varchar(255) NOT NULL,
    city_name varchar(255) NOT NULL,
    country_id int NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
);

-- Table: country
CREATE TABLE country (
    id int NOT NULL AUTO_INCREMENT,
    country_name varchar(255) NOT NULL,
    UNIQUE INDEX country_ak_1 (country_name),
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: library
CREATE TABLE library (
    id int NOT NULL AUTO_INCREMENT,
    library_name varchar(255) NOT NULL,
    address varchar(255) NOT NULL,
    city_id int NOT NULL,
    UNIQUE INDEX library_ak_1 (library_name,city_id),
    CONSTRAINT library_pk PRIMARY KEY (id)
);

-- Table: literature_category
CREATE TABLE literature_category (
    id int NOT NULL AUTO_INCREMENT,
    category_name varchar(255) NOT NULL,
    UNIQUE INDEX literature_category_ak_1 (category_name),
    CONSTRAINT literature_category_pk PRIMARY KEY (id)
);

-- Table: loan_status
CREATE TABLE loan_status (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(255) NOT NULL,
    UNIQUE INDEX borrowing_status_ak_1 (status_name),
    CONSTRAINT loan_status_pk PRIMARY KEY (id)
);

-- Table: loaned_book
CREATE TABLE loaned_book (
    id int NOT NULL AUTO_INCREMENT,
    book_item_id int NOT NULL,
    member_id int NOT NULL,
    date_loaned timestamp NOT NULL,
    date_due timestamp NOT NULL,
    date_returned timestamp NULL,
    overdue_fine decimal(10,2) NULL,
    loan_status_id int NOT NULL,
    ts timestamp NOT NULL,
    CONSTRAINT loaned_book_pk PRIMARY KEY (id)
);

-- Table: member
CREATE TABLE member (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    surname varchar(255) NOT NULL,
    address varchar(255) NOT NULL,
    city_id int NOT NULL,
    email_address varchar(255) NOT NULL,
    phone_number varchar(255) NOT NULL,
    CONSTRAINT member_pk PRIMARY KEY (id)
);

-- Table: publishing_house
CREATE TABLE publishing_house (
    id int NOT NULL AUTO_INCREMENT,
    publishing_house_name varchar(255) NOT NULL,
    city_id int NOT NULL,
    UNIQUE INDEX publishing_house_ak_1 (publishing_house_name,city_id),
    CONSTRAINT publishing_house_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: book_authorship_author (table: book_authorship)
ALTER TABLE book_authorship ADD CONSTRAINT book_authorship_author FOREIGN KEY book_authorship_author (author_id)
    REFERENCES author (id);

-- Reference: book_authorship_autorship_role (table: book_authorship)
ALTER TABLE book_authorship ADD CONSTRAINT book_authorship_autorship_role FOREIGN KEY book_authorship_autorship_role (autorship_role_id)
    REFERENCES autorship_role (id);

-- Reference: book_authorship_book (table: book_authorship)
ALTER TABLE book_authorship ADD CONSTRAINT book_authorship_book FOREIGN KEY book_authorship_book (book_id)
    REFERENCES book (isbn);

-- Reference: book_item_book (table: book_item)
ALTER TABLE book_item ADD CONSTRAINT book_item_book FOREIGN KEY book_item_book (isbn)
    REFERENCES book (isbn);

-- Reference: book_item_library (table: book_item)
ALTER TABLE book_item ADD CONSTRAINT book_item_library FOREIGN KEY book_item_library (library_id)
    REFERENCES library (id);

-- Reference: book_literature_category (table: book)
ALTER TABLE book ADD CONSTRAINT book_literature_category FOREIGN KEY book_literature_category (literature_category_id)
    REFERENCES literature_category (id);

-- Reference: book_publishing_house (table: book)
ALTER TABLE book ADD CONSTRAINT book_publishing_house FOREIGN KEY book_publishing_house (publishing_house_id)
    REFERENCES publishing_house (id);

-- Reference: borrowed_book_borrowing_status (table: loaned_book)
ALTER TABLE loaned_book ADD CONSTRAINT borrowed_book_borrowing_status FOREIGN KEY borrowed_book_borrowing_status (loan_status_id)
    REFERENCES loan_status (id);

-- Reference: borrowed_book_member (table: loaned_book)
ALTER TABLE loaned_book ADD CONSTRAINT borrowed_book_member FOREIGN KEY borrowed_book_member (member_id)
    REFERENCES member (id);

-- Reference: borrowed_books_book_item (table: loaned_book)
ALTER TABLE loaned_book ADD CONSTRAINT borrowed_books_book_item FOREIGN KEY borrowed_books_book_item (book_item_id)
    REFERENCES book_item (id);

-- Reference: city_country (table: city)
ALTER TABLE city ADD CONSTRAINT city_country FOREIGN KEY city_country (country_id)
    REFERENCES country (id);

-- Reference: library_city (table: library)
ALTER TABLE library ADD CONSTRAINT library_city FOREIGN KEY library_city (city_id)
    REFERENCES city (id);

-- Reference: members_city (table: member)
ALTER TABLE member ADD CONSTRAINT members_city FOREIGN KEY members_city (city_id)
    REFERENCES city (id);

-- Reference: publishing_house_city (table: publishing_house)
ALTER TABLE publishing_house ADD CONSTRAINT publishing_house_city FOREIGN KEY publishing_house_city (city_id)
    REFERENCES city (id);

-- End of file.

