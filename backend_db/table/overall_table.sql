create table overall(
	welfare_id int NOT NULL AUTO_INCREMENT,
	name text,
	welfare text,
	application_agency text,
	contact_info text,
	criteria text,
	document_needed text,
	notice text,
	PRIMARY KEY(welfare_id)
);

load data local infile './overall.csv'
into table overall
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

