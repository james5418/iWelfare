CREATE TABLE age(
	welfare_id int NOT NULL,
	age_lower int,
	age_upper int,
	PRIMARY KEY(welfare_id)
);

LOAD DATA LOCAL INFILE './age.csv'
into TABLE age
FIELDS TERMINATED by ','
ENCLOSED by '"'
LINES TERMINATED by '\n'
IGNORE 1 LINES;


CREATE TABLE other(
	welfare_id int NOT NULL,
	tag1 varchar(5),
	tag2 varchar(5),
	tag3 varchar(5),
	tag4 varchar(5),
	tag5 varchar(5),
	tag6 varchar(5),
	tag7 varchar(5),
	tag8 varchar(5),
	tag9 varchar(5),
	tag10 varchar(5),
	tag11 varchar(5),
	tag12 varchar(5),
	tag13 varchar(5),
	tag14 varchar(5),
	tag15 varchar(5),
	tag16 varchar(5),
	tag17 varchar(5),
	tag18 varchar(5),
	tag19 varchar(5),
	tag20 varchar(5),
	tag21 varchar(5),
	tag22 varchar(5),
	tag23 varchar(5),
	tag24 varchar(5),
	tag25 varchar(5),
	tag26 varchar(5),
	tag27 varchar(5),
	tag28 varchar(5),
	tag29 varchar(5),
	tag30 varchar(5),
	tag31 varchar(5),
	tag32 varchar(5),
	tag33 varchar(5),
	tag34 varchar(5),
	tag35 varchar(5),
	tag36 varchar(5),
	tag37 varchar(5),
	tag38 varchar(5),
	tag39 varchar(5),
	tag40 varchar(5),
	tag41 varchar(5),
	tag42 varchar(5),
	tag43 varchar(5),
	tag44 varchar(5),
	tag45 varchar(5),
	tag46 varchar(5),
	tag47 varchar(5),
	PRIMARY KEY(welfare_id)
);

LOAD DATA LOCAL INFILE './other.csv'
into TABLE other
FIELDS TERMINATED by ','
ENCLOSED by '"'
LINES TERMINATED by '\n'
IGNORE 1 LINES;


CREATE TABLE region(
	welfare_id int NOT NULL,
	city text,
	PRIMARY KEY(welfare_id)
);

LOAD DATA LOCAL INFILE './region.csv'
into TABLE region
FIELDS TERMINATED by ','
ENCLOSED by '"'
LINES TERMINATED by '\n'
IGNORE 1 LINES;


CREATE TABLE tags(
	tag_id int NOT NULL,
	tag text,
	PRIMARY KEY(tag_id)
);

LOAD DATA LOCAL INFILE './tags.csv'
into TABLE tags
FIELDS TERMINATED by ','
ENCLOSED by '"'
LINES TERMINATED by '\n'
IGNORE 1 LINES;
