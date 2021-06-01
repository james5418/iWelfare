DROP TABLE age;
DROP TABLE corresponding;
DROP TABLE tags;
DROP TABLE overall;


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

create table age(
	welfare_id int NOT NULL,
	age_lower int,
	age_upper int,
	PRIMARY KEY(welfare_id)
);

load data local infile './age.csv'
into table age
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;



create table tags(
	tag_id int NOT NULL AUTO_INCREMENT,
	tag text,
	PRIMARY KEY(tag_id)
);

load data local infile './tags.csv'
into table tags
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;


create table corresponding(
	welfare_id int NOT NULL,
	tag_id int NOT NULL
);

load data local infile './corresponding.csv'
into table corresponding
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;


