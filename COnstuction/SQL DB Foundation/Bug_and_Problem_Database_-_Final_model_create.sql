-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:46:58.931

-- tables
-- Table: asset
CREATE TABLE asset (
    id bigint NOT NULL,
    asset_name varchar(250) NOT NULL,
    asset_description text NOT NULL,
    UNIQUE INDEX Asset_ak_1 (asset_name),
    CONSTRAINT asset_pk PRIMARY KEY (id)
) COMMENT 'An asset is either physical or intellectual property that may incur or relate to a problem.';

-- Table: circumstance
CREATE TABLE circumstance (
    id bigint NOT NULL,
    derived_from_circumstance_id bigint NULL,
    name varchar(150) NOT NULL,
    description text NOT NULL,
    CONSTRAINT circumstance_pk PRIMARY KEY (id)
) COMMENT 'Describes the location and context for a report.  Note this may also be a template or otherwise reusable for different reports.';

-- Table: condition
CREATE TABLE `condition` (
    circumstance_id bigint NOT NULL,
    condition_label int NOT NULL,
    condition_data_type_id bigint NOT NULL,
    condition_scalar_whole int NULL,
    condition_scalar_real double NULL,
    condition_text varchar(500) NULL,
    CONSTRAINT condition_pk PRIMARY KEY (circumstance_id,condition_label)
) COMMENT 'A measurement or observation characterizing the circumstance of a report';

-- Table: data_type
CREATE TABLE data_type (
    id bigint NOT NULL,
    mime_type varchar(150) NOT NULL,
    description text NOT NULL,
    handle varchar(100) NOT NULL COMMENT 'Language- and locale-independent identifier for the data type',
    name varchar(150) NOT NULL,
    UNIQUE INDEX data_types_uk_1 (handle),
    UNIQUE INDEX data_types_uk_2 (name),
    CONSTRAINT data_type_pk PRIMARY KEY (id)
) COMMENT 'records data types for measurements, data captures, and such';

-- Table: enclosure_type
CREATE TABLE enclosure_type (
    id bigint NOT NULL,
    encl_type_handle varchar(100) NOT NULL,
    encl_type_label varchar(150) NOT NULL,
    encl_type_description text NOT NULL,
    CONSTRAINT enclosure_type_pk PRIMARY KEY (id)
);

-- Table: package
CREATE TABLE package (
    enclosing_asset_id bigint NOT NULL,
    referenced_asset_id bigint NOT NULL,
    enclosure_type_id bigint NOT NULL,
    enclosure_seq int NOT NULL,
    CONSTRAINT package_pk PRIMARY KEY (enclosing_asset_id,referenced_asset_id,enclosure_type_id,enclosure_seq)
);

-- Table: person
CREATE TABLE person (
    id bigint NOT NULL,
    email varchar(1000) NULL,
    family_name varchar(100) NULL,
    given_name varchar(100) NOT NULL,
    CONSTRAINT person_pk PRIMARY KEY (id)
) COMMENT 'Someone who might encounter, report, analyze, fix, test a problem';

-- Table: problem
CREATE TABLE problem (
    id bigint NOT NULL,
    summary varchar(150) NOT NULL,
    creation timestamp NOT NULL,
    modification timestamp NOT NULL,
    Status varchar(100) NOT NULL,
    Severity bigint NOT NULL,
    asset_id bigint NOT NULL,
    CONSTRAINT problem_pk PRIMARY KEY (id)
) COMMENT 'Describes some observation, event, happening or condition we need to resolve';

-- Table: problem_aspect
CREATE TABLE problem_aspect (
    problem_id bigint NOT NULL,
    association_label varchar(150) NOT NULL,
    description text NOT NULL,
    report_id bigint NOT NULL,
    finding_seq bigint NOT NULL,
    aspect_handle varchar(100) NOT NULL,
    CONSTRAINT problem_aspect_pk PRIMARY KEY (problem_id)
) COMMENT 'Lists one aspect of a problem - it may have several';

-- Table: problem_aspect_type
CREATE TABLE problem_aspect_type (
    handle varchar(100) NOT NULL,
    description text NOT NULL,
    CONSTRAINT problem_aspect_type_pk PRIMARY KEY (handle)
) COMMENT 'Describes the sorts of ways in which a report/finding may associate the report with a particular problem';

