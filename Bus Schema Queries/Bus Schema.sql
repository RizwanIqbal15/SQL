/*
CREATING BASIC SCHEMA TABLE
*/
CREATE TABLE USERS(
first_name VARCHAR2(50),
last_name VARCHAR2(50),
password VARCHAR2(50),
email VARCHAR2(50),
mobile_no CHAR(10),
wallet_money NUMBER(10,2),
role_name VARCHAR2(50)
);

CREATE TABLE BUS(
BUS_model VARCHAR2(50),
BUS_owner VARCHAR2(50),
BUS_number CHAR(10),
BUS_type_name VARCHAR2(100),
BUS_category_name VARCHAR2(50),
color VARCHAR2(50),
location VARCHAR2(50),
location_name VARCHAR2(50),
addresss VARCHAR2(100),
city VARCHAR2(50),
pincode CHAR(6),
BUS_image_url VARCHAR2(500),
cost_per_hour NUMBER(10,2),
fuel_type VARCHAR2(50)
);

CREATE TABLE BOOKING(
pickup_date DATE,
dropoff_date DATE,
booking_date DATE,
amount NUMBER(10,2),
location_name VARCHAR2(50)
);

CREATE TABLE REQUEST(
activity_type VARCHAR2(50),
user_comments VARCHAR2(50),
admin_comments VARCHAR2(50),
request_status VARCHAR2(50),
Bus_number VARCHAR2(50),
user_email CHAR(10)
);

--ADDING CONSTRAINTS IN ABOVE TABLES

/*
ALTER TABLE table_name 
ADD column_name data_type constraint;
*/

ALTER TABLE USERS
ADD user_id CHAR(5) PRIMARY KEY ;

desc users;
/*
The basic syntax of an ALTER TABLE command to add a NOT NULL constraint to a column in a table is as follows.
ALTER TABLE table_name MODIFY column_name datatype NOT NULL;
*/
ALTER TABLE USERS
MODIFY first_name VARCHAR2(50) NOT NULL ;

ALTER TABLE USERS
MODIFY PASSWORD VARCHAR2(50) NOT NULL CHECK (Length(PASSWORD) > 5 ) ;

ALTER TABLE USERS
MODIFY EMAIL VARCHAR2(50) NOT NULL UNIQUE

ALTER TABLE USERS
MODIFY MOBILE_NO CHAR(10) NOT NULL UNIQUE

ALTER TABLE USERS
MODIFY WALLET_MONEY NUMBER(10,2) DEFAULT 10000.00

ALTER TABLE USERS
MODIFY ROLE_NAME VARCHAR2(50)  NOT NULL UNIQUE

-- DISPLAY USERS
DESC users;


-- DISPLAY VEHICLE
DESC BUS

-- ADD PRIMARY KEY TO vehicle_id
ALTER TABLE BUS
ADD Bus_id CHAR(5) PRIMARY KEY

-- ADD NOT NULL CONSTRAINT TO MODEL
ALTER TABLE BUS
MODIFY BUS_MODEL VARCHAR2(50) NOT NULL

-- ADD FOREIGN KEY
/*
ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
*/

alter table bus
drop column user_id

ALTER TABLE BUS
ADD USER_ID CHAR(5)

ALTER TABLE BUS
ADD FOREIGN KEY (user_id) REFERENCES USERS(user_id) ;

DESC BUS

-- set Bus_number as primary key
/*
ALTER TABLE Persons
ADD CONSTRAINT PK_Person PRIMARY KEY (ID,LastName);
*/

ALTER TABLE BUS
DROP PRIMARY KEY;

ALTER TABLE BUS
MODIFY BUS_NUMBER CHAR(10) PRIMARY KEY

ALTER TABLE BUS
MODIFY BUS_ID CHAR(5) PRIMARY KEY


ALTER TABLE BUS
MODIFY BUS_TYPE_NAME VARCHAR2(100) NOT NULL UNIQUE

ALTER TABLE BUS
MODIFY BUS_CATEGORY_NAME VARCHAR2(50) NOT NULL UNIQUE

ALTER TABLE BUS
MODIFY COLOR VARCHAR2(50) NOT NULL

ALTER TABLE BUS
MODIFY FUEL_TYPE VARCHAR2(50) NOT NULL UNIQUE

-- Check which column is Primary key (Bus)
SELECT column_name FROM all_cons_columns WHERE constraint_name = (
  SELECT constraint_name FROM all_constraints 
  WHERE UPPER(table_name) = UPPER('bus') AND CONSTRAINT_TYPE = 'P'
);

