--
-- information_schema tables are powerful
-- They allow you to gather data about your schema.
-- Query below is useful for data dictionnary.
-- Just copy and paste result into Excel / Google Sheet.

-- Data-Sleek
-- https://data-sleek.com/
-- Streamlining data into insights
--
-- Here is the same code for Snowflake


SELECT t.table_schema,
	t.table_name,
	c.column_name,
	c.ordinal_position,
	c.data_type,
	CASE
		WHEN c.numeric_precision IS NOT NULL
			THEN c.numeric_precision
		WHEN c.character_maximum_length IS NOT NULL
			THEN c.character_maximum_length
		END AS max_length,
	c.numeric_scale,
	c.is_identity,
	c.is_nullable
FROM information_schema.tables t
INNER JOIN information_schema.columns c ON c.table_schema = t.table_schema
	AND c.table_name = t.table_name
WHERE table_type = 'BASE TABLE'
ORDER BY table_schema,
	table_name,
	ordinal_position;
