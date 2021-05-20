CREATE TABLE age(
	welfare_id int NOT NULL,
	age_lower int,
	age_upper int,
	PRIMARY KEY(welfare_id)
);

LOAD DATA LOCAL INFILE './age.csv'
into TABLE age
FIELDS TERMINATED by ','
ENCLOSED by '"'
LINES TERMINATED by '\n'
IGNORE 1 LINES;
