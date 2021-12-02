-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-03-25 12:56:56.804

-- tables
-- Table: attribute
CREATE TABLE attribute (
    id number  NOT NULL,
    attribute_name varchar2(30)  NOT NULL,
    CONSTRAINT attribute_pk PRIMARY KEY (id)
) ;

-- Table: city
CREATE TABLE city (
    id number  NOT NULL,
    city_name varchar2(100)  NOT NULL,
    city_longitude number(2,4)  NOT NULL,
    city_latitude number(2,4)  NOT NULL,
    zip varchar2(10)  NOT NULL,
    country_id number  NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (id)
) ;

-- Table: country
CREATE TABLE country (
    id number  NOT NULL,
    country_name varchar2(100)  NOT NULL,
    CONSTRAINT country_pk PRIMARY KEY (id)
) ;

-- Table: measuring_units
CREATE TABLE measuring_units (
    id number  NOT NULL,
    unit_name varchar2(20)  NOT NULL,
    unit_description varchar2(100)  NOT NULL,
    attribute_id number  NOT NULL,
    CONSTRAINT measuring_units_pk PRIMARY KEY (id)
) ;

-- Table: user_preferences
CREATE TABLE user_preferences (
    users_id number  NOT NULL,
    attribute_id number  NOT NULL,
    measuring_units_id number  NOT NULL,
    CONSTRAINT user_preferences_pk PRIMARY KEY (users_id,attribute_id)
) ;

-- Table: users
CREATE TABLE users (
    id number  NOT NULL,
    email varchar2(255)  NOT NULL,
    contact_number number(10)  NULL,
    CONSTRAINT users_pk PRIMARY KEY (id)
) ;

-- Table: users_city
CREATE TABLE users_city (
    users_id number  NOT NULL,
    city_id number  NOT NULL,
    added_on date  NOT NULL,
    CONSTRAINT users_city_pk PRIMARY KEY (users_id,city_id)
) ;

-- Table: weather_daily_forecast_log
CREATE TABLE weather_daily_forecast_log (
    city_id number  NOT NULL,
    calendar_date date  NOT NULL,
    weather_status_id number  NOT NULL,
    min_temperature number(3,1)  NOT NULL,
    max_temperature number(3,1)  NOT NULL,
    avg_humidity_in_percentage number(3)  NOT NULL,
    sunrise_time timestamp  NOT NULL,
    sunset_time timestamp  NOT NULL,
    last_updated_at timestamp  NOT NULL,
    source_system varchar2(20)  NOT NULL,
    CONSTRAINT weather_daily_forecast_log_pk PRIMARY KEY (city_id,calendar_date)
) ;

-- Table: weather_hourly_forecast_log
CREATE TABLE weather_hourly_forecast_log (
    id number  NOT NULL,
    city_id number  NOT NULL,
    start_timestamp timestamp  NOT NULL,
    end_timestamp timestamp  NOT NULL,
    weather_status_id number  NOT NULL,
    temperature number(3,1)  NOT NULL,
    feels_like_temperature number(2)  NOT NULL,
    humidity_in_percentage number(3)  NOT NULL,
    wind_speed_in_mph number(2,2)  NOT NULL,
    wind_direction char(2)  NOT NULL,
    pressure_in_mmhg number(2,2)  NOT NULL,
    visibility_in_mph number(2,2)  NOT NULL,
    CONSTRAINT weather_hourly_forecast_log_pk PRIMARY KEY (id)
) ;

-- Table: weather_status
CREATE TABLE weather_status (
    id number  NOT NULL,
    weather_status varchar2(30)  NOT NULL,
    CONSTRAINT weather_status_pk PRIMARY KEY (id)
) ;

-- foreign keys
-- Reference: city_country (table: city)
ALTER TABLE city ADD CONSTRAINT city_country
    FOREIGN KEY (country_id)
    REFERENCES country (id);

-- Reference: measuring_units_attribute (table: measuring_units)
ALTER TABLE measuring_units ADD CONSTRAINT measuring_units_attribute
    FOREIGN KEY (attribute_id)
    REFERENCES attribute (id);

-- Reference: user_pref_measuring_units (table: user_preferences)
ALTER TABLE user_preferences ADD CONSTRAINT user_pref_measuring_units
    FOREIGN KEY (measuring_units_id)
    REFERENCES measuring_units (id);

-- Reference: user_preferences_attribute (table: user_preferences)
ALTER TABLE user_preferences ADD CONSTRAINT user_preferences_attribute
    FOREIGN KEY (attribute_id)
    REFERENCES attribute (id);

-- Reference: user_preferences_users (table: user_preferences)
ALTER TABLE user_preferences ADD CONSTRAINT user_preferences_users
    FOREIGN KEY (users_id)
    REFERENCES users (id);

-- Reference: users_city_city (table: users_city)
ALTER TABLE users_city ADD CONSTRAINT users_city_city
    FOREIGN KEY (city_id)
    REFERENCES city (id);

-- Reference: users_city_users (table: users_city)
ALTER TABLE users_city ADD CONSTRAINT users_city_users
    FOREIGN KEY (users_id)
    REFERENCES users (id);

-- Reference: w_daily_logs_w_status (table: weather_daily_forecast_log)
ALTER TABLE weather_daily_forecast_log ADD CONSTRAINT w_daily_logs_w_status
    FOREIGN KEY (weather_status_id)
    REFERENCES weather_status (id);

-- Reference: w_hourly_logs_w_status (table: weather_hourly_forecast_log)
ALTER TABLE weather_hourly_forecast_log ADD CONSTRAINT w_hourly_logs_w_status
    FOREIGN KEY (weather_status_id)
    REFERENCES weather_status (id);

-- Reference: weather_daily_logs_city (table: weather_daily_forecast_log)
ALTER TABLE weather_daily_forecast_log ADD CONSTRAINT weather_daily_logs_city
    FOREIGN KEY (city_id)
    REFERENCES city (id);

-- Reference: weather_hourly_logs_city (table: weather_hourly_forecast_log)
ALTER TABLE weather_hourly_forecast_log ADD CONSTRAINT weather_hourly_logs_city
    FOREIGN KEY (city_id)
    REFERENCES city (id);

-- End of file.

