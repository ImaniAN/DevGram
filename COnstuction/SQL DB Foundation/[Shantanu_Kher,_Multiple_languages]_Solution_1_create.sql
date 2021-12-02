-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:29:43.383

-- tables
-- Table: customer
CREATE TABLE customer (
    id number  NOT NULL,
    name_EN varchar2(100)  NOT NULL,
    name_FR varchar2(100)  NULL,
    name_DE varchar2(100)  NULL,
    date_of_birth date  NOT NULL,
    address_EN varchar2(100)  NOT NULL,
    address_FR varchar2(100)  NULL,
    address_DE varchar2(100)  NULL,
    contact_number number  NOT NULL,
    CONSTRAINT customer_pk PRIMARY KEY (id)
) ;

-- Table: order_line
CREATE TABLE order_line (
    id number  NOT NULL,
    customer_id number  NOT NULL,
    product_id number  NOT NULL,
    create_date date  NOT NULL,
    expected_delivery_date date  NOT NULL,
    CONSTRAINT order_line_pk PRIMARY KEY (id)
) ;

-- Table: product
CREATE TABLE product (
    id number  NOT NULL,
    product_name_EN varchar2(100)  NOT NULL,
    product_name_FR varchar2(100)  NULL,
    product_name_DE varchar2(100)  NULL,
    description_EN varchar2(500)  NOT NULL,
    description_FR varchar2(500)  NULL,
    description_DE varchar2(500)  NULL,
    price number  NOT NULL,
    CONSTRAINT product_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: order_line_customer (table: order_line)
ALTER TABLE order_line ADD CONSTRAINT order_line_customer
    FOREIGN KEY (customer_id)
    REFERENCES customer (id);

-- Reference: order_line_product (table: order_line)
ALTER TABLE order_line ADD CONSTRAINT order_line_product
    FOREIGN KEY (product_id)
    REFERENCES product (id);

-- End of file.

