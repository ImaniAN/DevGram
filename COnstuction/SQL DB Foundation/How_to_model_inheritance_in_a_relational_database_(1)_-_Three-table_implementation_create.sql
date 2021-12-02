-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:42:36.724

-- tables
-- Table: client_t
CREATE TABLE client_t (
    id number(5)  NOT NULL,
    address varchar2(50)  NOT NULL,
    type char(1)  NOT NULL,
    CONSTRAINT client_t_pk PRIMARY KEY (id)
) ;

-- Table: company_t
CREATE TABLE company_t (
    id number(5)  NOT NULL,
    company_name varchar2(20)  NOT NULL,
    industry varchar2(20)  NOT NULL,
    CONSTRAINT company_t_pk PRIMARY KEY (id)
) ;

-- Table: individual_t
CREATE TABLE individual_t (
    id number(5)  NOT NULL,
    name varchar2(20)  NOT NULL,
    surname varchar2(20)  NOT NULL,
    CONSTRAINT individual_t_pk PRIMARY KEY (id)
) ;

-- views
-- View: individual
CREATE VIEW individual AS
select
client_t.id,
client_t.address,
individual_t.name,
individual_t.surname
from client_t, individual_t
where client_t.id = individual_t.client_id;

-- View: client
CREATE VIEW client AS
select
  client_t.id,
  client_t.address,
  company_t.company_name,
  company_t.industry,
  individual_t.name,
  individual_t.surname
  from client_t, individual_t, company_t
  where client_t.id = individual_t.client_id
  and client_t.id = company_t.client_id;

-- View: company
CREATE VIEW company AS
select
client_t.id,
client_t.address,
company_t.company_name,
company_t.industry
from client_t, company_t
where client_t.id = company_t.client_id;

-- foreign keys
-- Reference: company_t_client_t (table: company_t)
ALTER TABLE company_t ADD CONSTRAINT company_t_client_t
    FOREIGN KEY (id)
    REFERENCES client_t (id);

-- Reference: individual_t_client_t (table: individual_t)
ALTER TABLE individual_t ADD CONSTRAINT individual_t_client_t
    FOREIGN KEY (id)
    REFERENCES client_t (id);

-- End of file.

