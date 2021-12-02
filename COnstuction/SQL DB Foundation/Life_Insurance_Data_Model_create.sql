-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:58:44.719

-- tables
-- Table: case
CREATE TABLE `case` (
    id int NOT NULL AUTO_INCREMENT,
    case_name varchar(255) NOT NULL,
    description text NULL,
    UNIQUE INDEX case_ak_1 (case_name),
    CONSTRAINT case_pk PRIMARY KEY (id)
) COMMENT 'list of all cases insurance policy could cover';

-- Table: client
CREATE TABLE client (
    id int NOT NULL AUTO_INCREMENT,
    code varchar(64) NOT NULL,
    person_id int NOT NULL,
    client_category_id int NOT NULL,
    UNIQUE INDEX client_ak_1 (code),
    CONSTRAINT client_pk PRIMARY KEY (id)
) COMMENT 'list of all our clients';

-- Table: client_category
CREATE TABLE client_category (
    id int NOT NULL AUTO_INCREMENT,
    category_name varchar(64) NOT NULL,
    UNIQUE INDEX client_category_ak_1 (category_name),
    CONSTRAINT client_category_pk PRIMARY KEY (id)
);

-- Table: client_related
CREATE TABLE client_related (
    id int NOT NULL AUTO_INCREMENT,
    client_id int NOT NULL,
    person_id int NOT NULL,
    client_relation_type_id int NOT NULL,
    details text NULL,
    is_active bool NOT NULL,
    UNIQUE INDEX client_related_ak_1 (client_id,person_id,client_relation_type_id),
    CONSTRAINT client_related_pk PRIMARY KEY (id)
) COMMENT 'all relations between persons and clients';

-- Table: client_relation_type
CREATE TABLE client_relation_type (
    id int NOT NULL,
    relation_type varchar(64) NOT NULL,
    UNIQUE INDEX client_relation_type_ak_1 (relation_type),
    CONSTRAINT client_relation_type_pk PRIMARY KEY (id)
) COMMENT 'dictionary with a list of all possible relation types';

-- Table: employee
CREATE TABLE employee (
    id int NOT NULL AUTO_INCREMENT,
    code varchar(32) NOT NULL,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    birth_date date NOT NULL,
    UNIQUE INDEX employee_ak_1 (code),
    CONSTRAINT employee_pk PRIMARY KEY (id)
);

-- Table: has_role
CREATE TABLE has_role (
    id int NOT NULL AUTO_INCREMENT,
    employee_id int NOT NULL,
    role_id int NOT NULL,
    start_date date NOT NULL,
    end_date date NULL,
    UNIQUE INDEX has_role_ak_1 (employee_id,role_id,start_date),
    CONSTRAINT has_role_pk PRIMARY KEY (id)
);

-- Table: in_offer
CREATE TABLE in_offer (
    id int NOT NULL AUTO_INCREMENT,
    offer_id int NOT NULL,
    case_id int NOT NULL,
    details text NULL,
    UNIQUE INDEX in_offer_ak_1 (offer_id,case_id),
    CONSTRAINT in_offer_pk PRIMARY KEY (id)
);

-- Table: in_signed_offer
CREATE TABLE in_signed_offer (
    id int NOT NULL AUTO_INCREMENT,
    signed_offer_id int NOT NULL,
    case_id int NOT NULL,
    details text NULL,
    UNIQUE INDEX in_signed_offer_ak_1 (signed_offer_id,case_id),
    CONSTRAINT in_signed_offer_pk PRIMARY KEY (id)
);

-- Table: offer
CREATE TABLE offer (
    id int NOT NULL AUTO_INCREMENT,
    client_id int NOT NULL,
    product_id int NOT NULL,
    has_role_id int NOT NULL,
    date_offered date NOT NULL,
    policy_type_id int NOT NULL,
    paymemt_amount decimal(10,2) NOT NULL,
    terms text NOT NULL,
    details text NULL,
    is_active bool NOT NULL,
    CONSTRAINT offer_pk PRIMARY KEY (id)
);

