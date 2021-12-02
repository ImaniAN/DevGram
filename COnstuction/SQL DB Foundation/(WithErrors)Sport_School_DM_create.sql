-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 13:02:02.222

-- tables
-- Table: attendance
CREATE TABLE attendance (
    player_id int NOT NULL,
    practice_id int NOT NULL,
    CONSTRAINT attendance_pk PRIMARY KEY (player_id)
);

CREATE INDEX fk_player_has_practice_practice1_idx ON attendance ();

CREATE INDEX fk_player_has_practice_player1_idx ON attendance (player_id);

-- Table: coach
CREATE TABLE coach (
    id int NOT NULL,
    name varchar(100) NOT NULL,
    CONSTRAINT coach_pk PRIMARY KEY (id)
);

-- Table: condition_test
CREATE TABLE condition_test (
    id int NOT NULL,
    player_id int NOT NULL,
    practice_id int NOT NULL,
    m60_run_time varchar(32) NULL,
    pull_ups_in_30s int NULL,
    CONSTRAINT condition_test_pk PRIMARY KEY (id)
);

CREATE INDEX fk_condition_test_player1_idx ON condition_test (player_id);

CREATE INDEX fk_condition_test_practice1_idx ON condition_test (practice_id);

-- Table: equipment
CREATE TABLE equipment (
    id int NOT NULL,
    equipment_type_id int NOT NULL,
    CONSTRAINT equipment_pk PRIMARY KEY (id)
);

CREATE INDEX fk_equipment_equipment_type1_idx ON equipment ();

-- Table: equipment_orders
CREATE TABLE equipment_orders (
    id int NOT NULL,
    equipment_type_id int NOT NULL,
    amount int NOT NULL,
    coach_id int NOT NULL,
    status varchar(32) NOT NULL,
    CONSTRAINT equipment_orders_pk PRIMARY KEY (id)
);

CREATE INDEX fk_equipment_orders_equipment_type1_idx ON equipment_orders (equipment_type_id);

CREATE INDEX fk_equipment_orders_coach1_idx ON equipment_orders (coach_id);

-- Table: equipment_type
CREATE TABLE equipment_type (
    id int NOT NULL,
    name varchar(100) NOT NULL,
    CONSTRAINT equipment_type_pk PRIMARY KEY (id)
);

-- Table: equipment_usage
CREATE TABLE equipment_usage (
    equipment_id int NOT NULL,
    coach_id int NOT NULL,
    `from` date NOT NULL,
    `to` date NULL,
    CONSTRAINT equipment_usage_pk PRIMARY KEY (equipment_id,coach_id)
);

CREATE INDEX fk_equipment_has_coach_coach1_idx ON equipment_usage (coach_id);

CREATE INDEX fk_equipment_has_coach_equipment1_idx ON equipment_usage (equipment_id);

-- Table: payments
CREATE TABLE payments (
    month int NOT NULL,
    year int NOT NULL,
    player_id int NOT NULL,
    amount decimal(7,2) NOT NULL,
    status varchar(45) NOT NULL,
    CONSTRAINT payments_pk PRIMARY KEY (month,year,player_id)
);

CREATE INDEX fk_payments_player1_idx ON payments (player_id);

-- Table: pitch
CREATE TABLE pitch (
    id int NOT NULL,
    location varchar(255) NOT NULL,
    CONSTRAINT pitch_pk PRIMARY KEY (id)
);

-- Table: player
CREATE TABLE player (
    id int NOT NULL,
    name varchar(100) NOT NULL,
    date_of_birth date NOT NULL,
    contact_number varchar(32) NOT NULL,
    notes text NULL,
    team_id int NULL,
    CONSTRAINT player_pk PRIMARY KEY (id)
);

CREATE INDEX fk_player_team1_idx ON player (team_id);

-- Table: practice
CREATE TABLE practice (
    id int NOT NULL,
    date date NOT NULL,
    hour time NOT NULL,
    team_id int NOT NULL,
    pitch_id int NOT NULL,
    coach_id int NOT NULL,
    CONSTRAINT practice_pk PRIMARY KEY (id)
);

CREATE INDEX fk_practice_team1_idx ON practice (team_id);

CREATE INDEX fk_practice_pitch1_idx ON practice (pitch_id);

