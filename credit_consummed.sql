

select date_trunc('hour', start_time), hour(start_time), avg(avg_running)
from table(information_schema.warehouse_load_history(date_range_start=>dateadd('day',-1,current_timestamp())))
group by date_trunc('hour', start_time), hour(start_time)
order by date_trunc('hour', start_time) asc;

 
select * from table(information_schema.warehouse_metering_history('2022-05-12', '2022-05-15','DATA_ENGINEER_WAREHOUSE1'));
select * from table(information_schema.warehouse_metering_history('DATA_ENGINEER_WAREHOUSE1'));
select * from table(information_schema.warehouse_metering_history(dateadd('days',-10,current_date())));

 
-- Credit usage per warehouse
select warehouse_name,
       sum(credits_used) as total_credits_used
from snowflake.account_usage.warehouse_metering_history
where start_time >= date_trunc(month, current_date)
group by 1
order by 2 desc;

-- Credit usage per date, warehouse
select start_time::date as usage_date,
       warehouse_name,
       sum(credits_used) as total_credits_used
from snowflake.account_usage.warehouse_metering_history
where start_time >= date_trunc(month, current_date)
group by 1,2
order by 2,1;



-- Find out the average load on a warehouse
SELECT DATE_TRUNC('hour', start_time) start_time_trunced_at_hour,
       HOUR(start_time)               start_time_hour,
       AVG(avg_running)               avg_running,
       AVG(avg_queued_load)           avg_queued_load,
       AVG(avg_queued_provisioning)   avg_queued_provisioning,
       AVG(avg_blocked)               avg_blocked
 FROM snowflake.account_usage.warehouse_load_history
WHERE DATE_TRUNC('DAY', start_time) = '2022-05-13'
  AND warehouse_name = 'DATA_ENGINEER_WAREHOUSE1'
GROUP BY start_time_trunced_at_hour, start_time_hour
ORDER BY start_time_trunced_at_hour;

 Latency for the view may be up to 180 minutes (3 hours).