-- Table: report
CREATE TABLE report (
    id bigint NOT NULL,
    reporter bigint NOT NULL,
    headline varchar(150) NOT NULL,
    creation timestamp NOT NULL,
    as_of_datetime datetime NOT NULL,
    precis text NOT NULL,
    report_circumstance_id bigint NOT NULL,
    CONSTRAINT report_pk PRIMARY KEY (id)
) COMMENT 'Describes an event that occurs, or a measurement or observation that may be relevant to a problem.  A report may consist of several measurements, comments, etc.';

-- Table: report_finding
CREATE TABLE report_finding (
    report_id bigint NOT NULL,
    finding_seq bigint NOT NULL,
    creation timestamp NOT NULL,
    data_type_id bigint NOT NULL,
    scalar_unit_id bigint NOT NULL,
    scalar_value_whole bigint NULL,
    scalar_value_real double NULL,
    content_value blob NULL,
    Status varchar(100) NULL,
    Severity bigint NULL,
    asset_id bigint NULL,
    CONSTRAINT report_finding_pk PRIMARY KEY (report_id,finding_seq)
) COMMENT 'A file, image, measurement, or other datum associated with a report';

-- Table: severity
CREATE TABLE severity (
    id bigint NOT NULL,
    severity_ordering int NOT NULL,
    severity_handle varchar(100) NOT NULL,
    severity_label varchar(150) NOT NULL,
    description text NOT NULL,
    CONSTRAINT severity_pk PRIMARY KEY (id)
) COMMENT 'How seriously the problem affects some operation or another';

-- Table: status
CREATE TABLE status (
    handle varchar(100) NOT NULL,
    status_ordering int NULL,
    status_description text NULL,
    UNIQUE INDEX Status_ordering_uk1 (status_ordering),
    CONSTRAINT status_pk PRIMARY KEY (handle)
) COMMENT 'The status - open, resolved, etc - of a problem';

-- Table: tag
CREATE TABLE tag (
    id bigint NOT NULL,
    tag_text varchar(150) NULL,
    tag_description varchar(4000) NULL,
    CONSTRAINT tag_pk PRIMARY KEY (id)
) COMMENT 'A means of non-exclusively grouping sets';

-- Table: tag_assignment
CREATE TABLE tag_assignment (
    report_id bigint NOT NULL,
    finding_seq bigint NOT NULL,
    tag_id bigint NOT NULL,
    tagged_by bigint NOT NULL,
    creation timestamp NOT NULL,
    CONSTRAINT tag_assignment_pk PRIMARY KEY (report_id,finding_seq,tag_id)
);

-- Table: unit
CREATE TABLE unit (
    id bigint NOT NULL,
    unit_name varchar(150) NOT NULL,
    description text NOT NULL,
    dimension varchar(100) NULL,
    CONSTRAINT unit_pk PRIMARY KEY (id)
) COMMENT 'A form of ';

-- foreign keys
-- Reference: Circumstance_Circumstance (table: circumstance)
ALTER TABLE circumstance ADD CONSTRAINT Circumstance_Circumstance FOREIGN KEY Circumstance_Circumstance (derived_from_circumstance_id)
    REFERENCES circumstance (id);

-- Reference: Condition_Circumstance (table: condition)
ALTER TABLE `condition` ADD CONSTRAINT Condition_Circumstance FOREIGN KEY Condition_Circumstance (circumstance_id)
    REFERENCES circumstance (id);

-- Reference: Condition_data_types (table: condition)
ALTER TABLE `condition` ADD CONSTRAINT Condition_data_types FOREIGN KEY Condition_data_types (condition_data_type_id)
    REFERENCES data_type (id);

-- Reference: Package_enclosing_Asset (table: package)
ALTER TABLE package ADD CONSTRAINT Package_enclosing_Asset FOREIGN KEY Package_enclosing_Asset (enclosing_asset_id)
    REFERENCES asset (id);

-- Reference: Package_enclosure_type (table: package)
ALTER TABLE package ADD CONSTRAINT Package_enclosure_type FOREIGN KEY Package_enclosure_type (enclosure_type_id)
    REFERENCES enclosure_type (id);

-- Reference: Package_referenced_Asset (table: package)
ALTER TABLE package ADD CONSTRAINT Package_referenced_Asset FOREIGN KEY Package_referenced_Asset (referenced_asset_id)
    REFERENCES asset (id);