/*
Modify Multiple columns in table
Syntax
To MODIFY MULTIPLE COLUMNS in an existing table, the Oracle ALTER TABLE syntax is:
ALTER TABLE table_name
  MODIFY (column_1 column_type,
          column_2 column_type,
          ...
          column_n column_type);
*/
ALTER TABLE BUS
MODIFY (
BUS_IMAGE_URL VARCHAR2(500) NOT NULL,
LOCATION_NAME VARCHAR2(50) NOT NULL,
ADDRESSS VARCHAR2(100) NOT NULL,
CITY VARCHAR2(50) NOT NULL,
PINCODE CHAR(6) NOT NULL,
COST_PER_HOUR NUMBER(10,2) NOT NULL
);

DESC BUS

-- BOOKING

desc booking

ALTER TABLE BOOKING
ADD booking_id CHAR(5) PRIMARY KEY

ALTER TABLE BOOKING
MODIFY (
PICKUP_DATE DATE NOT NULL,
DROPOFF_DATE DATE NOT NULL,
BOOKING_DATE DATE NOT NULL,
AMOUNT NUMBER(10,2) NOT NULL
)

-- adding foreign key
ALTER TABLE BOOKING
ADD vehicle_id CHAR(5) NOT NULL 

ALTER TABLE BOOKING 
ADD USER_ID CHAR(5) NOT NULL

-- ADD FOREIGN KEY
/*
ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
*/
ALTER TABLE BOOKING
ADD FOREIGN KEY ( USER_ID )  REFERENCES Users( user_id) 



desc Bus
DESC BOOKING

DESC REQUEST

--Part-2 

CREATE TABLE ROLE(
role_id CHAR(5) PRIMARY KEY,
role_name VARCHAR2(50) NOT NULL UNIQUE
)

CREATE TABLE user_role (
user_id CHAR(5) ,
role_id CHAR(5) ,
FOREIGN KEY ( user_id ) REFERENCES users(user_id),
FOREIGN KEY ( role_id ) REFERENCES role(role_id)
)
ALTER TABLE USER_ROLE
ADD CONSTRAINT user_id_role Primary key ( user_id, role_id );

/*
ALTER TABLE Persons
ADD CONSTRAINT PK_Person PRIMARY KEY (ID,LastName);
1. id p.k
2. model
3. user_id f.k
4. v_number p.k
5. color
6. fuel_type_id f.k
7. locataion_id f.k
8. v_image_url
*/

drop table Bus;

CREATE TABLE Bus(
Bus_id char(5) primary key, -- p.k
Bus_model varchar2(50) not null,
user_id char(5) not null,
foreign key (user_id) REFERENCES Users(user_id),
Bus_number char(10), 
Bus_type_id char(5), 
foreign key (Bus_type_id) references Bus_type( Bus_type_id) ,
color varchar2(50) not null,
fuel_type_id char(5) not null, 
foreign key (fuel_type_id) references fuel_type( fuel_type_id ),
locataion_id char(5) not null, 
FOREIGN key (locataion_id) references location ( location_id ),
Bus_image_url varchar2(500) not null
)
create table requests(
request_id char(5) primary key,
user_id char(5) not null,
foreign key (user_id) references Users(user_id),
activity_id char(5) not null,
foreign key (activity_id) references activity(activity_id),
user_comments varchar2(50),
admin_comments varchar2(50),
request_status_id char(5) not null,
foreign key (request_status_id) references request_status(request_status_id),
Bus_id char(5),
foreign key (Bus_id) references Bus(Bus_id)
)

create table activity(
activity_id char(5) primary key,
activity_type varchar2(50) not null unique
)

create table request_status(
request_status_id char(5) primary key,
request_status_name varchar2(50) not null unique
)

create table city (
city_id char(5) primary key,
city_name varchar2(50) not null
)

create table location (
location_id char(5) primary key,
location_name varchar2(50) not null,
address varchar2(100) not null,
city_id char(5) not null, --f.k
FOREIGN key ( city_id) REFERENCES city(city_id),
pincode char(6) not null
)
desc booking
alter table booking
drop column LOCATION_NAME ;

alter table booking
add foreign key (location_id) references location(location_id);

alter table booking
add location_id char(5);

alter table booking
modify location_id char(5) not null ;

create table  fuel_type(
fuel_type_id char(5) primary key,
fuel_type varchar2(50) not null unique
)

create table Bus_category (
Bus_category char(5) primary key,
Bus_category_name varchar2(50) not null unique
)

create table Bus_type(
Bus_type_id char(5) primary key,
Bus_type_name varchar2(50) not null unique,
cost_per_hour number(10,2) not null,
Bus_category char(5) not null, 
foreign key (Bus_category) references Bus_category(Bus_category)
)