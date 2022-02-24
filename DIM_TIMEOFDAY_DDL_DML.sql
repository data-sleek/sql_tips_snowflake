==================================================
-------------DIM_TIMEOFDAY
==================================================
-- Create table script for Dimension DIM_TIMEOFDAY
create or replace table DIM_TIMEOFDAY (
    TIMEOFDAY_KEY		number(6)	PRIMARY KEY,
    TIMEOFDAY_24HR		time not null,
    TIMEOFDAY_12HR		varchar(64) not null,
    HROFDAY				number(6) not null,
    MINOFDAY			number(6) not null,
    SECOFDAY			number(6) not null,
    INTERVAL_5_MIN		varchar(64) not null,
    INTERVAL_15_MIN		varchar(64) not null,
    INTERVAL_30_MIN		varchar(64) not null,
    INTERVAL_1_HR		varchar(64) not null,
	CURRENT_ROW_IND		char(1) default 'Y',
	EFFECTIVE_DATE		date default to_date(current_timestamp),
	EXPIRATION_DATE		date default To_date('9999-12-31') 
)
comment = 'Type 0 Dimension Table Housing Generic Time-of-Day Attributes';

-- Populate data into DIM_TIMEOFDAY
insert into DIM_TIMEOFDAY 
select 
	TIME_PK,
	HOUR_24,
    HOUR_12,
    HOUR_1,
	floor(TIME_PK/60),
    TIME_PK,
	INTERVAL_05,
    INTERVAL_15,
    INTERVAL_30,
    INTERVAL_1HR,
    CURRENT_ROW_ID,
    EFFECTIVE_DATE,
    EXPIRY_DATE
    from (
		select 
			to_date('00:00:00','HH24:MI:SS') as TEMP_TIMESTAMP,  
            seq8() as TEMP_SEQUENCE,
			row_number() over (order by TEMP_SEQUENCE) as TIME_PK,
            to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:MI:SS'),'HH24:MI:SS') HOUR_24,
            to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH12:MI:SS PM') HOUR_12,
            to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24') as HOUR_1,
            to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'MI') as MINUTE_1,
            to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'SS') as SECOND_1,
            case  
				when to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:MI:SS'),'HH24:MI:SS') <
                to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'05:00','HH24:MI:SS') then
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':00:00-'||
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':04:59' 
				when to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:MI:SS'),'HH24:MI:SS') between
                to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'05:00','HH24:MI:SS') and 
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'09:59','HH24:MI:SS')	then
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':05:00-'||
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':09:59'
				when to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:MI:SS'),'HH24:MI:SS') between
                to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'10:00','HH24:MI:SS') and 
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'14:59','HH24:MI:SS')	then
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':10:00-'||
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':14:59'
				when to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:MI:SS'),'HH24:MI:SS') between
                to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'15:00','HH24:MI:SS') and 
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'19:59','HH24:MI:SS')	then
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':15:00-'||
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':19:59'
				when to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:MI:SS'),'HH24:MI:SS') between
                to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'20:00','HH24:MI:SS') and 
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'24:59','HH24:MI:SS')	then
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':20:00-'||
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':24:59'
				when to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:MI:SS'),'HH24:MI:SS') between
                to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'25:00','HH24:MI:SS') and 
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'29:59','HH24:MI:SS')	then
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':25:00-'||
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':29:59'
				when to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:MI:SS'),'HH24:MI:SS') between
                to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'30:00','HH24:MI:SS') and 
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'34:59','HH24:MI:SS')	then
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':30:00-'||
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':34:59'
				when to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:MI:SS'),'HH24:MI:SS') between
                to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'35:00','HH24:MI:SS') and 
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'39:59','HH24:MI:SS')	then
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':35:00-'||
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':39:59'
				when to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:MI:SS'),'HH24:MI:SS') between
                to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'40:00','HH24:MI:SS') and 
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'44:59','HH24:MI:SS')	then
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':40:00-'||
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':44:59'
				when to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:MI:SS'),'HH24:MI:SS') between
                to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'45:00','HH24:MI:SS') and 
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'49:59','HH24:MI:SS')	then
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':45:00-'||
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':49:59'
				when to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:MI:SS'),'HH24:MI:SS') between
                to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'50:00','HH24:MI:SS') and 
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'54:59','HH24:MI:SS')	then
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':50:00-'||
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':54:59'
				when to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:MI:SS'),'HH24:MI:SS') between
                to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'55:00','HH24:MI:SS') and 
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'59:59','HH24:MI:SS')	then
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':55:00-'||
                to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':59:59'
			end INTERVAL_05,
			case  
				when to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:MI:SS'),'HH24:MI:SS') <
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'15:00','HH24:MI:SS') then
				to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':00:00-'||
				to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':14:59'
				when to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:MI:SS'),'HH24:MI:SS') between
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'15:00','HH24:MI:SS') and 
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'29:59','HH24:MI:SS') then
				to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':15:00-'||
				to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':29:59'
				when to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:MI:SS'),'HH24:MI:SS') between
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'30:00','HH24:MI:SS') and 
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'44:59','HH24:MI:SS') then
				to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':30:00-'||
				to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':44:59'
				when to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:MI:SS'),'HH24:MI:SS') between
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'45:00','HH24:MI:SS') and 
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'59:59','HH24:MI:SS') then
				to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':45:00-'||
				to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':59:59'
			end INTERVAL_15,
			case  
				when to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:MI:SS'),'HH24:MI:SS') <
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'30:00','HH24:MI:SS') then
				to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':00:00-'||
				to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':29:59' 
				when to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:MI:SS'),'HH24:MI:SS') >
				to_time(to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24:')||'29:59','HH24:MI:SS') then
				to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':30:00-'||
				to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':59:59'
				
			end INTERVAL_30,
        to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':00:00-'|| to_char(dateadd(second,TEMP_SEQUENCE,TEMP_TIMESTAMP),'HH24')||':59:59' as INTERVAL_1HR,
        'Y' as CURRENT_ROW_ID,
        to_date(current_timestamp) as EFFECTIVE_DATE,
        to_date('9999-12-31') as EXPIRY_DATE
		from table(generator(rowcount => 1440))
	) TEMP_QUERY;

-- Miscellaneous queries 
select * from  DIM_TIMEOFDAY;

--delete from DIM_TIMEOFDAY;												
				
--drop table DIM_TIMEOFDAY;	