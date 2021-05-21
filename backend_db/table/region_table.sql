create table region(
	welfare_id int NOT NULL,
	city text,
	PRIMARY KEY(welfare_id)
);

load data local infile './region.csv'
into table region
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;
