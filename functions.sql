---------------------------------------------------------------------------------------
-------------------------------- **** DATES **** --------------------------------------
---------------------------------------------------------------------------------------

to_char(date_column, 'yyyy-mm')                                                 --> From 2023-01-35 To 2023-01 (postgres)
((DATEPART(dw, date_column) + @@DATEFIRST) % 7) NOT IN (0, 1)                   --> excludes weekend (MSSQL)
DATEPART(dw, date_column )                                                      --> Sunday = 1, Saturday = 7, Friday = 6
date_column >= now()-'50 days'::interval                                        --> minus 50 days from today (postgres)
date_column >= CURRENT_DATE-'50 days'::interval                                 --> minus 50 days from today (redshift)
date_column between date_trunc('month',now()-'6 months'::INTERVAL) and date_trunc('month',now())-'1 days'::INTERVAL --> Show last X months back from today (postgres)
to_char(date_column,'IYYY-IW') BETWEEN to_char(DATE_TRUNC('week', CURRENT_DATE - '4 weeks'::INTERVAL), 'IYYY-IW') AND to_char(DATE_TRUNC('week', CURRENT_DATE - '1 weeks'::INTERVAL), 'IYYY-IW') --> Show last 4 weeks back from previous week (redshift)
date_trunc('hour',date_column)+date_part('minute',date_column)::int/15*interval'15 min' --> creates 15min intervals
substring(date_trunc('hour',date_column)+date_part('minute',date_column)::int/30*interval'30 min' from 12 for 5) --> creates 30min intervals
date_trunc('hour', date_column + interval '1 hour' )                            --> From 14:32 to 15:00, 17:12 --> 18:00
current_date - interval '1 month'                                               --> show last month (redshift)
TO_CHAR((column_in_seconds || ' second')::interval, 'HH24:MI:SS')               --> 66sec --> 00:01:06
datediff(minutes, resolved_ts,assigned_ts)                                      --> diff between two ts in minutes - can edit for days, hours etc.
to_char(date_column,'IYYY-IW')                                                  --> 2023-02-01 --> 2023-04


---------------------------------------------------------------------------------------
------------------------------ **** Strings **** --------------------------------------
---------------------------------------------------------------------------------------

substring(column_name from 4 for 2)                                             --> 23:33:12 --> 33
substring(column_name from char_length(column_name)-1 for 2)                    --> Customer Support C --> C
column_date||'-'|| 'bike'||'-'|| 'car'                                          -->  2020-bike-car
json_extract_path_text(details,'statement_number')                              --> JSON extract
json_extract_path_text(details,'statement_number',true)                         --> JSON extract
regexp_replace(column_name, '[.,/#!$%^&*;:{}=_`~()-]')                          --> jakub# --> jakub
trim(split_part(column_name, '-', 1))                                           --> Company - Agent - Channel --> Company
utilities_public.f_uuid_generator(column_name + column_name2)                   --> generate UUID f48546-fdfdse-fjoc4444-126446io
INITCAP(column_name)                                                            --> First upper case in the string

---------------------------------------------------------------------------------------
-------------------------- **** Windows Functions **** --------------------------------
---------------------------------------------------------------------------------------
row_number() over (partition by repeating_column_name order by ts)              --> Assigns numbers from 1 to x based on the repeated values
Count(*) Over(Partition by repeating_column )                                   --> Assigns total number based on amount of repetitions
listagg(distinct column_name, ',')                                              --> e.g. markets --> se, uk, cz in row
LAG(id, 1) OVER(partition by column_name ORDER BY date_column)                  --> Fetch id from the previous row based on the column_name
LEAD(id, 1) OVER(partition by column_name ORDER BY date_column)                 --> Fetch id from the following row based on the column_name
first_value(id ignore|respect nulls) over (partition by column_name)            --> populate column with the firs_value


---------------------------------------------------------------------------------------
---------------------------- **** Miscellaneous **** ----------------------------------
---------------------------------------------------------------------------------------
if object_id('tempdb..#table_name') is not null drop table #table_name; SELECT columns_name into #table_name FROM table_name where --> temp table (MSSQL)
SELECT ID FROM table1  INTERSECT  SELECT ID FROM table2;                       --> Return common rows
SELECT ID FROM table1  EXCEPT  SELECT ID FROM table2;                          --> Return non-common rows

