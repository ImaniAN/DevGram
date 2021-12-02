-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:30:21.132

-- tables
-- Table: managed_entity_state
CREATE TABLE managed_entity_state (
    due_date date  NULL,
    effective_period_from timestamp  NOT NULL,
    effective_period_to timestamp  NULL,
    notes varchar2(1000)  NULL,
    ID integer  NOT NULL,
    managed_entity_id integer  NOT NULL,
    wf_state_type_state_id integer  NOT NULL,
    wf_state_type_outcome_id integer  NULL,
    wf_state_type_qual_id integer  NULL,
    CONSTRAINT mest_pk PRIMARY KEY (ID)
) ;

CREATE INDEX mest_pkx 
on managed_entity_state 
(ID ASC)
;

CREATE INDEX mest_ref_wfst_code_fkx 
on managed_entity_state 
(wf_state_type_qual_id ASC)
;

CREATE INDEX mest_ref_wfst_outcome_fkx 
on managed_entity_state 
(wf_state_type_outcome_id ASC)
;

CREATE INDEX mest_ref_wfst_state_fkx 
on managed_entity_state 
(wf_state_type_state_id ASC)
;

-- Table: workflow_level_type
CREATE TABLE workflow_level_type (
    alt_sequence smallint  NULL,
    description varchar2(500)  NULL,
    effective_period_from date  NOT NULL,
    effective_period_to date  NULL,
    pretty_name varchar2(100)  NOT NULL,
    type_key varchar2(30)  NOT NULL,
    ID integer  NOT NULL,
    CONSTRAINT wflt_pk PRIMARY KEY (ID)
) ;

-- Table: workflow_state_context
CREATE TABLE workflow_state_context (
    child_disabled char(1)  DEFAULT N NOT NULL,
    ID integer  NOT NULL,
    workflow_state_type_id integer  NOT NULL,
    workflow_state_hierarchy_id integer  NOT NULL,
    CONSTRAINT wfsc_pk PRIMARY KEY (ID)
) ;

CREATE INDEX wfsc_ref_wfsh_fkx 
on workflow_state_context 
(workflow_state_hierarchy_id ASC)
;

CREATE INDEX wfsc_ref_wfst_fkx 
on workflow_state_context 
(workflow_state_type_id ASC)
;

-- Table: workflow_state_hierarchy
CREATE TABLE workflow_state_hierarchy (
    alt_sequence smallint  NULL,
    ID integer  NOT NULL,
    wf_state_type_parent_id integer  NOT NULL,
    wf_state_type_child_id integer  NOT NULL,
    CONSTRAINT wfsh_pk PRIMARY KEY (ID)
) ;

CREATE INDEX wfsh_ref_wfst_child_fkx 
on workflow_state_hierarchy 
(wf_state_type_child_id ASC)
;

CREATE INDEX wfsh_ref_wfst_parent_fkx 
on workflow_state_hierarchy 
(wf_state_type_parent_id ASC)
;

-- Table: workflow_state_option
CREATE TABLE workflow_state_option (
    alt_sequence smallint  NULL,
    ID integer  NOT NULL,
    workflow_state_context_id integer  NOT NULL,
    workflow_state_type_id integer  NOT NULL,
    CONSTRAINT wfso_pk PRIMARY KEY (ID)
) ;

CREATE INDEX wfso_ref_wfsc_fkx 
on workflow_state_option 
(workflow_state_context_id ASC)
;

CREATE INDEX wfso_ref_wfst_fkx 
on workflow_state_option 
(workflow_state_type_id ASC)
;

-- Table: workflow_state_type
CREATE TABLE workflow_state_type (
    alt_sequence smallint  NULL,
    description varchar2(500)  NULL,
    effective_period_from date  NOT NULL,
    effective_period_to date  NULL,
    pretty_name varchar2(100)  NOT NULL,
    type_key varchar2(30)  NOT NULL,
    ID integer  NOT NULL,
    workflow_level_type_id integer  NOT NULL,
    CONSTRAINT wfst_pk PRIMARY KEY (ID)
) ;

CREATE INDEX wfst_ref_wflt_reva_fkx 
on workflow_state_type 
(workflow_level_type_id ASC)
;

CREATE INDEX wfst_eff_per_from_ix 
on workflow_state_type 
(effective_period_from ASC)
;

CREATE INDEX wfst_eff_per_to_ix 
on workflow_state_type 
(effective_period_to ASC)
;

-- Table: your_entity_to_manage
CREATE TABLE your_entity_to_manage (
    your_col_1 integer  NULL,
    your_col_2 integer  NULL,
    your_col_3_etc integer  NULL,
    ID integer  NOT NULL,
    wf_state_type_process_id integer  NULL,
    CONSTRAINT aetm_pk PRIMARY KEY (ID)
) ;

CREATE INDEX aetm_pkx 
on your_entity_to_manage 
(ID ASC)
;

