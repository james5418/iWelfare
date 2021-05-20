CREATE TABLE disability(
	id int NOT NULL,
	disability varchar(5),
	PRIMARY KEY(id)
);

load data local infile './disability.csv'
into table disability
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;
