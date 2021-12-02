-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:01:58.77

-- tables
-- Table: bid_coin_bag
CREATE TABLE bid_coin_bag (
    id number  NOT NULL,
    bag_name varchar2(50)  NOT NULL,
    bid_coins number  NOT NULL,
    bonus_coins number  NULL,
    cost_in_currency number  NOT NULL,
    CONSTRAINT bid_coin_bag_pk PRIMARY KEY (id)
) ;

-- Table: bid_coin_transaction_log
CREATE TABLE bid_coin_transaction_log (
    id number  NOT NULL,
    bidder_id number  NOT NULL,
    bid_coin_bag_id number  NULL,
    bid_order_bidding_log_id number  NULL,
    transaction_type char(1)  NOT NULL,
    transaction_date date  NOT NULL,
    coins_count number  NOT NULL,
    CONSTRAINT bid_coin_transaction_log_pk PRIMARY KEY (id)
) ;

-- Table: bid_order
CREATE TABLE bid_order (
    id number  NOT NULL,
    product_id number  NOT NULL,
    bid_start_time timestamp  NOT NULL,
    bid_end_time timestamp  NOT NULL,
    bid_chair_cost_in_bid_coin number  NOT NULL,
    number_of_chairs_allowed number  NOT NULL,
    base_price_in_currency number  NOT NULL,
    bidding_cost_in_bid_coin number  NOT NULL,
    increment_in_price_per_bid number  NOT NULL,
    increment_in_time_per_bid number  NULL,
    CONSTRAINT bid_order_pk PRIMARY KEY (id)
) ;

-- Table: bid_order_bidding_log
CREATE TABLE bid_order_bidding_log (
    id number  NOT NULL,
    bidder_bid_registration_id number  NOT NULL,
    bid_timestamp timestamp  NOT NULL,
    CONSTRAINT bid_order_bidding_log_pk PRIMARY KEY (id)
) ;

-- Table: bidder
CREATE TABLE bidder (
    id number  NOT NULL,
    first_name varchar2(50)  NOT NULL,
    last_name varchar2(50)  NULL,
    date_of_birth date  NOT NULL,
    email varchar2(255)  NOT NULL,
    user_name varchar2(20)  NOT NULL,
    pwd_enc varchar2(100)  NOT NULL,
    joining_date date  NOT NULL,
    current_bid_coins number  NOT NULL,
    CONSTRAINT bidder_pk PRIMARY KEY (id)
) ;

-- Table: bidder_bid_registration
CREATE TABLE bidder_bid_registration (
    id number  NOT NULL,
    bidder_id number  NOT NULL,
    bid_order_id number  NOT NULL,
    registration_date date  NOT NULL,
    is_active char(1)  NOT NULL,
    CONSTRAINT bidder_bid_registration_pk PRIMARY KEY (id)
) ;

-- Table: product
CREATE TABLE product (
    id number  NOT NULL,
    product_name varchar2(100)  NOT NULL,
    product_category_id number  NOT NULL,
    product_specification varchar2(4000)  NOT NULL,
    actual_cost_in_currency number  NOT NULL,
    CONSTRAINT product_pk PRIMARY KEY (id)
) ;

-- Table: product_category
CREATE TABLE product_category (
    id number  NOT NULL,
    product_category varchar2(50)  NOT NULL,
    CONSTRAINT product_category_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: bid_coin_trx_log_bid_coin_bag (table: bid_coin_transaction_log)
ALTER TABLE bid_coin_transaction_log ADD CONSTRAINT bid_coin_trx_log_bid_coin_bag
    FOREIGN KEY (bid_coin_bag_id)
    REFERENCES bid_coin_bag (id);

-- Reference: bid_coin_trx_log_bob_log (table: bid_coin_transaction_log)
ALTER TABLE bid_coin_transaction_log ADD CONSTRAINT bid_coin_trx_log_bob_log
    FOREIGN KEY (bid_order_bidding_log_id)
    REFERENCES bid_order_bidding_log (id);

-- Reference: bid_registration_product (table: bid_order)
ALTER TABLE bid_order ADD CONSTRAINT bid_registration_product
    FOREIGN KEY (product_id)
    REFERENCES product (id);

-- Reference: bidder_bid_registration_bidder (table: bidder_bid_registration)
ALTER TABLE bidder_bid_registration ADD CONSTRAINT bidder_bid_registration_bidder
    FOREIGN KEY (bidder_id)
    REFERENCES bidder (id);

-- Reference: bidder_bid_rgs_bid_rgs (table: bidder_bid_registration)
ALTER TABLE bidder_bid_registration ADD CONSTRAINT bidder_bid_rgs_bid_rgs
    FOREIGN KEY (bid_order_id)
    REFERENCES bid_order (id);

-- Reference: bob_log_bidder_bid_rgs (table: bid_order_bidding_log)
ALTER TABLE bid_order_bidding_log ADD CONSTRAINT bob_log_bidder_bid_rgs
    FOREIGN KEY (bidder_bid_registration_id)
    REFERENCES bidder_bid_registration (id);

-- Reference: product_product_category (table: product)
ALTER TABLE product ADD CONSTRAINT product_product_category
    FOREIGN KEY (product_category_id)
    REFERENCES product_category (id);

-- Reference: user_bid_credit_log_bidder (table: bid_coin_transaction_log)
ALTER TABLE bid_coin_transaction_log ADD CONSTRAINT user_bid_credit_log_bidder
    FOREIGN KEY (bidder_id)
    REFERENCES bidder (id);

-- End of file.

