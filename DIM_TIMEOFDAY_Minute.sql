
create or replace table DIM_TIMEOFDAY (
    TIMEOFDAY_KEY		number(6)	PRIMARY KEY,
    TIMEOFDAY_24HR		time not null,
    TIMEOFDAY_12HR		varchar(64) not null,
    HROFDAY				number(6) not null,
    MINOFDAY			number(6) not null
 
) ;

INSERT INTO     DIM_TIMEOFDAY
       WITH CTE_MINUTE AS (
    	select 
			TIMEADD(minute, SEQ4(), '2017-01-01 00:00:00') as TEMP_TIMESTAMP,  
            seq4() as TEMP_SEQUENCE,
			row_number() over (order by TEMP_SEQUENCE) as TIME_PK,
            to_time(to_char(TEMP_TIMESTAMP,'HH24:MI:00'),'HH24:MI:00') HOUR_24,
            to_char(TEMP_TIMESTAMP,'HH12:MI:00 PM') HOUR_12,
         hour(TEMP_TIMESTAMP) as HOUR_1,
         minute(TEMP_TIMESTAMP) as MINUTE_1
   		from table(generator(rowcount => 1440))
            
        )
     select 
        TIME_PK, 
        HOUR_24,
        HOUR_12,
        HOUR_1,
        MINUTE_1
        from CTE_MINUTE ; 

   --   select * from DIM_TIMEOFDAY_temp ; 