-- Table: offer_related
CREATE TABLE offer_related (
    id int NOT NULL AUTO_INCREMENT,
    signed_offer_id int NOT NULL,
    person_id int NOT NULL,
    offer_relation_type_id int NOT NULL,
    details text NULL,
    is_active bool NOT NULL,
    CONSTRAINT offer_related_pk PRIMARY KEY (id)
) COMMENT 'list of all persons related to offers';

-- Table: offer_relation_type
CREATE TABLE offer_relation_type (
    id int NOT NULL AUTO_INCREMENT,
    relation_type varchar(64) NOT NULL,
    UNIQUE INDEX offer_relation_type_ak_1 (relation_type),
    CONSTRAINT offer_relation_type_pk PRIMARY KEY (id)
) COMMENT 'dictionary with all types of relation person could have with an offer';

-- Table: payment
CREATE TABLE payment (
    id int NOT NULL AUTO_INCREMENT,
    signed_offer_id int NOT NULL,
    payment_date date NOT NULL,
    amount decimal(10,2) NOT NULL,
    description text NULL,
    person_id int NOT NULL,
    client_id int NULL,
    CONSTRAINT payment_pk PRIMARY KEY (id)
);

-- Table: payout
CREATE TABLE payout (
    id int NOT NULL AUTO_INCREMENT,
    signed_offer_id int NOT NULL,
    payout_date date NOT NULL,
    amount decimal(10,2) NOT NULL,
    case_id int NOT NULL,
    payout_reason_id int NOT NULL,
    person_id int NOT NULL,
    client_id int NULL,
    CONSTRAINT payout_pk PRIMARY KEY (id)
);

-- Table: payout_reason
CREATE TABLE payout_reason (
    id int NOT NULL AUTO_INCREMENT,
    reason_name varchar(255) NOT NULL,
    UNIQUE INDEX payout_reason_ak_1 (reason_name),
    CONSTRAINT payout_reason_pk PRIMARY KEY (id)
);

-- Table: person
CREATE TABLE person (
    id int NOT NULL AUTO_INCREMENT,
    code varchar(64) NOT NULL,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    address varchar(255) NULL,
    phone varchar(255) NULL,
    mobile varchar(255) NULL,
    email varchar(255) NULL,
    UNIQUE INDEX person_ak_1 (code),
    CONSTRAINT person_pk PRIMARY KEY (id)
) COMMENT 'list of all private individuals that are clients or related to them';

-- Table: policy_type
CREATE TABLE policy_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(64) NOT NULL,
    description text NULL,
    expires bool NOT NULL COMMENT 'if it expires or not',
    monthly_payment bool NOT NULL,
    quarterly_payment bool NOT NULL,
    yearly_payment bool NOT NULL,
    UNIQUE INDEX policy_type_ak_1 (type_name),
    CONSTRAINT policy_type_pk PRIMARY KEY (id)
) COMMENT 'all types of policies we offer';

-- Table: product
CREATE TABLE product (
    id int NOT NULL AUTO_INCREMENT,
    product_name varchar(64) NOT NULL,
    product_category_id int NOT NULL,
    product_description text NOT NULL,
    UNIQUE INDEX product_ak_1 (product_name,product_category_id),
    CONSTRAINT product_pk PRIMARY KEY (id)
);

-- Table: product_category
CREATE TABLE product_category (
    id int NOT NULL AUTO_INCREMENT,
    category_name varchar(64) NOT NULL,
    UNIQUE INDEX product_category_ak_1 (category_name),
    CONSTRAINT product_category_pk PRIMARY KEY (id)
);

-- Table: role
CREATE TABLE role (
    id int NOT NULL AUTO_INCREMENT,
    role_name varchar(255) NOT NULL,
    UNIQUE INDEX role_ak_1 (role_name),
    CONSTRAINT role_pk PRIMARY KEY (id)
);