-- Reference: ProblemAspect_Problem (table: problem_aspect)
ALTER TABLE problem_aspect ADD CONSTRAINT ProblemAspect_Problem FOREIGN KEY ProblemAspect_Problem (problem_id)
    REFERENCES problem (id);

-- Reference: ProblemAspect_Report_Finding (table: problem_aspect)
ALTER TABLE problem_aspect ADD CONSTRAINT ProblemAspect_Report_Finding FOREIGN KEY ProblemAspect_Report_Finding (report_id,finding_seq)
    REFERENCES report_finding (report_id,finding_seq);

-- Reference: ProblemAspect_problem_associations (table: problem_aspect)
ALTER TABLE problem_aspect ADD CONSTRAINT ProblemAspect_problem_associations FOREIGN KEY ProblemAspect_problem_associations (aspect_handle)
    REFERENCES problem_aspect_type (handle);

-- Reference: Problem_Asset (table: problem)
ALTER TABLE problem ADD CONSTRAINT Problem_Asset FOREIGN KEY Problem_Asset (asset_id)
    REFERENCES asset (id);

-- Reference: Problem_Severity (table: problem)
ALTER TABLE problem ADD CONSTRAINT Problem_Severity FOREIGN KEY Problem_Severity (Severity)
    REFERENCES severity (id);

-- Reference: Problem_Status (table: problem)
ALTER TABLE problem ADD CONSTRAINT Problem_Status FOREIGN KEY Problem_Status (Status)
    REFERENCES status (handle);

-- Reference: Report_Circumstance (table: report)
ALTER TABLE report ADD CONSTRAINT Report_Circumstance FOREIGN KEY Report_Circumstance (report_circumstance_id)
    REFERENCES circumstance (id);

-- Reference: Report_Finding_Asset (table: report_finding)
ALTER TABLE report_finding ADD CONSTRAINT Report_Finding_Asset FOREIGN KEY Report_Finding_Asset (asset_id)
    REFERENCES asset (id);

-- Reference: Report_Finding_Report (table: report_finding)
ALTER TABLE report_finding ADD CONSTRAINT Report_Finding_Report FOREIGN KEY Report_Finding_Report (report_id)
    REFERENCES report (id);

-- Reference: Report_Finding_Severity (table: report_finding)
ALTER TABLE report_finding ADD CONSTRAINT Report_Finding_Severity FOREIGN KEY Report_Finding_Severity (Severity)
    REFERENCES severity (id);

-- Reference: Report_Finding_Status (table: report_finding)
ALTER TABLE report_finding ADD CONSTRAINT Report_Finding_Status FOREIGN KEY Report_Finding_Status (Status)
    REFERENCES status (handle);

-- Reference: Report_Finding_Units (table: report_finding)
ALTER TABLE report_finding ADD CONSTRAINT Report_Finding_Units FOREIGN KEY Report_Finding_Units (scalar_unit_id)
    REFERENCES unit (id);

-- Reference: Report_Finding_data_types (table: report_finding)
ALTER TABLE report_finding ADD CONSTRAINT Report_Finding_data_types FOREIGN KEY Report_Finding_data_types (data_type_id)
    REFERENCES data_type (id);

-- Reference: Report_Person (table: report)
ALTER TABLE report ADD CONSTRAINT Report_Person FOREIGN KEY Report_Person (reporter)
    REFERENCES person (id);

-- Reference: Tag_assignment_Person (table: tag_assignment)
ALTER TABLE tag_assignment ADD CONSTRAINT Tag_assignment_Person FOREIGN KEY Tag_assignment_Person (tagged_by)
    REFERENCES person (id);

-- Reference: Tag_assignment_Report_Finding (table: tag_assignment)
ALTER TABLE tag_assignment ADD CONSTRAINT Tag_assignment_Report_Finding FOREIGN KEY Tag_assignment_Report_Finding (report_id,finding_seq)
    REFERENCES report_finding (report_id,finding_seq);

-- Reference: Tag_assignment_Tag (table: tag_assignment)
ALTER TABLE tag_assignment ADD CONSTRAINT Tag_assignment_Tag FOREIGN KEY Tag_assignment_Tag (tag_id)
    REFERENCES tag (id);

-- End of file.

