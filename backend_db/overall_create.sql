CREATE TABLE overall(
	id int NOT NULL,
	name text,
	age_lower int,
	age_upper int,
	welfare text,
	application_agency text,
	contact_info text,
	criteria text,
	document_needed text,
	notice text,
	PRIMARY KEY(id)
);

load data local infile './overall.csv'
into table overall
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;