CREATE INDEX fk_practice_coach1_idx ON practice (coach_id);

-- Table: team
CREATE TABLE team (
    id int NOT NULL,
    team_name varchar(100) NOT NULL,
    coach_id int NOT NULL,
    CONSTRAINT team_pk PRIMARY KEY (id)
);

CREATE INDEX fk_team_coach1_idx ON team (coach_id);

-- foreign keys
-- Reference: fk_condition_test_player1 (table: condition_test)
ALTER TABLE condition_test ADD CONSTRAINT fk_condition_test_player1 FOREIGN KEY fk_condition_test_player1 (player_id)
    REFERENCES player (id);

-- Reference: fk_condition_test_practice1 (table: condition_test)
ALTER TABLE condition_test ADD CONSTRAINT fk_condition_test_practice1 FOREIGN KEY fk_condition_test_practice1 (practice_id)
    REFERENCES practice (id);

-- Reference: fk_equipment_equipment_type1 (table: equipment)
ALTER TABLE equipment ADD CONSTRAINT fk_equipment_equipment_type1 FOREIGN KEY fk_equipment_equipment_type1 (equipment_type_id)
    REFERENCES equipment_type (id);

-- Reference: fk_equipment_has_coach_coach1 (table: equipment_usage)
ALTER TABLE equipment_usage ADD CONSTRAINT fk_equipment_has_coach_coach1 FOREIGN KEY fk_equipment_has_coach_coach1 (coach_id)
    REFERENCES coach (id);

-- Reference: fk_equipment_has_coach_equipment1 (table: equipment_usage)
ALTER TABLE equipment_usage ADD CONSTRAINT fk_equipment_has_coach_equipment1 FOREIGN KEY fk_equipment_has_coach_equipment1 (equipment_id)
    REFERENCES equipment (id);

-- Reference: fk_equipment_orders_coach1 (table: equipment_orders)
ALTER TABLE equipment_orders ADD CONSTRAINT fk_equipment_orders_coach1 FOREIGN KEY fk_equipment_orders_coach1 (coach_id)
    REFERENCES coach (id);

-- Reference: fk_equipment_orders_equipment_type1 (table: equipment_orders)
ALTER TABLE equipment_orders ADD CONSTRAINT fk_equipment_orders_equipment_type1 FOREIGN KEY fk_equipment_orders_equipment_type1 (equipment_type_id)
    REFERENCES equipment_type (id);

-- Reference: fk_payments_player1 (table: payments)
ALTER TABLE payments ADD CONSTRAINT fk_payments_player1 FOREIGN KEY fk_payments_player1 (player_id)
    REFERENCES player (id);

-- Reference: fk_player_has_practice_player1 (table: attendance)
ALTER TABLE attendance ADD CONSTRAINT fk_player_has_practice_player1 FOREIGN KEY fk_player_has_practice_player1 (player_id)
    REFERENCES player (id);

-- Reference: fk_player_has_practice_practice1 (table: attendance)
ALTER TABLE attendance ADD CONSTRAINT fk_player_has_practice_practice1 FOREIGN KEY fk_player_has_practice_practice1 (<EMPTY>)
    REFERENCES practice (id);

-- Reference: fk_player_team1 (table: player)
ALTER TABLE player ADD CONSTRAINT fk_player_team1 FOREIGN KEY fk_player_team1 (team_id)
    REFERENCES team (id);

-- Reference: fk_practice_coach1 (table: practice)
ALTER TABLE practice ADD CONSTRAINT fk_practice_coach1 FOREIGN KEY fk_practice_coach1 (coach_id)
    REFERENCES coach (id);

-- Reference: fk_practice_pitch1 (table: practice)
ALTER TABLE practice ADD CONSTRAINT fk_practice_pitch1 FOREIGN KEY fk_practice_pitch1 (pitch_id)
    REFERENCES pitch (id);

-- Reference: fk_practice_team1 (table: practice)
ALTER TABLE practice ADD CONSTRAINT fk_practice_team1 FOREIGN KEY fk_practice_team1 (team_id)
    REFERENCES team (id);

-- Reference: fk_team_coach1 (table: team)
ALTER TABLE team ADD CONSTRAINT fk_team_coach1 FOREIGN KEY fk_team_coach1 (coach_id)
    REFERENCES coach (id);

-- End of file.

