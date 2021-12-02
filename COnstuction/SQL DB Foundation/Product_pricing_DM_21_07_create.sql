-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:06:36.356

-- tables
-- Table: membership_type
CREATE TABLE membership_type (
    id number  NOT NULL,
    membership_type varchar2(20)  NOT NULL,
    discount_value number  NOT NULL,
    discount_unit varchar2(20)  NOT NULL,
    create_date date  NOT NULL,
    valid_until date  NOT NULL,
    is_free_shipping_active char(1)  NOT NULL,
    CONSTRAINT membership_type_pk PRIMARY KEY (id)
) ;

-- Table: payment_offer
CREATE TABLE payment_offer (
    id number  NOT NULL,
    institute_type varchar2(50)  NOT NULL,
    institute_name varchar2(200)  NOT NULL,
    card_type varchar2(20)  NULL,
    coupon_code varchar2(10)  NOT NULL,
    discount_value number  NOT NULL,
    discount_unit varchar2(20)  NOT NULL,
    create_date timestamp  NOT NULL,
    valid_from timestamp  NOT NULL,
    valid_until timestamp  NOT NULL,
    maximum_discount_amount number  NOT NULL,
    product_id number  NULL,
    product_category_id number  NULL,
    CONSTRAINT payment_offer_pk PRIMARY KEY (id)
) ;

-- Table: product
CREATE TABLE product (
    id number  NOT NULL,
    product_name varchar2(100)  NOT NULL,
    product_description varchar2(4000)  NOT NULL,
    units_in_stock number  NOT NULL,
    product_category_id number  NOT NULL,
    reward_points_credit number  NOT NULL,
    CONSTRAINT product_pk PRIMARY KEY (id)
) ;

-- Table: product_category
CREATE TABLE product_category (
    id number  NOT NULL,
    category_name varchar2(100)  NOT NULL,
    max_reward_points_encash number  NOT NULL,
    parent_category_id number  NULL,
    CONSTRAINT product_category_pk PRIMARY KEY (id)
) ;

-- Table: product_category_discount
CREATE TABLE product_category_discount (
    id number  NOT NULL,
    product_category_id number  NOT NULL,
    discount_value number  NOT NULL,
    discount_unit varchar2(20)  NOT NULL,
    create_date timestamp  NOT NULL,
    valid_from timestamp  NOT NULL,
    valid_until timestamp  NOT NULL,
    coupon_code varchar2(10)  NOT NULL,
    minimum_order_value number  DEFAULT 0 NOT NULL,
    maximum_discount_amount number  NOT NULL,
    is_redeem_allowed char(1)  NOT NULL,
    CONSTRAINT product_category_discount_pk PRIMARY KEY (id)
) ;

-- Table: product_discount
CREATE TABLE product_discount (
    id number  NOT NULL,
    product_id number  NOT NULL,
    discount_value number  NOT NULL,
    discount_unit varchar2(20)  NOT NULL,
    create_date timestamp  NOT NULL,
    valid_from timestamp  NOT NULL,
    valid_until timestamp  NOT NULL,
    coupon_code varchar2(10)  NOT NULL,
    minimum_order_value number  NOT NULL,
    maximum_discount_amount number  NOT NULL,
    is_redeem_allowed char(1)  NOT NULL,
    CONSTRAINT product_discount_pk PRIMARY KEY (id)
) ;

-- Table: product_pricing
CREATE TABLE product_pricing (
    id number  NOT NULL,
    product_id number  NOT NULL,
    base_price number  NOT NULL,
    create_date timestamp  NOT NULL,
    expiry_date timestamp  NOT NULL,
    in_active char(1)  NOT NULL,
    CONSTRAINT product_pricing_pk PRIMARY KEY (id)
) ;

-- Table: user
CREATE TABLE "user" (
    id number  NOT NULL,
    first_name varchar2(50)  NOT NULL,
    last_name varchar2(50)  NOT NULL,
    registration_date date  NOT NULL,
    promotional_reward_points number  NOT NULL,
    non_promotional_reward_points number  NOT NULL,
    membership_type_id number  NULL,
    CONSTRAINT user_pk PRIMARY KEY (id)
) ;

-- Table: user_reward_point_log
CREATE TABLE user_reward_point_log (
    id number  NOT NULL,
    user_id number  NOT NULL,
    reward_points number  NOT NULL,
    reward_type char(2)  NOT NULL,
    operation_type char(1)  NOT NULL,
    create_date timestamp  NOT NULL,
    expiry_date date  NULL,
    CONSTRAINT user_reward_point_log_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: payment_offer_product (table: payment_offer)
ALTER TABLE payment_offer ADD CONSTRAINT payment_offer_product
    FOREIGN KEY (product_id)
    REFERENCES product (id);

-- Reference: payment_offer_product_category (table: payment_offer)
ALTER TABLE payment_offer ADD CONSTRAINT payment_offer_product_category
    FOREIGN KEY (product_category_id)
    REFERENCES product_category (id);

-- Reference: prd_category_prd_category (table: product_category)
ALTER TABLE product_category ADD CONSTRAINT prd_category_prd_category
    FOREIGN KEY (parent_category_id)
    REFERENCES product_category (id);

-- Reference: prd_pricing_discount_prd_cat (table: product_category_discount)
ALTER TABLE product_category_discount ADD CONSTRAINT prd_pricing_discount_prd_cat
    FOREIGN KEY (product_category_id)
    REFERENCES product_category (id);

-- Reference: product_discount_product (table: product_discount)
ALTER TABLE product_discount ADD CONSTRAINT product_discount_product
    FOREIGN KEY (product_id)
    REFERENCES product (id);

-- Reference: product_pricing_product (table: product_pricing)
ALTER TABLE product_pricing ADD CONSTRAINT product_pricing_product
    FOREIGN KEY (product_id)
    REFERENCES product (id);

-- Reference: product_product_category (table: product)
ALTER TABLE product ADD CONSTRAINT product_product_category
    FOREIGN KEY (product_category_id)
    REFERENCES product_category (id);

-- Reference: user_membership_type (table: user)
ALTER TABLE "user" ADD CONSTRAINT user_membership_type
    FOREIGN KEY (membership_type_id)
    REFERENCES membership_type (id);

-- Reference: user_rewards_user (table: user_reward_point_log)
ALTER TABLE user_reward_point_log ADD CONSTRAINT user_rewards_user
    FOREIGN KEY (user_id)
    REFERENCES "user" (id);

-- End of file.

