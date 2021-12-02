-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:34:45.259

-- tables
-- Table: product
CREATE TABLE product (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    price_per_unit decimal(8,2) NOT NULL,
    basic_unit varchar(255) NOT NULL COMMENT 'kg, liters, ....',
    tax_percentage decimal(4,2) NOT NULL,
    limited bool NOT NULL COMMENT 'limited=true -> limited quantity on stock; limited=false -> we ',
    in_stock decimal(8,2) NULL COMMENT 'currently on stock (if limited = yes)',
    active_for_sale bool NOT NULL COMMENT 'service/product can be offered for sales (if it''''s not active, we still may have past sales of that service/product in system but will use this attribute to prevent making new sales)',
    CONSTRAINT product_pk PRIMARY KEY (id)
) COMMENT 'table contains list of products we sell';

-- Table: role
CREATE TABLE role (
    id int NOT NULL AUTO_INCREMENT,
    role_name varchar(100) NOT NULL,
    CONSTRAINT role_pk PRIMARY KEY (id)
);

-- Table: sale
CREATE TABLE sale (
    id int NOT NULL AUTO_INCREMENT,
    time_created timestamp NOT NULL COMMENT 'timestamp when invoice was created',
    time_paid timestamp NULL COMMENT 'timestamp when invoice was paid',
    sale_amount decimal(8,2) NOT NULL COMMENT 'original invoice amount can be sum of service/product value for that invoice',
    sale_amount_paid decimal(8,2) NULL COMMENT 'paid amount can differ from invoice_amount',
    tax_amount decimal(4,2) NOT NULL,
    sale_status_id int NOT NULL,
    user_has_role_id int NOT NULL COMMENT 'user that created invoice',
    CONSTRAINT sale_pk PRIMARY KEY (id)
);

-- Table: sale_item
CREATE TABLE sale_item (
    id int NOT NULL AUTO_INCREMENT,
    quantity_sold decimal(8,2) NOT NULL,
    price_per_unit decimal(8,2) NOT NULL COMMENT 'same as price in product_service at the moment invoice was created',
    price decimal(8,2) NOT NULL COMMENT 'unit_price * quantity_sold (to avoid calculations)',
    tax_amount decimal(8,2) NOT NULL,
    sale_id int NOT NULL,
    product_id int NOT NULL,
    CONSTRAINT sale_item_pk PRIMARY KEY (id)
);

-- Table: sale_status
CREATE TABLE sale_status (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(255) NOT NULL,
    CONSTRAINT sale_status_pk PRIMARY KEY (id)
) COMMENT 'e.g. invoices, paid, canceled';

-- Table: status
CREATE TABLE status (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(100) NOT NULL,
    is_user_working bool NOT NULL,
    CONSTRAINT status_pk PRIMARY KEY (id)
);

-- Table: user_account
CREATE TABLE user_account (
    id int NOT NULL AUTO_INCREMENT,
    user_name varchar(100) NOT NULL,
    email varchar(254) NOT NULL,
    password varchar(200) NOT NULL,
    password_salt varchar(50) NULL,
    password_hash_algorithm varchar(50) NOT NULL,
    CONSTRAINT user_account_pk PRIMARY KEY (id)
);

-- Table: user_has_role
CREATE TABLE user_has_role (
    id int NOT NULL AUTO_INCREMENT,
    role_start_time timestamp NOT NULL,
    role_end_time timestamp NULL,
    user_account_id int NOT NULL,
    role_id int NOT NULL,
    UNIQUE INDEX user_has_role_ak_1 (role_start_time,role_id,user_account_id),
    CONSTRAINT user_has_role_pk PRIMARY KEY (id)
);

-- Table: user_has_status
CREATE TABLE user_has_status (
    id int NOT NULL AUTO_INCREMENT,
    status_start_time timestamp NOT NULL,
    status_end_time timestamp NULL,
    user_account_id int NOT NULL,
    status_id int NOT NULL,
    UNIQUE INDEX user_has_status_ak_1 (status_start_time,user_account_id),
    CONSTRAINT user_has_status_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: invoice_invoice_status (table: sale)
ALTER TABLE sale ADD CONSTRAINT invoice_invoice_status FOREIGN KEY invoice_invoice_status (sale_status_id)
    REFERENCES sale_status (id);

-- Reference: invoice_item_invoice (table: sale_item)
ALTER TABLE sale_item ADD CONSTRAINT invoice_item_invoice FOREIGN KEY invoice_item_invoice (sale_id)
    REFERENCES sale (id);

-- Reference: invoice_item_product_service (table: sale_item)
ALTER TABLE sale_item ADD CONSTRAINT invoice_item_product_service FOREIGN KEY invoice_item_product_service (product_id)
    REFERENCES product (id);

-- Reference: invoice_user_has_role (table: sale)
ALTER TABLE sale ADD CONSTRAINT invoice_user_has_role FOREIGN KEY invoice_user_has_role (user_has_role_id)
    REFERENCES user_has_role (id);

-- Reference: user_has_role_role (table: user_has_role)
ALTER TABLE user_has_role ADD CONSTRAINT user_has_role_role FOREIGN KEY user_has_role_role (role_id)
    REFERENCES role (id);

-- Reference: user_has_role_user_account (table: user_has_role)
ALTER TABLE user_has_role ADD CONSTRAINT user_has_role_user_account FOREIGN KEY user_has_role_user_account (user_account_id)
    REFERENCES user_account (id);

-- Reference: user_has_status_status (table: user_has_status)
ALTER TABLE user_has_status ADD CONSTRAINT user_has_status_status FOREIGN KEY user_has_status_status (status_id)
    REFERENCES status (id);

-- Reference: user_has_status_user_account (table: user_has_status)
ALTER TABLE user_has_status ADD CONSTRAINT user_has_status_user_account FOREIGN KEY user_has_status_user_account (user_account_id)
    REFERENCES user_account (id);

-- End of file.

