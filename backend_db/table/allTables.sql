DROP TABLE age;
DROP TABLE corresponding;
DROP TABLE tags;
DROP TABLE overall;
DROP TABLE bonus;

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
	tag_id int NOT NULL,
	FOREIGN KEY(welfare_id) REFERENCES overall(welfare_id),
	FOREIGN KEY(tag_id) REFERENCES tags(tag_id)
);

load data local infile './corresponding.csv'
into table corresponding
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

create table bonus(
	id int NOT NULL AUTO_INCREMENT,
	name text,
	description text,
	content text,
	organizer text,
	document text,
	apply_method text,
	deliver_method text,
	remark text,
	PRIMARY KEY(id) 
);

load data local infile './bonus.csv'
into table bonus
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;
