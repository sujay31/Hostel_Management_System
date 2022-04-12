CREATE DATABASE hostel;
USE hostel;
SHOW DATABASES;
USE hostel;

CREATE TABLE hostel_list (
hostel_code VARCHAR (5) NOT NULL,
vacancy INT UNSIGNED NOT NULL,
PRIMARY KEY (hostel_code)
);

CREATE TABLE wing_leader(
id VARCHAR (13) NOT NULL UNIQUE,
wing_size INT UNSIGNED NOT NULL,
pref_1 CHAR(2) NOT NULL,
pref_2 CHAR(2) NOT NULL,
pref_3 CHAR(2) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE wing_members(
id_1 VARCHAR (13) NOT NULL,
id_2 VARCHAR (13),
PRIMARY KEY (id_1),
FOREIGN KEY (id_2) REFERENCES wing_leader(id)
);

CREATE TABLE ashok (
room_number INT UNSIGNED NOT NULL AUTO_INCREMENT,
id VARCHAR (13) NOT NULL,
PRIMARY KEY (room_number) 
);

CREATE TABLE bhagirath LIKE ashok;
CREATE TABLE budh LIKE ashok;
CREATE TABLE cvr LIKE ashok;
CREATE TABLE gandhi LIKE ashok;
CREATE TABLE krishna LIKE ashok;
CREATE TABLE malviya LIKE ashok;
CREATE TABLE meera LIKE ashok;
CREATE TABLE ram LIKE ashok;
CREATE TABLE ranapratap LIKE ashok;
CREATE TABLE shankar LIKE ashok;
CREATE TABLE sr LIKE ashok;
CREATE TABLE vishwakarma LIKE ashok;
CREATE TABLE vyas LIKE ashok;