-- Table: signed_offer
CREATE TABLE signed_offer (
    id int NOT NULL AUTO_INCREMENT,
    client_id int NOT NULL,
    product_id int NOT NULL,
    has_role_id int NOT NULL,
    date_signed date NOT NULL,
    offer_id int NULL,
    policy_type_id int NOT NULL,
    payment_amount decimal(10,2) NOT NULL,
    terms text NOT NULL,
    details text NULL,
    is_active bool NOT NULL,
    start_date date NOT NULL,
    end_date date NULL,
    CONSTRAINT signed_offer_pk PRIMARY KEY (id)
) COMMENT 'list of all signed offers with clients';

-- foreign keys
-- Reference: client_client_category (table: client)
ALTER TABLE client ADD CONSTRAINT client_client_category FOREIGN KEY client_client_category (client_category_id)
    REFERENCES client_category (id);

-- Reference: client_person (table: client)
ALTER TABLE client ADD CONSTRAINT client_person FOREIGN KEY client_person (person_id)
    REFERENCES person (id);

-- Reference: client_related_client (table: client_related)
ALTER TABLE client_related ADD CONSTRAINT client_related_client FOREIGN KEY client_related_client (client_id)
    REFERENCES client (id);

-- Reference: client_related_client_relation_type (table: client_related)
ALTER TABLE client_related ADD CONSTRAINT client_related_client_relation_type FOREIGN KEY client_related_client_relation_type (client_relation_type_id)
    REFERENCES client_relation_type (id);

-- Reference: client_related_person (table: client_related)
ALTER TABLE client_related ADD CONSTRAINT client_related_person FOREIGN KEY client_related_person (person_id)
    REFERENCES person (id);

-- Reference: has_role_employee (table: has_role)
ALTER TABLE has_role ADD CONSTRAINT has_role_employee FOREIGN KEY has_role_employee (employee_id)
    REFERENCES employee (id);

-- Reference: has_role_role (table: has_role)
ALTER TABLE has_role ADD CONSTRAINT has_role_role FOREIGN KEY has_role_role (role_id)
    REFERENCES role (id);

-- Reference: in_offer_case (table: in_offer)
ALTER TABLE in_offer ADD CONSTRAINT in_offer_case FOREIGN KEY in_offer_case (case_id)
    REFERENCES `case` (id);

-- Reference: in_offer_offer (table: in_offer)
ALTER TABLE in_offer ADD CONSTRAINT in_offer_offer FOREIGN KEY in_offer_offer (offer_id)
    REFERENCES offer (id);

-- Reference: in_signed_offer_case (table: in_signed_offer)
ALTER TABLE in_signed_offer ADD CONSTRAINT in_signed_offer_case FOREIGN KEY in_signed_offer_case (case_id)
    REFERENCES `case` (id);

-- Reference: in_signed_offer_signed_offer (table: in_signed_offer)
ALTER TABLE in_signed_offer ADD CONSTRAINT in_signed_offer_signed_offer FOREIGN KEY in_signed_offer_signed_offer (signed_offer_id)
    REFERENCES signed_offer (id);

-- Reference: offer_client (table: offer)
ALTER TABLE offer ADD CONSTRAINT offer_client FOREIGN KEY offer_client (client_id)
    REFERENCES client (id);

-- Reference: offer_has_role (table: offer)
ALTER TABLE offer ADD CONSTRAINT offer_has_role FOREIGN KEY offer_has_role (has_role_id)
    REFERENCES has_role (id);

-- Reference: offer_policy_type (table: offer)
ALTER TABLE offer ADD CONSTRAINT offer_policy_type FOREIGN KEY offer_policy_type (policy_type_id)
    REFERENCES policy_type (id);

