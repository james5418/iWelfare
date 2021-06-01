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
