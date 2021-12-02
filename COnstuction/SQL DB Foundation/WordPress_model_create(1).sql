-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:32:37.364

-- tables
-- Table: wp_commentmeta
CREATE TABLE wp_commentmeta (
    meta_id bigint(20) NOT NULL,
    comment_id bigint(20) NOT NULL DEFAULT '0',
    meta_key varchar(255) COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    meta_value longtext COLLATE utf8mb4_unicode_ci NULL,
    CONSTRAINT wp_commentmeta_pk PRIMARY KEY (meta_id)
) ENGINE InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE INDEX comment_id ON wp_commentmeta (comment_id);

CREATE INDEX meta_key ON wp_commentmeta (meta_key);

-- Table: wp_comments
CREATE TABLE wp_comments (
    comment_ID bigint(20) NOT NULL,
    comment_post_ID bigint(20) NOT NULL DEFAULT '0',
    comment_author tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
    comment_author_email varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    comment_author_url varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    comment_author_IP varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    comment_date datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    comment_date_gmt datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    comment_content text COLLATE utf8mb4_unicode_ci NOT NULL,
    comment_karma int(11) NOT NULL DEFAULT '0',
    comment_approved varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
    comment_agent varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    comment_type varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    comment_parent bigint(20) NOT NULL DEFAULT '0',
    user_id bigint(20) NOT NULL DEFAULT '0',
    CONSTRAINT wp_comments_pk PRIMARY KEY (comment_ID)
) ENGINE InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE INDEX comment_post_ID ON wp_comments (comment_post_ID);

CREATE INDEX comment_approved_date_gmt ON wp_comments (comment_approved,comment_date_gmt);

CREATE INDEX comment_date_gmt ON wp_comments (comment_date_gmt);

CREATE INDEX comment_parent ON wp_comments (comment_parent);

CREATE INDEX comment_author_email ON wp_comments (comment_author_email);

-- Table: wp_links
CREATE TABLE wp_links (
    link_id bigint(20) NOT NULL,
    link_url varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    link_name varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    link_image varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    link_target varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    link_description varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    link_visible varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Y',
    link_owner bigint(20) NOT NULL DEFAULT '1',
    link_rating int(11) NOT NULL DEFAULT '0',
    link_updated datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    link_rel varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    link_notes mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
    link_rss varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    CONSTRAINT wp_links_pk PRIMARY KEY (link_id)
) ENGINE InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE INDEX link_visible ON wp_links (link_visible);

-- Table: wp_options
CREATE TABLE wp_options (
    option_id bigint(20) NOT NULL,
    option_name varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    option_value longtext COLLATE utf8mb4_unicode_ci NOT NULL,
    autoload varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'yes',
    UNIQUE INDEX option_name (option_name),
    CONSTRAINT wp_options_pk PRIMARY KEY (option_id)
) ENGINE InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Table: wp_postmeta
CREATE TABLE wp_postmeta (
    meta_id bigint(20) NOT NULL,
    post_id bigint(20) NOT NULL DEFAULT '0',
    meta_key varchar(255) COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    meta_value longtext COLLATE utf8mb4_unicode_ci NULL,
    CONSTRAINT wp_postmeta_pk PRIMARY KEY (meta_id)
) ENGINE InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE INDEX post_id ON wp_postmeta (post_id);

CREATE INDEX meta_key ON wp_postmeta (meta_key);

-- Table: wp_posts
CREATE TABLE wp_posts (
    ID bigint(20) NOT NULL,
    post_author bigint(20) NOT NULL DEFAULT '0',
    post_date datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    post_date_gmt datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    post_content longtext COLLATE utf8mb4_unicode_ci NOT NULL,
    post_title text COLLATE utf8mb4_unicode_ci NOT NULL,
    post_excerpt text COLLATE utf8mb4_unicode_ci NOT NULL,
    post_status varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'publish',
    comment_status varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
    ping_status varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
    post_password varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    post_name varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    to_ping text COLLATE utf8mb4_unicode_ci NOT NULL,
    pinged text COLLATE utf8mb4_unicode_ci NOT NULL,
    post_modified datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    post_modified_gmt datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    post_content_filtered longtext COLLATE utf8mb4_unicode_ci NOT NULL,
    post_parent bigint(20) NOT NULL DEFAULT '0',
    guid varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    menu_order int(11) NOT NULL DEFAULT '0',
    post_type varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'post',
    post_mime_type varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    comment_count bigint(20) NOT NULL DEFAULT '0',
    CONSTRAINT wp_posts_pk PRIMARY KEY (ID)
) ENGINE InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE INDEX post_name ON wp_posts (post_name);

CREATE INDEX type_status_date ON wp_posts (post_type,post_status,post_date,ID);

CREATE INDEX post_parent ON wp_posts (post_parent);

CREATE INDEX post_author ON wp_posts (post_author);

-- Table: wp_term_relationships
CREATE TABLE wp_term_relationships (
    object_id bigint(20) NOT NULL DEFAULT '0',
    term_taxonomy_id bigint(20) NOT NULL DEFAULT '0',
    term_order int(11) NOT NULL DEFAULT '0',
    CONSTRAINT wp_term_relationships_pk PRIMARY KEY (object_id,term_taxonomy_id)
) ENGINE InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE INDEX term_taxonomy_id ON wp_term_relationships (term_taxonomy_id);

-- Table: wp_term_taxonomy
CREATE TABLE wp_term_taxonomy (
    term_taxonomy_id bigint(20) NOT NULL,
    term_id bigint(20) NOT NULL DEFAULT '0',
    taxonomy varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description longtext COLLATE utf8mb4_unicode_ci NOT NULL,
    parent bigint(20) NOT NULL DEFAULT '0',
    count bigint(20) NOT NULL DEFAULT '0',
    UNIQUE INDEX term_id_taxonomy (term_id,taxonomy),
    CONSTRAINT wp_term_taxonomy_pk PRIMARY KEY (term_taxonomy_id)
) ENGINE InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE INDEX taxonomy ON wp_term_taxonomy (taxonomy);

-- Table: wp_terms
CREATE TABLE wp_terms (
    term_id bigint(20) NOT NULL,
    name varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    slug varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    term_group bigint(10) NOT NULL DEFAULT '0',
    CONSTRAINT wp_terms_pk PRIMARY KEY (term_id)
) ENGINE InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE INDEX slug ON wp_terms (slug);

CREATE INDEX name ON wp_terms (name);

-- Table: wp_usermeta
CREATE TABLE wp_usermeta (
    umeta_id bigint(20) NOT NULL,
    user_id bigint(20) NOT NULL DEFAULT '0',
    meta_key varchar(255) COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    meta_value longtext COLLATE utf8mb4_unicode_ci NULL,
    CONSTRAINT wp_usermeta_pk PRIMARY KEY (umeta_id)
) ENGINE InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE INDEX user_id ON wp_usermeta (user_id);

CREATE INDEX meta_key ON wp_usermeta (meta_key);

-- Table: wp_users
CREATE TABLE wp_users (
    ID bigint(20) NOT NULL,
    user_login varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    user_pass varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    user_nicename varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    user_email varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    user_url varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    user_registered datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    user_activation_key varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    user_status int(11) NOT NULL DEFAULT '0',
    display_name varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    CONSTRAINT wp_users_pk PRIMARY KEY (ID)
) ENGINE InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE INDEX user_login_key ON wp_users (user_login);

CREATE INDEX user_nicename ON wp_users (user_nicename);

-- End of file.

