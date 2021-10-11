create or replace TABLE DIM_TIMEOFDAY (
	TIMEOFDAY_KEY NUMBER(38,0) NOT NULL,
	HOUR NUMBER(38,0) NOT NULL,
	AM_PM VARCHAR(2) NOT NULL,
	HOUR_24 NUMBER(2,0) NOT NULL
);



insert into timeofday_dim Select -1,-1,'NA',-1;
insert into timeofday_dim Select 0,0,'AM',0;
insert into timeofday_dim Select 1,1,'AM',1;
insert into timeofday_dim Select 2,2,'AM',2;
insert into timeofday_dim Select 3,3,'AM',3;
insert into timeofday_dim Select 4,4,'AM',4;
insert into timeofday_dim Select 5,5,'AM',5;
insert into timeofday_dim Select 6,6,'AM',6;
insert into timeofday_dim Select 7,7,'AM',7;
insert into timeofday_dim Select 8,8,'AM',8;
insert into timeofday_dim Select 9,9,'AM',9;
insert into timeofday_dim Select 10,10,'AM',10;
insert into timeofday_dim Select 11,11,'AM',11;
insert into timeofday_dim Select 12,12,'PM',12;
insert into timeofday_dim Select 13,1,'PM',13;
insert into timeofday_dim Select 14,2,'PM',14;
insert into timeofday_dim Select 15,3,'PM',15;
insert into timeofday_dim Select 16,4,'PM',16;
insert into timeofday_dim Select 17,5,'PM',17;
insert into timeofday_dim Select 18,6,'PM',18;
insert into timeofday_dim Select 19,7,'PM',19;
insert into timeofday_dim Select 20,8,'PM',20;
insert into timeofday_dim Select 21,9,'PM',21;
insert into timeofday_dim Select 22,10,'PM',22;
insert into timeofday_dim Select 23,11,'PM',23;