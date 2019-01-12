DROP DATABASE IF EXISTS master;
CREATE DATABASE master;
USE master;

CREATE TABLE `hashes`
(
	`trio`     CHAR(3)  NOT NULL,
	`hash` 	   CHAR(32) NOT NULL,
	`password` CHAR(16) NOT NULL
) ENGINE = MYISAM;

ALTER TABLE `master`.`hashes` ADD PRIMARY KEY(`trio`, `hash`);