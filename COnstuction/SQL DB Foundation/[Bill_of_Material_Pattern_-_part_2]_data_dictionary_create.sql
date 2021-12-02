-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:28:17.622

-- tables
-- Table: dd_attr_instance
CREATE TABLE dd_attr_instance (
    attr_instance_id integer  NOT NULL,
    lower_bound char(1)  NULL,
    upper_bound char(1)  NULL,
    attr_id integer  NOT NULL,
    of_class_id integer  NOT NULL,
    type_class_id integer  NOT NULL,
    CONSTRAINT dd_attr_instance_pk PRIMARY KEY (attr_instance_id)
) ;

CREATE INDEX dd_attr_instance_uix 
on dd_attr_instance 
(of_class_id ASC,attr_id ASC)
;

CREATE INDEX dd_dai_ref_dat_fkx 
on dd_attr_instance 
(attr_id ASC)
;

CREATE INDEX dd_dai_ref_dcl_type_fkx 
on dd_attr_instance 
(type_class_id ASC)
;

CREATE INDEX dd_dai_ref_dcl_of_fkx 
on dd_attr_instance 
(of_class_id ASC)
;

-- Table: dd_attribute
CREATE TABLE dd_attribute (
    attr_id integer  NOT NULL,
    attr_name varchar2(64)  NOT NULL,
    notes varchar2(4000)  NULL,
    CONSTRAINT dd_attribute_pk PRIMARY KEY (attr_id)
) ;

CREATE INDEX dd_attribute_uix 
on dd_attribute 
(attr_name ASC)
;

-- Table: dd_class
CREATE TABLE dd_class (
    class_id integer  NOT NULL,
    package_name varchar2(128)  NULL,
    class_name varchar2(64)  NOT NULL,
    class_type varchar2(64)  NOT NULL,
    alias_name varchar2(64)  NULL,
    notes varchar2(4000)  NULL,
    CONSTRAINT dd_class_type_chk CHECK (( class_type IN ( 'CLASS' , 'COLLECTION' , 'OBJECT' , 'NATIVE' , 'TABLE' , 'VIEW' , 'OTHER' ) )),
    CONSTRAINT dd_class_pk PRIMARY KEY (class_id)
) ;

CREATE INDEX dd_class_uix 
on dd_class 
(class_name ASC,class_type ASC)
;

-- foreign keys
-- Reference: dd_dai_ref_dat_fk (table: dd_attr_instance)
ALTER TABLE dd_attr_instance ADD CONSTRAINT dd_dai_ref_dat_fk
    FOREIGN KEY (attr_id)
    REFERENCES dd_attribute (attr_id)
    ON DELETE CASCADE;

-- Reference: dd_dai_ref_dcl_of_fk (table: dd_attr_instance)
ALTER TABLE dd_attr_instance ADD CONSTRAINT dd_dai_ref_dcl_of_fk
    FOREIGN KEY (of_class_id)
    REFERENCES dd_class (class_id)
    ON DELETE CASCADE;

-- Reference: dd_dai_ref_dcl_type_fk (table: dd_attr_instance)
ALTER TABLE dd_attr_instance ADD CONSTRAINT dd_dai_ref_dcl_type_fk
    FOREIGN KEY (type_class_id)
    REFERENCES dd_class (class_id)
    ON DELETE CASCADE;

-- sequences
-- Sequence: dd_attr_instance_seq
CREATE SEQUENCE dd_attr_instance_seq
      NOMINVALUE
      NOMAXVALUE
      NOCACHE
      NOCYCLE;

-- Sequence: dd_attribute_seq
CREATE SEQUENCE dd_attribute_seq
      NOMINVALUE
      NOMAXVALUE
      NOCACHE
      NOCYCLE;

-- Sequence: dd_class_seq
CREATE SEQUENCE dd_class_seq
      NOMINVALUE
      NOMAXVALUE
      NOCACHE
      NOCYCLE;

-- End of file.

