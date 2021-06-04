SELECT c.welfare_id, name
FROM ( 
	SELECT welfare_id, name
	FROM overall
	WHERE name LIKE "%得%"
)a
INNER JOIN corresponding c ON c.welfare_id = a.welfare_id;
