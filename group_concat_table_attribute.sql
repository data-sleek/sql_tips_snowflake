--
-- I've been using Group Concat in MySQL to build
-- list of table attributes separated with comma.
-- Great way to speed up code and avoid errors
--
-- Data-Sleek
-- https://data-sleek.com/
-- Streamlining data into insights
--
-- Here is the same code for Snowflake


SELECT listagg(c.column_name, ',')
FROM information_schema.tables t
INNER JOIN information_schema.columns c ON c.table_schema = t.table_schema
	AND c.table_name = t.table_name
WHERE table_type = 'BASE TABLE'
	AND t.table_name = 'table_name'
ORDER BY ordinal_position;
