-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:18:11.318

-- tables
-- Table: dine_in_table
CREATE TABLE dine_in_table (
    id number  NOT NULL,
    dine_in_table_area_id number  NOT NULL,
    max_capacity number  NOT NULL,
    serving_staff_id number  NOT NULL,
    dine_in_table_status_id number  NOT NULL,
    CONSTRAINT dine_in_table_pk PRIMARY KEY (id)
) ;

-- Table: dine_in_table_area
CREATE TABLE dine_in_table_area (
    id number  NOT NULL,
    area_desc varchar2(20)  NOT NULL,
    is_smoking_allowed char(1)  NOT NULL,
    is_liquor_served char(1)  NOT NULL,
    CONSTRAINT dine_in_table_area_pk PRIMARY KEY (id)
) ;

-- Table: dine_in_table_siting
CREATE TABLE dine_in_table_siting (
    id number  NOT NULL,
    dine_in_time timestamp  NOT NULL,
    dine_out_time timestamp  NOT NULL,
    num_person_sitting number  NOT NULL,
    dine_in_table_id number  NOT NULL,
    CONSTRAINT dine_in_table_siting_pk PRIMARY KEY (id)
) ;

-- Table: dine_in_table_status
CREATE TABLE dine_in_table_status (
    id number  NOT NULL,
    status varchar2(20)  NOT NULL,
    CONSTRAINT dine_in_table_status_pk PRIMARY KEY (id)
) ;

-- Table: kod
CREATE TABLE kod (
    id number  NOT NULL,
    kot_menu_item_id number  NOT NULL,
    staff_id number  NOT NULL,
    kod_status_id number  NOT NULL,
    CONSTRAINT kod_pk PRIMARY KEY (id)
) ;

-- Table: kod_status
CREATE TABLE kod_status (
    id number  NOT NULL,
    status varchar2(20)  NOT NULL,
    CONSTRAINT kod_status_pk PRIMARY KEY (id)
) ;

-- Table: kot
CREATE TABLE kot (
    id number  NOT NULL,
    order_channel_id number  NOT NULL,
    staff_id number  NOT NULL,
    dine_in_table_stting_id number  NOT NULL,
    order_in_time timestamp  NOT NULL,
    order_out_time timestamp  NOT NULL,
    kot_status_id number  NOT NULL,
    CONSTRAINT kot_pk PRIMARY KEY (id)
) ;

-- Table: kot_menu_item
CREATE TABLE kot_menu_item (
    id number  NOT NULL,
    kot_id number  NOT NULL,
    menu_item_id number  NOT NULL,
    quantity number  NOT NULL,
    CONSTRAINT kot_menu_item_pk PRIMARY KEY (id)
) ;

-- Table: kot_status
CREATE TABLE kot_status (
    id number  NOT NULL,
    status varchar2(20)  NOT NULL,
    CONSTRAINT kot_status_pk PRIMARY KEY (id)
) ;

-- Table: menu_item
CREATE TABLE menu_item (
    id number  NOT NULL,
    item_name varchar2(100)  NOT NULL,
    item_category_id number  NOT NULL,
    item_desc varchar2(1000)  NOT NULL,
    item_image blob  NOT NULL,
    cost number  NOT NULL,
    CONSTRAINT menu_item_pk PRIMARY KEY (id)
) ;

-- Table: menu_item_category
CREATE TABLE menu_item_category (
    id number  NOT NULL,
    item_category_name varchar2(20)  NOT NULL,
    item_category_description varchar2(100)  NOT NULL,
    CONSTRAINT menu_item_category_pk PRIMARY KEY (id)
) ;

-- Table: order_channel
CREATE TABLE order_channel (
    id number  NOT NULL,
    channel_name varchar2(20)  NOT NULL,
    channel_desc varchar2(200)  NULL,
    open_time timestamp  NOT NULL,
    close_time timestamp  NOT NULL,
    CONSTRAINT order_channel_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: Dine_in_table__area (table: dine_in_table)
ALTER TABLE dine_in_table ADD CONSTRAINT Dine_in_table__area
    FOREIGN KEY (dine_in_table_area_id)
    REFERENCES dine_in_table_area (id);

-- Reference: Dine_in_tbl_dine_in_tbl_status (table: dine_in_table)
ALTER TABLE dine_in_table ADD CONSTRAINT Dine_in_tbl_dine_in_tbl_status
    FOREIGN KEY (dine_in_table_status_id)
    REFERENCES dine_in_table_status (id);

-- Reference: KOD_KOD_Status (table: kod)
ALTER TABLE kod ADD CONSTRAINT KOD_KOD_Status
    FOREIGN KEY (kod_status_id)
    REFERENCES kod_status (id);

-- Reference: KOD_KOT_Menu_Item (table: kod)
ALTER TABLE kod ADD CONSTRAINT KOD_KOT_Menu_Item
    FOREIGN KEY (kot_menu_item_id)
    REFERENCES kot_menu_item (id);

-- Reference: KOT_KOT_status (table: kot)
ALTER TABLE kot ADD CONSTRAINT KOT_KOT_status
    FOREIGN KEY (kot_status_id)
    REFERENCES kot_status (id);

-- Reference: KOT_Order_Channel (table: kot)
ALTER TABLE kot ADD CONSTRAINT KOT_Order_Channel
    FOREIGN KEY (order_channel_id)
    REFERENCES order_channel (id);

-- Reference: KOT_Table_Menu_Item_KOT_Table (table: kot_menu_item)
ALTER TABLE kot_menu_item ADD CONSTRAINT KOT_Table_Menu_Item_KOT_Table
    FOREIGN KEY (kot_id)
    REFERENCES kot (id);

-- Reference: KOT_Table_Menu_Item_menu_item (table: kot_menu_item)
ALTER TABLE kot_menu_item ADD CONSTRAINT KOT_Table_Menu_Item_menu_item
    FOREIGN KEY (menu_item_id)
    REFERENCES menu_item (id);

-- Reference: KOT_trx_dine_in_table (table: kot)
ALTER TABLE kot ADD CONSTRAINT KOT_trx_dine_in_table
    FOREIGN KEY (dine_in_table_stting_id)
    REFERENCES dine_in_table_siting (id);

-- Reference: menu_item_menu_item_category (table: menu_item)
ALTER TABLE menu_item ADD CONSTRAINT menu_item_menu_item_category
    FOREIGN KEY (item_category_id)
    REFERENCES menu_item_category (id);

-- Reference: trx_dine_in_tbl_dine_in_tbl (table: dine_in_table_siting)
ALTER TABLE dine_in_table_siting ADD CONSTRAINT trx_dine_in_tbl_dine_in_tbl
    FOREIGN KEY (dine_in_table_id)
    REFERENCES dine_in_table (id);

-- End of file.

