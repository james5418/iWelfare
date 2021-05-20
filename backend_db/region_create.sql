CREATE TABLE region(
	id int NOT NULL,
	city text,
	township text,
	PRIMARY KEY(id)
);

load data local infile './region.csv'
into table region
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;
