-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:53:03.473

-- tables
-- Table: artist
CREATE TABLE artist (
    id int NOT NULL AUTO_INCREMENT,
    artist_name varchar(255) NOT NULL,
    genre_id int NOT NULL,
    CONSTRAINT artist_pk PRIMARY KEY (id)
);

-- Table: concert
CREATE TABLE concert (
    id int NOT NULL AUTO_INCREMENT,
    concert_name varchar(255) NOT NULL,
    artist_id int NOT NULL,
    date timestamp NOT NULL,
    venue_id int NOT NULL,
    concert_group_id int NULL,
    UNIQUE INDEX concert_ak_1 (concert_name,date),
    CONSTRAINT concert_pk PRIMARY KEY (id)
);

-- Table: concert_group
CREATE TABLE concert_group (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    UNIQUE INDEX concert_group_ak_1 (name),
    CONSTRAINT concert_group_pk PRIMARY KEY (id)
);

-- Table: concert_role
CREATE TABLE concert_role (
    concert_id int NOT NULL,
    artist_id int NOT NULL,
    role_id int NOT NULL,
    UNIQUE INDEX concert_role_ak_1 (artist_id,role_id),
    CONSTRAINT concert_role_pk PRIMARY KEY (concert_id,artist_id,role_id)
);

-- Table: customer
CREATE TABLE customer (
    id int NOT NULL AUTO_INCREMENT,
    customer_name varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    user_name varchar(255) NOT NULL,
    password varchar(255) NOT NULL,
    confirmation_code text NOT NULL,
    confirmation_time timestamp NULL,
    UNIQUE INDEX customer_ak_1 (user_name),
    UNIQUE INDEX customer_ak_2 (email),
    CONSTRAINT customer_pk PRIMARY KEY (id)
) COMMENT 'hash value of password';

-- Table: customer_order
CREATE TABLE customer_order (
    id int NOT NULL AUTO_INCREMENT,
    customer_id int NOT NULL,
    order_time timestamp NOT NULL,
    delivery_address varchar(255) NULL,
    delivery_email_address varchar(255) NOT NULL,
    preferred_delivery_time timestamp NULL,
    time_paid timestamp NOT NULL,
    time_sent timestamp NULL,
    total_price decimal(10,2) NOT NULL,
    discount decimal(10,2) NOT NULL,
    final_price decimal(10,2) NOT NULL,
    CONSTRAINT customer_order_pk PRIMARY KEY (id)
);

-- Table: genre
CREATE TABLE genre (
    id int NOT NULL AUTO_INCREMENT,
    genre_name varchar(255) NOT NULL,
    UNIQUE INDEX genre_ak_1 (genre_name),
    CONSTRAINT genre_pk PRIMARY KEY (id)
);

-- Table: order_ticket
CREATE TABLE order_ticket (
    id int NOT NULL AUTO_INCREMENT,
    customer_order_id int NOT NULL,
    ticket_id int NOT NULL,
    UNIQUE INDEX order_ticket_ak_1 (customer_order_id,ticket_id),
    CONSTRAINT order_ticket_pk PRIMARY KEY (id)
);

-- Table: role
CREATE TABLE role (
    id int NOT NULL AUTO_INCREMENT,
    role_name varchar(255) NOT NULL,
    UNIQUE INDEX role_ak_1 (role_name),
    CONSTRAINT role_pk PRIMARY KEY (id)
) COMMENT 'contains list of possible artist roles (i.e. main act, supporting act, special guest, etc.)';

-- Table: ticket
CREATE TABLE ticket (
    id int NOT NULL AUTO_INCREMENT,
    serial_number varchar(255) NOT NULL,
    concert_id int NOT NULL,
    ticket_category_id int NOT NULL,
    seat varchar(255) NULL,
    purchase_date timestamp NOT NULL,
    UNIQUE INDEX ticket_ak_1 (serial_number),
    CONSTRAINT ticket_pk PRIMARY KEY (id)
);

-- Table: ticket_category
CREATE TABLE ticket_category (
    id int NOT NULL AUTO_INCREMENT,
    description varchar(255) NOT NULL,
    price decimal(10,2) NOT NULL,
    start_date timestamp NULL,
    end_date timestamp NULL,
    area varchar(255) NULL,
    concert_id int NOT NULL,
    CONSTRAINT ticket_category_pk PRIMARY KEY (id)
);

-- Table: venue
CREATE TABLE venue (
    id int NOT NULL AUTO_INCREMENT,
    venue_name varchar(255) NOT NULL,
    location varchar(255) NOT NULL,
    type varchar(255) NOT NULL,
    capacity int NOT NULL,
    CONSTRAINT venue_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: artist_genre (table: artist)
ALTER TABLE artist ADD CONSTRAINT artist_genre FOREIGN KEY artist_genre (genre_id)
    REFERENCES genre (id);

-- Reference: concert_artist (table: concert)
ALTER TABLE concert ADD CONSTRAINT concert_artist FOREIGN KEY concert_artist (artist_id)
    REFERENCES artist (id);

-- Reference: concert_concert_group (table: concert)
ALTER TABLE concert ADD CONSTRAINT concert_concert_group FOREIGN KEY concert_concert_group (concert_group_id)
    REFERENCES concert_group (id);

-- Reference: concert_role_artist (table: concert_role)
ALTER TABLE concert_role ADD CONSTRAINT concert_role_artist FOREIGN KEY concert_role_artist (artist_id)
    REFERENCES artist (id);

-- Reference: concert_role_concert (table: concert_role)
ALTER TABLE concert_role ADD CONSTRAINT concert_role_concert FOREIGN KEY concert_role_concert (concert_id)
    REFERENCES concert (id);

-- Reference: concert_role_role (table: concert_role)
ALTER TABLE concert_role ADD CONSTRAINT concert_role_role FOREIGN KEY concert_role_role (role_id)
    REFERENCES role (id);

-- Reference: concert_venue (table: concert)
ALTER TABLE concert ADD CONSTRAINT concert_venue FOREIGN KEY concert_venue (venue_id)
    REFERENCES venue (id);

-- Reference: customer_order_customer (table: customer_order)
ALTER TABLE customer_order ADD CONSTRAINT customer_order_customer FOREIGN KEY customer_order_customer (customer_id)
    REFERENCES customer (id);

-- Reference: order_ticket_customer_order (table: order_ticket)
ALTER TABLE order_ticket ADD CONSTRAINT order_ticket_customer_order FOREIGN KEY order_ticket_customer_order (customer_order_id)
    REFERENCES customer_order (id);

-- Reference: order_ticket_ticket (table: order_ticket)
ALTER TABLE order_ticket ADD CONSTRAINT order_ticket_ticket FOREIGN KEY order_ticket_ticket (ticket_id)
    REFERENCES ticket (id);

-- Reference: ticket_category_concert (table: ticket_category)
ALTER TABLE ticket_category ADD CONSTRAINT ticket_category_concert FOREIGN KEY ticket_category_concert (concert_id)
    REFERENCES concert (id);

-- Reference: ticket_concert (table: ticket)
ALTER TABLE ticket ADD CONSTRAINT ticket_concert FOREIGN KEY ticket_concert (concert_id)
    REFERENCES concert (id);

-- Reference: ticket_ticket_category (table: ticket)
ALTER TABLE ticket ADD CONSTRAINT ticket_ticket_category FOREIGN KEY ticket_ticket_category (ticket_category_id)
    REFERENCES ticket_category (id);

-- End of file.