-- Reference: offer_product (table: offer)
ALTER TABLE offer ADD CONSTRAINT offer_product FOREIGN KEY offer_product (product_id)
    REFERENCES product (id);

-- Reference: offer_related_offer_relation_type (table: offer_related)
ALTER TABLE offer_related ADD CONSTRAINT offer_related_offer_relation_type FOREIGN KEY offer_related_offer_relation_type (offer_relation_type_id)
    REFERENCES offer_relation_type (id);

-- Reference: offer_related_person (table: offer_related)
ALTER TABLE offer_related ADD CONSTRAINT offer_related_person FOREIGN KEY offer_related_person (person_id)
    REFERENCES person (id);

-- Reference: offer_related_signed_offer (table: offer_related)
ALTER TABLE offer_related ADD CONSTRAINT offer_related_signed_offer FOREIGN KEY offer_related_signed_offer (signed_offer_id)
    REFERENCES signed_offer (id);

-- Reference: payment_client (table: payment)
ALTER TABLE payment ADD CONSTRAINT payment_client FOREIGN KEY payment_client (client_id)
    REFERENCES client (id);

-- Reference: payment_person (table: payment)
ALTER TABLE payment ADD CONSTRAINT payment_person FOREIGN KEY payment_person (person_id)
    REFERENCES person (id);

-- Reference: payment_signed_offer (table: payment)
ALTER TABLE payment ADD CONSTRAINT payment_signed_offer FOREIGN KEY payment_signed_offer (signed_offer_id)
    REFERENCES signed_offer (id);

-- Reference: payout_case (table: payout)
ALTER TABLE payout ADD CONSTRAINT payout_case FOREIGN KEY payout_case (case_id)
    REFERENCES `case` (id);

-- Reference: payout_client (table: payout)
ALTER TABLE payout ADD CONSTRAINT payout_client FOREIGN KEY payout_client (client_id)
    REFERENCES client (id);

-- Reference: payout_payout_reason (table: payout)
ALTER TABLE payout ADD CONSTRAINT payout_payout_reason FOREIGN KEY payout_payout_reason (payout_reason_id)
    REFERENCES payout_reason (id);

-- Reference: payout_person (table: payout)
ALTER TABLE payout ADD CONSTRAINT payout_person FOREIGN KEY payout_person (person_id)
    REFERENCES person (id);

-- Reference: payout_signed_offer (table: payout)
ALTER TABLE payout ADD CONSTRAINT payout_signed_offer FOREIGN KEY payout_signed_offer (signed_offer_id)
    REFERENCES signed_offer (id);

-- Reference: product_product_category (table: product)
ALTER TABLE product ADD CONSTRAINT product_product_category FOREIGN KEY product_product_category (product_category_id)
    REFERENCES product_category (id);

-- Reference: signed_offer_client (table: signed_offer)
ALTER TABLE signed_offer ADD CONSTRAINT signed_offer_client FOREIGN KEY signed_offer_client (client_id)
    REFERENCES client (id);

-- Reference: signed_offer_has_role (table: signed_offer)
ALTER TABLE signed_offer ADD CONSTRAINT signed_offer_has_role FOREIGN KEY signed_offer_has_role (has_role_id)
    REFERENCES has_role (id);

-- Reference: signed_offer_offer (table: signed_offer)
ALTER TABLE signed_offer ADD CONSTRAINT signed_offer_offer FOREIGN KEY signed_offer_offer (offer_id)
    REFERENCES offer (id);

-- Reference: signed_offer_policy_type (table: signed_offer)
ALTER TABLE signed_offer ADD CONSTRAINT signed_offer_policy_type FOREIGN KEY signed_offer_policy_type (policy_type_id)
    REFERENCES policy_type (id);

-- Reference: signed_offer_product (table: signed_offer)
ALTER TABLE signed_offer ADD CONSTRAINT signed_offer_product FOREIGN KEY signed_offer_product (product_id)
    REFERENCES product (id);

-- End of file.