-- foreign keys
-- Reference: mest_ref_aetm_fk (table: managed_entity_state)
ALTER TABLE managed_entity_state ADD CONSTRAINT mest_ref_aetm_fk
    FOREIGN KEY (managed_entity_id)
    REFERENCES your_entity_to_manage (ID)
    DEFERRABLE
     INITIALLY DEFERRED;

-- Reference: mest_ref_wfst_code_fk (table: managed_entity_state)
ALTER TABLE managed_entity_state ADD CONSTRAINT mest_ref_wfst_code_fk
    FOREIGN KEY (wf_state_type_qual_id)
    REFERENCES workflow_state_type (ID)
    DEFERRABLE
     INITIALLY DEFERRED;

-- Reference: mest_ref_wfst_outcome_fk (table: managed_entity_state)
ALTER TABLE managed_entity_state ADD CONSTRAINT mest_ref_wfst_outcome_fk
    FOREIGN KEY (wf_state_type_outcome_id)
    REFERENCES workflow_state_type (ID)
    DEFERRABLE
     INITIALLY DEFERRED;

-- Reference: mest_ref_wfst_state_fk (table: managed_entity_state)
ALTER TABLE managed_entity_state ADD CONSTRAINT mest_ref_wfst_state_fk
    FOREIGN KEY (wf_state_type_state_id)
    REFERENCES workflow_state_type (ID)
    DEFERRABLE
     INITIALLY DEFERRED;

-- Reference: wfsc_ref_wfsh_fk (table: workflow_state_context)
ALTER TABLE workflow_state_context ADD CONSTRAINT wfsc_ref_wfsh_fk
    FOREIGN KEY (workflow_state_hierarchy_id)
    REFERENCES workflow_state_hierarchy (ID)
    DEFERRABLE
     INITIALLY DEFERRED;

-- Reference: wfsc_ref_wfst_fk (table: workflow_state_context)
ALTER TABLE workflow_state_context ADD CONSTRAINT wfsc_ref_wfst_fk
    FOREIGN KEY (workflow_state_type_id)
    REFERENCES workflow_state_type (ID)
    DEFERRABLE
     INITIALLY DEFERRED;

-- Reference: wfsh_ref_wfst_child_fk (table: workflow_state_hierarchy)
ALTER TABLE workflow_state_hierarchy ADD CONSTRAINT wfsh_ref_wfst_child_fk
    FOREIGN KEY (wf_state_type_child_id)
    REFERENCES workflow_state_type (ID)
    DEFERRABLE
     INITIALLY DEFERRED;

-- Reference: wfsh_ref_wfst_parent_fk (table: workflow_state_hierarchy)
ALTER TABLE workflow_state_hierarchy ADD CONSTRAINT wfsh_ref_wfst_parent_fk
    FOREIGN KEY (wf_state_type_parent_id)
    REFERENCES workflow_state_type (ID)
    DEFERRABLE
     INITIALLY DEFERRED;

-- Reference: wfso_ref_wfsc_fk (table: workflow_state_option)
ALTER TABLE workflow_state_option ADD CONSTRAINT wfso_ref_wfsc_fk
    FOREIGN KEY (workflow_state_context_id)
    REFERENCES workflow_state_context (ID)
    DEFERRABLE
     INITIALLY DEFERRED;

-- Reference: wfso_ref_wfst_fk (table: workflow_state_option)
ALTER TABLE workflow_state_option ADD CONSTRAINT wfso_ref_wfst_fk
    FOREIGN KEY (workflow_state_type_id)
    REFERENCES workflow_state_type (ID)
    DEFERRABLE
     INITIALLY DEFERRED;

-- Reference: wfst_ref_wflt_fk (table: workflow_state_type)
ALTER TABLE workflow_state_type ADD CONSTRAINT wfst_ref_wflt_fk
    FOREIGN KEY (workflow_level_type_id)
    REFERENCES workflow_level_type (ID)
    DEFERRABLE
     INITIALLY DEFERRED;

-- sequences
-- Sequence: aetm_seq
CREATE SEQUENCE aetm_seq
      NOMINVALUE
      NOMAXVALUE
      NOCACHE
      NOCYCLE;

-- Sequence: mest_seq
CREATE SEQUENCE mest_seq
      NOMINVALUE
      NOMAXVALUE
      NOCACHE
      NOCYCLE;

-- Sequence: wfsc_seq
CREATE SEQUENCE wfsc_seq
      NOMINVALUE
      NOMAXVALUE
      NOCACHE
      NOCYCLE;

-- Sequence: wfsh_seq
CREATE SEQUENCE wfsh_seq
      NOMINVALUE
      NOMAXVALUE
      NOCACHE
      NOCYCLE;

-- Sequence: wfso_seq
CREATE SEQUENCE wfso_seq
      NOMINVALUE
      NOMAXVALUE
      NOCACHE
      NOCYCLE;

-- Sequence: wfst_seq
CREATE SEQUENCE wfst_seq
      NOMINVALUE
      NOMAXVALUE
      NOCACHE
      NOCYCLE;

-- End of file.

