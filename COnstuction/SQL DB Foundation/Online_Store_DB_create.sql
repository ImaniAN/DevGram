-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:42:50.523

-- tables
-- Table: customer
CREATE TABLE customer (
    id int  NOT NULL,
    name varchar(255)  NOT NULL,
    email varchar(255)  NOT NULL,
    password varchar(100)  NOT NULL,
    CONSTRAINT customer_pk PRIMARY KEY (id)
);

-- Table: product
CREATE TABLE product (
    id int  NOT NULL,
    name varchar(255)  NOT NULL,
    CONSTRAINT product_pk PRIMARY KEY (id)
);

-- Table: purchase
CREATE TABLE purchase (
    id int  NOT NULL,
    user_account_id int  NOT NULL,
    CONSTRAINT purchase_pk PRIMARY KEY (id)
);

-- Table: purchase_item
CREATE TABLE purchase_item (
    purchase_id int  NOT NULL,
    product_id int  NOT NULL,
    number_of_items int  NOT NULL,
    total_price money  NOT NULL,
    CONSTRAINT purchase_item_pk PRIMARY KEY (purchase_id,product_id)
);

-- foreign keys
-- Reference: Copy_of_Copy_of_purchase_user_account (table: purchase)
ALTER TABLE purchase ADD CONSTRAINT Copy_of_Copy_of_purchase_user_account
    FOREIGN KEY (user_account_id)
    REFERENCES customer (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: purchase_item_product (table: purchase_item)
ALTER TABLE purchase_item ADD CONSTRAINT purchase_item_product
    FOREIGN KEY (product_id)
    REFERENCES product (id)  
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

-- End of file.

