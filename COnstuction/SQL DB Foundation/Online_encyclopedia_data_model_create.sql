-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:08:34.277

-- tables
-- Table: article
CREATE TABLE article (
    id int NOT NULL AUTO_INCREMENT,
    article_url text NOT NULL,
    article_title varchar(255) NOT NULL,
    article_text text NOT NULL,
    time_created timestamp NOT NULL,
    time_updated timestamp NOT NULL,
    time_published timestamp NOT NULL,
    default_language_id int NOT NULL,
    UNIQUE INDEX article_ak_1 (article_url),
    CONSTRAINT article_pk PRIMARY KEY (id)
);

-- Table: article_translation
CREATE TABLE article_translation (
    id int NOT NULL AUTO_INCREMENT,
    article_id int NOT NULL,
    language_id int NOT NULL,
    article_url text NOT NULL,
    article_title varchar(255) NOT NULL,
    article_text text NOT NULL,
    time_created timestamp NOT NULL,
    time_updated timestamp NOT NULL,
    time_published timestamp NOT NULL,
    UNIQUE INDEX article_translation_ak_1 (article_id,language_id),
    CONSTRAINT article_translation_pk PRIMARY KEY (id)
);

-- Table: associated_subcategory
CREATE TABLE associated_subcategory (
    id int NOT NULL AUTO_INCREMENT,
    article_id int NOT NULL,
    subcategory_id int NOT NULL,
    UNIQUE INDEX associated_subcategory_ak_1 (article_id,subcategory_id),
    CONSTRAINT associated_subcategory_pk PRIMARY KEY (id)
);

-- Table: associated_tag
CREATE TABLE associated_tag (
    id int NOT NULL AUTO_INCREMENT,
    article_id int NOT NULL,
    tag_id int NOT NULL,
    UNIQUE INDEX associated_tag_ak_1 (article_id,tag_id),
    CONSTRAINT associated_tag_pk PRIMARY KEY (id)
);

-- Table: author
CREATE TABLE author (
    id int NOT NULL AUTO_INCREMENT,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    CONSTRAINT author_pk PRIMARY KEY (id)
);

-- Table: category
CREATE TABLE category (
    id int NOT NULL AUTO_INCREMENT,
    category_name varchar(128) NOT NULL,
    UNIQUE INDEX category_ak_1 (category_name),
    CONSTRAINT category_pk PRIMARY KEY (id)
);

-- Table: language
CREATE TABLE language (
    id int NOT NULL AUTO_INCREMENT,
    language_code varchar(8) NOT NULL,
    language_name varchar(64) NOT NULL,
    UNIQUE INDEX language_ak_1 (language_code),
    UNIQUE INDEX language_ak_2 (language_name),
    CONSTRAINT language_pk PRIMARY KEY (id)
);

-- Table: modification
CREATE TABLE modification (
    id int NOT NULL AUTO_INCREMENT,
    article_id int NOT NULL,
    article_translation_id int NULL,
    modification_type_id int NOT NULL,
    time_modified timestamp NOT NULL,
    author_id int NOT NULL,
    details text NOT NULL,
    CONSTRAINT modification_pk PRIMARY KEY (id)
);

-- Table: modification_type
CREATE TABLE modification_type (
    id int NOT NULL AUTO_INCREMENT,
    type_name varchar(32) NOT NULL,
    UNIQUE INDEX modification_type_ak_1 (type_name),
    CONSTRAINT modification_type_pk PRIMARY KEY (id)
);

-- Table: related_article
CREATE TABLE related_article (
    id int NOT NULL AUTO_INCREMENT,
    article_id int NOT NULL,
    related_article_id int NOT NULL,
    UNIQUE INDEX related_article_ak_1 (article_id,related_article_id),
    CONSTRAINT related_article_pk PRIMARY KEY (id)
);

-- Table: related_author
CREATE TABLE related_author (
    id int NOT NULL AUTO_INCREMENT,
    article_id int NOT NULL,
    author_id int NOT NULL,
    UNIQUE INDEX related_author_ak_1 (article_id,author_id),
    CONSTRAINT related_author_pk PRIMARY KEY (id)
);

-- Table: subcategory
CREATE TABLE subcategory (
    id int NOT NULL AUTO_INCREMENT,
    subcategory_name varchar(128) NOT NULL,
    category_id int NOT NULL,
    UNIQUE INDEX subcategory_ak_1 (subcategory_name),
    CONSTRAINT subcategory_pk PRIMARY KEY (id)
);

