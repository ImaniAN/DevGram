-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:26:26.47

-- tables
-- Table: hierarchy
CREATE TABLE hierarchy (
    quantity int  NOT NULL
);

-- Table: part
CREATE TABLE part (
    part_num varchar(%)  NOT NULL,
    part_name varchar(%)  NOT NULL
);

-- foreign keys
-- Reference: hierarchy_part (table: hierarchy)
ALTER TABLE hierarchy ADD CONSTRAINT hierarchy_part
    FOREIGN KEY ()
    REFERENCES part ()  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: hierarchy_part (table: hierarchy)
ALTER TABLE hierarchy ADD CONSTRAINT hierarchy_part
    FOREIGN KEY ()
    REFERENCES part ()  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

