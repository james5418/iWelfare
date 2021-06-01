SELECT o.welfare_id , name
FROM ( 
		SELECT welfare_id, COUNT(*) as cnt 
		FROM ( 
				SELECT welfare_id 
				FROM age 
				WHERE (age_lower <= 18) AND (age_upper >= 18) 
	
				UNION ALL 
	
				SELECT welfare_id
				FROM corresponding as c 
				JOIN tags as t ON c.tag_id = t.tag_id 
				WHERE (tag = '生育') OR (tag = '孕婦') OR (tag = '中低收入戶')
		) as x
		GROUP BY welfare_id 
		HAVING cnt = (3 + 1)
) as y
INNER JOIN overall o ON o.welfare_id = y.welfare_id;
