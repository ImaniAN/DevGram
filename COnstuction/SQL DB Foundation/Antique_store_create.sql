-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:07:26.126

-- tables
-- Table: author
CREATE TABLE author (
    id int NOT NULL AUTO_INCREMENT,
    author_name varchar(64) NOT NULL,
    author_details text NULL,
    CONSTRAINT author_pk PRIMARY KEY (id)
) COMMENT 'author, artist, producer - list of persons and companies that are related with the item';

-- Table: author_role
CREATE TABLE author_role (
    id int NOT NULL AUTO_INCREMENT,
    role_name varchar(64) NOT NULL,
    UNIQUE INDEX author_role_ak_1 (role_name),
    CONSTRAINT author_role_pk PRIMARY KEY (id)
) COMMENT 'writer, sculptor, painter, co-author, ';

-- Table: client
CREATE TABLE client (
    id int NOT NULL AUTO_INCREMENT,
    client_name varchar(64) NOT NULL,
    country_id int NULL,
    CONSTRAINT client_pk PRIMARY KEY (id)
);

-- Table: country
CREATE TABLE country (
    id int NOT NULL AUTO_INCREMENT,
    country_name varchar(64) NOT NULL,
    UNIQUE INDEX country_ak_1 (country_name),
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: currency
CREATE TABLE currency (
    id int NOT NULL AUTO_INCREMENT,
    code varchar(8) NOT NULL COMMENT 'EUR, USD, RUB, PLN, HRK ...',
    UNIQUE INDEX currency_ak_1 (code),
    CONSTRAINT currency_pk PRIMARY KEY (id)
);

-- Table: employee
CREATE TABLE employee (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    CONSTRAINT employee_pk PRIMARY KEY (id)
);

-- Table: invoice
CREATE TABLE invoice (
    id int NOT NULL AUTO_INCREMENT,
    invoice_type_id int NOT NULL,
    issued_by varchar(255) NULL COMMENT 'maybe we won''''t always have a customer to whom we issue an invoice',
    client_id int NULL,
    issued_to varchar(255) NOT NULL,
    time_created timestamp NOT NULL,
    invoice_amount decimal(10,2) NOT NULL,
    tax_percentage decimal(5,2) NOT NULL,
    tax_amount decimal(10,2) NOT NULL,
    currency_id int NOT NULL,
    invoice_amount_currency decimal(10,2) NOT NULL,
    tax_amount_currency decimal(10,2) NOT NULL,
    employee_id int NOT NULL,
    CONSTRAINT invoice_pk PRIMARY KEY (id)
);

-- Table: invoice_item
CREATE TABLE invoice_item (
    id int NOT NULL AUTO_INCREMENT,
    invoice_id int NOT NULL,
    item_id int NOT NULL,
    UNIQUE INDEX invoice_item_ak_1 (invoice_id,item_id),
    CONSTRAINT invoice_item_pk PRIMARY KEY (id)
);

-- Table: invoice_type
CREATE TABLE invoice_type (
    id int NOT NULL,
    type_name varchar(64) NOT NULL,
    UNIQUE INDEX invoice_type_ak_1 (type_name),
    CONSTRAINT invoice_type_pk PRIMARY KEY (id)
) COMMENT 'buying, selling, pledge, estimation';

-- Table: item
CREATE TABLE item (
    id int NOT NULL AUTO_INCREMENT,
    item_number varchar(64) NOT NULL COMMENT 'internal UNIQUE indentifier',
    item_type_id int NOT NULL,
    item_description text NOT NULL,
    item_picture text NULL COMMENT 'link to the item picture, if any',
    date_produced varchar(64) NULL COMMENT 'date or year of production if available',
    country_id int NULL COMMENT 'country where the item was produced, if available',
    available bool NOT NULL COMMENT 'is item available for sales or not (updates accordingly changes in the status_history table)',
    UNIQUE INDEX item_ak_1 (item_number),
    CONSTRAINT item_pk PRIMARY KEY (id)
);

-- Table: item_author
CREATE TABLE item_author (
    id int NOT NULL AUTO_INCREMENT,
    item_id int NOT NULL,
    author_id int NOT NULL,
    author_role_id int NOT NULL,
    UNIQUE INDEX item_author_ak_1 (item_id,author_id),
    CONSTRAINT item_author_pk PRIMARY KEY (id)
);

-- Table: item_status
CREATE TABLE item_status (
    id int NOT NULL AUTO_INCREMENT,
    status_name varchar(64) NOT NULL,
    UNIQUE INDEX item_status_ak_1 (status_name),
    CONSTRAINT item_status_pk PRIMARY KEY (id)
) COMMENT 'status shows is item available for sales or not - available, sold, pledged, estmation ...';

-- Table: item_type
CREATE TABLE item_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(64) NOT NULL,
    UNIQUE INDEX item_type_ak_1 (type_name),
    CONSTRAINT item_type_pk PRIMARY KEY (id)
);

-- Table: status_history
CREATE TABLE status_history (
    id int NOT NULL AUTO_INCREMENT,
    item_id int NOT NULL,
    item_status_id int NOT NULL,
    date_start date NOT NULL,
    date_end date NOT NULL,
    CONSTRAINT status_history_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: client_country (table: client)
ALTER TABLE client ADD CONSTRAINT client_country FOREIGN KEY client_country (country_id)
    REFERENCES country (id);

-- Reference: invoice_client (table: invoice)
ALTER TABLE invoice ADD CONSTRAINT invoice_client FOREIGN KEY invoice_client (client_id)
    REFERENCES client (id);

-- Reference: invoice_currency (table: invoice)
ALTER TABLE invoice ADD CONSTRAINT invoice_currency FOREIGN KEY invoice_currency (currency_id)
    REFERENCES currency (id);

-- Reference: invoice_employee (table: invoice)
ALTER TABLE invoice ADD CONSTRAINT invoice_employee FOREIGN KEY invoice_employee (employee_id)
    REFERENCES employee (id);

-- Reference: invoice_invoice_type (table: invoice)
ALTER TABLE invoice ADD CONSTRAINT invoice_invoice_type FOREIGN KEY invoice_invoice_type (invoice_type_id)
    REFERENCES invoice_type (id);

-- Reference: invoice_item_invoice (table: invoice_item)
ALTER TABLE invoice_item ADD CONSTRAINT invoice_item_invoice FOREIGN KEY invoice_item_invoice (invoice_id)
    REFERENCES invoice (id);

-- Reference: invoice_item_item (table: invoice_item)
ALTER TABLE invoice_item ADD CONSTRAINT invoice_item_item FOREIGN KEY invoice_item_item (item_id)
    REFERENCES item (id);

-- Reference: item_author_author (table: item_author)
ALTER TABLE item_author ADD CONSTRAINT item_author_author FOREIGN KEY item_author_author (author_id)
    REFERENCES author (id);

-- Reference: item_author_author_role (table: item_author)
ALTER TABLE item_author ADD CONSTRAINT item_author_author_role FOREIGN KEY item_author_author_role (author_role_id)
    REFERENCES author_role (id);

-- Reference: item_author_item (table: item_author)
ALTER TABLE item_author ADD CONSTRAINT item_author_item FOREIGN KEY item_author_item (item_id)
    REFERENCES item (id);

-- Reference: item_country (table: item)
ALTER TABLE item ADD CONSTRAINT item_country FOREIGN KEY item_country (country_id)
    REFERENCES country (id);

-- Reference: item_item_type (table: item)
ALTER TABLE item ADD CONSTRAINT item_item_type FOREIGN KEY item_item_type (item_type_id)
    REFERENCES item_type (id);

-- Reference: status_history_item (table: status_history)
ALTER TABLE status_history ADD CONSTRAINT status_history_item FOREIGN KEY status_history_item (item_id)
    REFERENCES item (id);

-- Reference: status_history_item_status (table: status_history)
ALTER TABLE status_history ADD CONSTRAINT status_history_item_status FOREIGN KEY status_history_item_status (item_status_id)
    REFERENCES item_status (id);

-- End of file.