-- Table: tag
CREATE TABLE tag (
    id int NOT NULL AUTO_INCREMENT,
    tag_name varchar(32) NOT NULL,
    UNIQUE INDEX tag_ak_1 (tag_name),
    CONSTRAINT tag_pk PRIMARY KEY (id)
);

-- Table: translated
CREATE TABLE translated (
    id int NOT NULL AUTO_INCREMENT,
    article_translation_id int NOT NULL,
    author_id int NOT NULL,
    time_translated timestamp NOT NULL,
    UNIQUE INDEX translated_ak_1 (article_translation_id,author_id),
    CONSTRAINT translated_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: article_language (table: article)
ALTER TABLE article ADD CONSTRAINT article_language FOREIGN KEY article_language (default_language_id)
    REFERENCES language (id);

-- Reference: article_translation_article (table: article_translation)
ALTER TABLE article_translation ADD CONSTRAINT article_translation_article FOREIGN KEY article_translation_article (article_id)
    REFERENCES article (id);

-- Reference: article_translation_language (table: article_translation)
ALTER TABLE article_translation ADD CONSTRAINT article_translation_language FOREIGN KEY article_translation_language (language_id)
    REFERENCES language (id);

-- Reference: associated_subcategory_article (table: associated_subcategory)
ALTER TABLE associated_subcategory ADD CONSTRAINT associated_subcategory_article FOREIGN KEY associated_subcategory_article (article_id)
    REFERENCES article (id);

-- Reference: associated_subcategory_subcategory (table: associated_subcategory)
ALTER TABLE associated_subcategory ADD CONSTRAINT associated_subcategory_subcategory FOREIGN KEY associated_subcategory_subcategory (subcategory_id)
    REFERENCES subcategory (id);

-- Reference: associated_tag_article (table: associated_tag)
ALTER TABLE associated_tag ADD CONSTRAINT associated_tag_article FOREIGN KEY associated_tag_article (article_id)
    REFERENCES article (id);

-- Reference: associated_tag_tag (table: associated_tag)
ALTER TABLE associated_tag ADD CONSTRAINT associated_tag_tag FOREIGN KEY associated_tag_tag (tag_id)
    REFERENCES tag (id);

-- Reference: modification_article (table: modification)
ALTER TABLE modification ADD CONSTRAINT modification_article FOREIGN KEY modification_article (article_id)
    REFERENCES article (id);

-- Reference: modification_article_translation (table: modification)
ALTER TABLE modification ADD CONSTRAINT modification_article_translation FOREIGN KEY modification_article_translation (article_translation_id)
    REFERENCES article_translation (id);

-- Reference: modification_author (table: modification)
ALTER TABLE modification ADD CONSTRAINT modification_author FOREIGN KEY modification_author (author_id)
    REFERENCES author (id);

-- Reference: modification_modification_type (table: modification)
ALTER TABLE modification ADD CONSTRAINT modification_modification_type FOREIGN KEY modification_modification_type (modification_type_id)
    REFERENCES modification_type (id);

-- Reference: related_article_article1 (table: related_article)
ALTER TABLE related_article ADD CONSTRAINT related_article_article1 FOREIGN KEY related_article_article1 (article_id)
    REFERENCES article (id);

-- Reference: related_article_article2 (table: related_article)
ALTER TABLE related_article ADD CONSTRAINT related_article_article2 FOREIGN KEY related_article_article2 (related_article_id)
    REFERENCES article (id);

-- Reference: related_author_article (table: related_author)
ALTER TABLE related_author ADD CONSTRAINT related_author_article FOREIGN KEY related_author_article (article_id)
    REFERENCES article (id);

-- Reference: related_author_author (table: related_author)
ALTER TABLE related_author ADD CONSTRAINT related_author_author FOREIGN KEY related_author_author (author_id)
    REFERENCES author (id);

-- Reference: subcategory_category (table: subcategory)
ALTER TABLE subcategory ADD CONSTRAINT subcategory_category FOREIGN KEY subcategory_category (category_id)
    REFERENCES category (id);

-- Reference: translated_article_translation (table: translated)
ALTER TABLE translated ADD CONSTRAINT translated_article_translation FOREIGN KEY translated_article_translation (article_translation_id)
    REFERENCES article_translation (id);

-- Reference: translated_author (table: translated)
ALTER TABLE translated ADD CONSTRAINT translated_author FOREIGN KEY translated_author (author_id)
    REFERENCES author (id);

-- End of file.

