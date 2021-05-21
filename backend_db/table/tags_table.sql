create table tags(
	tag_id int NOT NULL,
	tag text,
	PRIMARY KEY(tag_id)
);

load data local infile './tags.csv'
into table tags
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;
