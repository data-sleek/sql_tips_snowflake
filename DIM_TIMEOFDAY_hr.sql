create or replace TABLE DIM_TIMEOFDAY (
	TIMEOFDAY_KEY NUMBER(38,0) NOT NULL,
	HOUR NUMBER(38,0) NOT NULL,
	AM_PM VARCHAR(2) NOT NULL,
	HOUR_24 NUMBER(2,0) NOT NULL
);



insert into dim_timeofday Select -1,-1,'NA',-1;
insert into dim_timeofday Select 0,0,'AM',0;
insert into dim_timeofday Select 1,1,'AM',1;
insert into dim_timeofday Select 2,2,'AM',2;
insert into dim_timeofday Select 3,3,'AM',3;
insert into dim_timeofday Select 4,4,'AM',4;
insert into dim_timeofday Select 5,5,'AM',5;
insert into dim_timeofday Select 6,6,'AM',6;
insert into dim_timeofday Select 7,7,'AM',7;
insert into dim_timeofday Select 8,8,'AM',8;
insert into dim_timeofday Select 9,9,'AM',9;
insert into dim_timeofday Select 10,10,'AM',10;
insert into dim_timeofday Select 11,11,'AM',11;
insert into dim_timeofday Select 12,12,'PM',12;
insert into dim_timeofday Select 13,1,'PM',13;
insert into dim_timeofday Select 14,2,'PM',14;
insert into dim_timeofday Select 15,3,'PM',15;
insert into dim_timeofday Select 16,4,'PM',16;
insert into dim_timeofday Select 17,5,'PM',17;
insert into dim_timeofday Select 18,6,'PM',18;
insert into dim_timeofday Select 19,7,'PM',19;
insert into dim_timeofday Select 20,8,'PM',20;
insert into dim_timeofday Select 21,9,'PM',21;
insert into dim_timeofday Select 22,10,'PM',22;
insert into dim_timeofday Select 23,11,'PM',23;