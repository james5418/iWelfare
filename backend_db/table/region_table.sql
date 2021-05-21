CREATE TABLE region(
	welfare_id int NOT NULL,
	city text,
	PRIMARY KEY(welfare_id)
);

LOAD DATA LOCAL INFILE './region.csv'
into TABLE region
FIELDS TERMINATED by ','
ENCLOSED by '"'
LINES TERMINATED by '\n'
IGNORE 1 LINES;
