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
