-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:42:42.647

-- tables
-- Table: address
CREATE TABLE address (
    id int  NOT NULL,
    address_line_1 varchar(256)  NOT NULL,
    address_line_2 varchar(256)  NULL,
    user_account_id int  NOT NULL,
    CONSTRAINT address_pk PRIMARY KEY (id)
);

-- Table: author
CREATE TABLE author (
    id int  NOT NULL,
    name varchar(200)  NOT NULL,
    CONSTRAINT author_pk PRIMARY KEY (id)
);

-- Table: book
CREATE TABLE book (
    id int  NOT NULL,
    title varchar(100)  NOT NULL,
    description text  NOT NULL,
    price money  NOT NULL,
    category_id int  NOT NULL,
    CONSTRAINT book_pk PRIMARY KEY (id)
);

-- Table: book_author
CREATE TABLE book_author (
    author_id int  NOT NULL,
    book_id int  NOT NULL,
    CONSTRAINT book_author_pk PRIMARY KEY (author_id,book_id)
);

-- Table: category
CREATE TABLE category (
    id int  NOT NULL,
    code varchar(20)  NOT NULL,
    name varchar(100)  NOT NULL,
    CONSTRAINT category_ak_1 UNIQUE (code) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT category_pk PRIMARY KEY (id)
);

-- Table: purchase
CREATE TABLE purchase (
    id int  NOT NULL,
    purchase_date timestamp  NOT NULL,
    user_account_id int  NOT NULL,
    delivery_address_id int  NOT NULL,
    total_price money  NOT NULL,
    CONSTRAINT purchase_pk PRIMARY KEY (id)
);

-- Table: purchase_item
CREATE TABLE purchase_item (
    book_id int  NOT NULL,
    purchase_id int  NOT NULL,
    quantity int  NOT NULL,
    items_price money  NOT NULL,
    CONSTRAINT purchase_item_pk PRIMARY KEY (book_id,purchase_id)
);

-- Table: purchase_status
CREATE TABLE purchase_status (
    id int  NOT NULL,
    code varchar(20)  NOT NULL,
    name varchar(100)  NOT NULL,
    CONSTRAINT purchase_status_ak_1 UNIQUE (code) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT purchase_status_pk PRIMARY KEY (id)
);

-- Table: purchase_status_history
CREATE TABLE purchase_status_history (
    id int  NOT NULL,
    purchase_id int  NOT NULL,
    purchase_status_id int  NOT NULL,
    change_date timestamp  NOT NULL,
    CONSTRAINT purchase_status_history_pk PRIMARY KEY (id)
);

-- Table: user_account
CREATE TABLE user_account (
    id int  NOT NULL,
    user_name varchar(100)  NOT NULL,
    email varchar(254)  NOT NULL,
    password varchar(200)  NOT NULL,
    password_salt varchar(50)  NULL,
    password_hash_algorithm varchar(50)  NOT NULL,
    CONSTRAINT AK_USER_ACCOUNT_LOGIN_USER_ACC UNIQUE (email) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT AK_USER_ACCOUNT_LOGIN_UNIQUE UNIQUE (user_name) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT user_account_pk PRIMARY KEY (id)
);

CREATE INDEX adm_dashboard_recent_users_idx on user_account (id DESC);

-- foreign keys
-- Reference: address_user_account (table: address)
ALTER TABLE address ADD CONSTRAINT address_user_account
    FOREIGN KEY (user_account_id)
    REFERENCES user_account (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: book_author_author (table: book_author)
ALTER TABLE book_author ADD CONSTRAINT book_author_author
    FOREIGN KEY (author_id)
    REFERENCES author (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: book_author_book (table: book_author)
ALTER TABLE book_author ADD CONSTRAINT book_author_book
    FOREIGN KEY (book_id)
    REFERENCES book (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: book_category (table: book)
ALTER TABLE book ADD CONSTRAINT book_category
    FOREIGN KEY (category_id)
    REFERENCES category (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: purchase_address (table: purchase)
ALTER TABLE purchase ADD CONSTRAINT purchase_address
    FOREIGN KEY (delivery_address_id)
    REFERENCES address (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: purchase_item_book (table: purchase_item)
ALTER TABLE purchase_item ADD CONSTRAINT purchase_item_book
    FOREIGN KEY (book_id)
    REFERENCES book (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: purchase_item_purchase (table: purchase_item)
ALTER TABLE purchase_item ADD CONSTRAINT purchase_item_purchase
    FOREIGN KEY (purchase_id)
    REFERENCES purchase (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: purchase_status_history_purchase (table: purchase_status_history)
ALTER TABLE purchase_status_history ADD CONSTRAINT purchase_status_history_purchase
    FOREIGN KEY (purchase_id)
    REFERENCES purchase (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: purchase_status_history_purchase_status (table: purchase_status_history)
ALTER TABLE purchase_status_history ADD CONSTRAINT purchase_status_history_purchase_status
    FOREIGN KEY (purchase_status_id)
    REFERENCES purchase_status (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: purchase_user_account (table: purchase)
ALTER TABLE purchase ADD CONSTRAINT purchase_user_account
    FOREIGN KEY (user_account_id)
    REFERENCES user_account (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

