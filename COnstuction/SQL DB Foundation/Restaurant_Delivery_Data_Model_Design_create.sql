-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:04:01.059

-- tables
-- Table: category
CREATE TABLE category (
    id int NOT NULL AUTO_INCREMENT,
    category_name varchar(255) NOT NULL,
    UNIQUE INDEX category_ak_1 (category_name),
    CONSTRAINT category_pk PRIMARY KEY (id)
);

-- Table: city
CREATE TABLE city (
    id int NOT NULL AUTO_INCREMENT,
    city_name varchar(255) NOT NULL,
    zip_code varchar(16) NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
);

-- Table: comment
CREATE TABLE comment (
    id int NOT NULL AUTO_INCREMENT,
    placed_order_id int NOT NULL,
    customer_id int NOT NULL,
    comment_text text NOT NULL,
    ts timestamp NOT NULL,
    is_complaint bool NOT NULL,
    is_praise bool NOT NULL,
    CONSTRAINT comment_pk PRIMARY KEY (id)
) COMMENT 'list of all comments related to orders';

-- Table: customer
CREATE TABLE customer (
    id int NOT NULL AUTO_INCREMENT,
    customer_name varchar(255) NOT NULL,
    city_id int NOT NULL,
    address varchar(255) NOT NULL,
    contact_phone varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    confirmation_code varchar(255) NOT NULL,
    password varchar(255) NOT NULL,
    time_joined timestamp NOT NULL,
    CONSTRAINT customer_pk PRIMARY KEY (id)
);

-- Table: in_offer
CREATE TABLE in_offer (
    id int NOT NULL AUTO_INCREMENT,
    offer_id int NOT NULL,
    menu_item_id int NOT NULL,
    UNIQUE INDEX in_offer_ak_1 (offer_id,menu_item_id),
    CONSTRAINT in_offer_pk PRIMARY KEY (id)
);

-- Table: in_order
CREATE TABLE in_order (
    id int NOT NULL AUTO_INCREMENT,
    placed_order_id int NOT NULL,
    offer_id int NULL,
    menu_item_id int NULL,
    quantity int NOT NULL,
    item_price decimal(12,2) NOT NULL,
    price decimal(12,2) NOT NULL,
    comment text NULL,
    CONSTRAINT in_order_pk PRIMARY KEY (id)
);

-- Table: menu_item
CREATE TABLE menu_item (
    id int NOT NULL AUTO_INCREMENT,
    item_name varchar(255) NOT NULL,
    category_id int NOT NULL,
    description text NOT NULL,
    ingredients text NOT NULL,
    recipe text NOT NULL,
    price decimal(12,2) NOT NULL,
    active bool NOT NULL,
    CONSTRAINT menu_item_pk PRIMARY KEY (id)
);

-- Table: offer
CREATE TABLE offer (
    id int NOT NULL AUTO_INCREMENT,
    date_active_from date NULL,
    time_active_from time NULL,
    date_active_to date NULL,
    time_active_to time NULL,
    offer_price decimal(12,2) NOT NULL,
    CONSTRAINT offer_pk PRIMARY KEY (id)
) COMMENT 'offer that are valid in date range or in intraday time range';

-- Table: order_status
CREATE TABLE order_status (
    id int NOT NULL AUTO_INCREMENT,
    placed_order_id int NOT NULL,
    status_catalog_id int NOT NULL,
    ts timestamp NOT NULL,
    CONSTRAINT order_status_pk PRIMARY KEY (id)
);

-- Table: placed_order
CREATE TABLE placed_order (
    id int NOT NULL,
    restaurant_id int NOT NULL,
    order_time timestamp NOT NULL,
    estimated_delivery_time timestamp NOT NULL,
    food_ready timestamp NULL,
    actual_delivery_time timestamp NULL,
    delivery_address varchar(255) NOT NULL,
    customer_id int NULL,
    price decimal(12,2) NOT NULL,
    discount decimal(12,2) NOT NULL,
    final_price decimal(12,2) NOT NULL,
    comment text NULL,
    ts timestamp NOT NULL,
    CONSTRAINT placed_order_pk PRIMARY KEY (id)
);

-- Table: restaurant
CREATE TABLE restaurant (
    id int NOT NULL AUTO_INCREMENT,
    address varchar(255) NOT NULL,
    city_id int NOT NULL,
    CONSTRAINT restaurant_pk PRIMARY KEY (id)
);

-- Table: status_catalog
CREATE TABLE status_catalog (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(255) NOT NULL,
    UNIQUE INDEX status_catalog_ak_1 (status_name),
    CONSTRAINT status_catalog_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: comment_customer (table: comment)
ALTER TABLE comment ADD CONSTRAINT comment_customer FOREIGN KEY comment_customer (customer_id)
    REFERENCES customer (id);

-- Reference: comment_placed_order (table: comment)
ALTER TABLE comment ADD CONSTRAINT comment_placed_order FOREIGN KEY comment_placed_order (placed_order_id)
    REFERENCES placed_order (id);

-- Reference: customer_city (table: customer)
ALTER TABLE customer ADD CONSTRAINT customer_city FOREIGN KEY customer_city (city_id)
    REFERENCES city (id);

-- Reference: in_offer_menu_item (table: in_offer)
ALTER TABLE in_offer ADD CONSTRAINT in_offer_menu_item FOREIGN KEY in_offer_menu_item (menu_item_id)
    REFERENCES menu_item (id);

-- Reference: in_offer_offer (table: in_offer)
ALTER TABLE in_offer ADD CONSTRAINT in_offer_offer FOREIGN KEY in_offer_offer (offer_id)
    REFERENCES offer (id);

-- Reference: in_order_menu_item (table: in_order)
ALTER TABLE in_order ADD CONSTRAINT in_order_menu_item FOREIGN KEY in_order_menu_item (menu_item_id)
    REFERENCES menu_item (id);

-- Reference: in_order_offer (table: in_order)
ALTER TABLE in_order ADD CONSTRAINT in_order_offer FOREIGN KEY in_order_offer (offer_id)
    REFERENCES offer (id);

-- Reference: in_order_order (table: in_order)
ALTER TABLE in_order ADD CONSTRAINT in_order_order FOREIGN KEY in_order_order (placed_order_id)
    REFERENCES placed_order (id);

-- Reference: menu_item_category (table: menu_item)
ALTER TABLE menu_item ADD CONSTRAINT menu_item_category FOREIGN KEY menu_item_category (category_id)
    REFERENCES category (id);

-- Reference: order_customer (table: placed_order)
ALTER TABLE placed_order ADD CONSTRAINT order_customer FOREIGN KEY order_customer (customer_id)
    REFERENCES customer (id);

-- Reference: order_restaurant (table: placed_order)
ALTER TABLE placed_order ADD CONSTRAINT order_restaurant FOREIGN KEY order_restaurant (restaurant_id)
    REFERENCES restaurant (id);

-- Reference: order_status_order (table: order_status)
ALTER TABLE order_status ADD CONSTRAINT order_status_order FOREIGN KEY order_status_order (placed_order_id)
    REFERENCES placed_order (id);

-- Reference: order_status_status_catalog (table: order_status)
ALTER TABLE order_status ADD CONSTRAINT order_status_status_catalog FOREIGN KEY order_status_status_catalog (status_catalog_id)
    REFERENCES status_catalog (id);

-- Reference: restaurant_city (table: restaurant)
ALTER TABLE restaurant ADD CONSTRAINT restaurant_city FOREIGN KEY restaurant_city (city_id)
    REFERENCES city (id);

-- End of file.

