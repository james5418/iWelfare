CREATE TABLE income(
	id int NOT NULL,
	low_income int,
	low_and_middle_income int,
	PRIMARY KEY(id)
);

load data local infile './income.csv'
into table income
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;
