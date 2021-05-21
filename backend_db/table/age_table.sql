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
