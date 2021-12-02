-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:25:55.783

-- tables
-- Table: hierarchy
CREATE TABLE hierarchy (
    quantity int  NOT NULL
) ;

-- Table: part
CREATE TABLE part (
    part_num varchar(20)  NOT NULL,
    part_name varchar(20)  NOT NULL
) ;

-- foreign keys
-- Reference: hierarchy_part (table: hierarchy)
ALTER TABLE hierarchy ADD CONSTRAINT hierarchy_part
    FOREIGN KEY ()
    REFERENCES part ();

-- Reference: hierarchy_part (table: hierarchy)
ALTER TABLE hierarchy ADD CONSTRAINT hierarchy_part
    FOREIGN KEY ()
    REFERENCES part ();

-- End of file.

