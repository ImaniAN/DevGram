-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:57:05.903

-- tables
-- Table: country
CREATE TABLE country (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(128) NOT NULL,
    UNIQUE INDEX country_ak_1 (name),
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: currency
CREATE TABLE currency (
    id int NOT NULL AUTO_INCREMENT,
    code varchar(8) NOT NULL COMMENT 'e.g. iso code for currencies',
    name varchar(128) NOT NULL,
    is_active bool NOT NULL,
    is_base_currency bool NOT NULL,
    UNIQUE INDEX currency_ak_1 (code),
    UNIQUE INDEX currency_ak_2 (name),
    CONSTRAINT currency_pk PRIMARY KEY (id)
);

-- Table: currency_rate
CREATE TABLE currency_rate (
    id int NOT NULL AUTO_INCREMENT,
    currency_id int NOT NULL,
    base_currency_id int NOT NULL,
    rate decimal(16,6) NOT NULL,
    ts timestamp NOT NULL,
    CONSTRAINT currency_rate_pk PRIMARY KEY (id)
) COMMENT 'history rates between currencies (base currency and others)';

-- Table: currency_used
CREATE TABLE currency_used (
    id int NOT NULL AUTO_INCREMENT,
    country_id int NOT NULL,
    currency_id int NOT NULL,
    date_from date NOT NULL,
    date_to date NULL,
    CONSTRAINT currency_used_pk PRIMARY KEY (id)
);

-- Table: current_inventory
CREATE TABLE current_inventory (
    id int NOT NULL AUTO_INCREMENT,
    trader_id int NOT NULL,
    item_id int NOT NULL,
    quantity decimal(16,6) NOT NULL,
    UNIQUE INDEX current_inventory_ak_1 (trader_id,item_id),
    CONSTRAINT current_inventory_pk PRIMARY KEY (id)
);

-- Table: item
CREATE TABLE item (
    id int NOT NULL AUTO_INCREMENT,
    code varchar(64) NOT NULL,
    name varchar(255) NOT NULL,
    is_active bool NOT NULL,
    currency_id int NOT NULL,
    details text NULL,
    UNIQUE INDEX item_ak_1 (code),
    CONSTRAINT item_pk PRIMARY KEY (id)
) COMMENT 'list of all items we''''l have available for trade - share, fund, currency';

-- Table: offer
CREATE TABLE offer (
    id int NOT NULL AUTO_INCREMENT,
    trader_id int NOT NULL,
    item_id int NOT NULL,
    quantity decimal(16,6) NOT NULL,
    buy bool NOT NULL,
    sell bool NOT NULL,
    price decimal(16,6) NULL,
    ts timestamp NOT NULL,
    is_active bool NOT NULL,
    CONSTRAINT offer_pk PRIMARY KEY (id)
) COMMENT 'list of all offers avaliable to buy/sell';

-- Table: price
CREATE TABLE price (
    id int NOT NULL AUTO_INCREMENT,
    item_id int NOT NULL,
    currency_id int NOT NULL,
    buy decimal(16,6) NOT NULL,
    sell decimal(16,6) NOT NULL,
    ts timestamp NOT NULL,
    CONSTRAINT price_pk PRIMARY KEY (id)
) COMMENT 'list of history prices (buy & sell)';

-- Table: report
CREATE TABLE report (
    id int NOT NULL AUTO_INCREMENT,
    trading_date date NOT NULL,
    item_id int NOT NULL,
    currency_id int NOT NULL,
    first_price decimal(16,6) NULL,
    last_price decimal(16,6) NULL,
    min_price decimal(16,6) NULL,
    max_price decimal(16,6) NULL,
    avg_price decimal(16,6) NULL,
    total_amount decimal(16,6) NULL,
    quantity decimal(16,6) NULL,
    UNIQUE INDEX report_ak_1 (trading_date,item_id,currency_id),
    CONSTRAINT report_pk PRIMARY KEY (id)
);

-- Table: trade
CREATE TABLE trade (
    id int NOT NULL AUTO_INCREMENT,
    item_id int NOT NULL,
    seller_id int NULL,
    buyer_id int NOT NULL,
    qunatity decimal(16,6) NOT NULL,
    unit_price decimal(16,6) NOT NULL,
    description text NOT NULL,
    offer_id int NOT NULL,
    CONSTRAINT trade_pk PRIMARY KEY (id)
);

-- Table: trader
CREATE TABLE trader (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    user_name varchar(64) NOT NULL,
    password varchar(64) NOT NULL,
    email varchar(128) NOT NULL,
    confirmation_code varchar(128) NOT NULL,
    time_registered timestamp NOT NULL,
    time_confirmed timestamp NOT NULL,
    country_id int NOT NULL,
    preferred_currency_id int NOT NULL,
    UNIQUE INDEX trader_ak_1 (user_name,email),
    CONSTRAINT trader_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: currency_rate_base_currency (table: currency_rate)
ALTER TABLE currency_rate ADD CONSTRAINT currency_rate_base_currency FOREIGN KEY currency_rate_base_currency (base_currency_id)
    REFERENCES currency (id);

-- Reference: currency_rate_currency (table: currency_rate)
ALTER TABLE currency_rate ADD CONSTRAINT currency_rate_currency FOREIGN KEY currency_rate_currency (currency_id)
    REFERENCES currency (id);

-- Reference: currency_used_country (table: currency_used)
ALTER TABLE currency_used ADD CONSTRAINT currency_used_country FOREIGN KEY currency_used_country (country_id)
    REFERENCES country (id);

-- Reference: currency_used_currency (table: currency_used)
ALTER TABLE currency_used ADD CONSTRAINT currency_used_currency FOREIGN KEY currency_used_currency (currency_id)
    REFERENCES currency (id);

-- Reference: current_inventory_item (table: current_inventory)
ALTER TABLE current_inventory ADD CONSTRAINT current_inventory_item FOREIGN KEY current_inventory_item (item_id)
    REFERENCES item (id);

-- Reference: current_inventory_trader (table: current_inventory)
ALTER TABLE current_inventory ADD CONSTRAINT current_inventory_trader FOREIGN KEY current_inventory_trader (trader_id)
    REFERENCES trader (id);

-- Reference: item_currency (table: item)
ALTER TABLE item ADD CONSTRAINT item_currency FOREIGN KEY item_currency (currency_id)
    REFERENCES currency (id);

-- Reference: offer_item (table: offer)
ALTER TABLE offer ADD CONSTRAINT offer_item FOREIGN KEY offer_item (item_id)
    REFERENCES item (id);

-- Reference: offer_trader (table: offer)
ALTER TABLE offer ADD CONSTRAINT offer_trader FOREIGN KEY offer_trader (trader_id)
    REFERENCES trader (id);

-- Reference: price_currency (table: price)
ALTER TABLE price ADD CONSTRAINT price_currency FOREIGN KEY price_currency (currency_id)
    REFERENCES currency (id);

-- Reference: price_item (table: price)
ALTER TABLE price ADD CONSTRAINT price_item FOREIGN KEY price_item (item_id)
    REFERENCES item (id);

-- Reference: report_currency (table: report)
ALTER TABLE report ADD CONSTRAINT report_currency FOREIGN KEY report_currency (currency_id)
    REFERENCES currency (id);

-- Reference: report_item (table: report)
ALTER TABLE report ADD CONSTRAINT report_item FOREIGN KEY report_item (item_id)
    REFERENCES item (id);

-- Reference: trade_buyer (table: trade)
ALTER TABLE trade ADD CONSTRAINT trade_buyer FOREIGN KEY trade_buyer (buyer_id)
    REFERENCES trader (id);

-- Reference: trade_item (table: trade)
ALTER TABLE trade ADD CONSTRAINT trade_item FOREIGN KEY trade_item (item_id)
    REFERENCES item (id);

-- Reference: trade_offer (table: trade)
ALTER TABLE trade ADD CONSTRAINT trade_offer FOREIGN KEY trade_offer (offer_id)
    REFERENCES offer (id);

-- Reference: trade_seller (table: trade)
ALTER TABLE trade ADD CONSTRAINT trade_seller FOREIGN KEY trade_seller (seller_id)
    REFERENCES trader (id);

-- Reference: trader_country (table: trader)
ALTER TABLE trader ADD CONSTRAINT trader_country FOREIGN KEY trader_country (country_id)
    REFERENCES country (id);

-- Reference: trader_currency (table: trader)
ALTER TABLE trader ADD CONSTRAINT trader_currency FOREIGN KEY trader_currency (preferred_currency_id)
    REFERENCES currency (id);

-- End of file.

