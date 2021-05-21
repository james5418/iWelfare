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
