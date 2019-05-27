drop database if exists test;
create database test;
use test;
delimiter //
create procedure crazy_timing() 
begin 
declare seconds int; 
select second(now()) into seconds; 
if seconds % 3 = 0 then 
select count(distinct t1.table_name) from information_schema.tables t1; 
elseif seconds % 2 = 0 then 
select count(distinct t1. table_name) from information_schema.tables t1 join information_schema.tables t2; 
else 
select count(distinct t1.table_name) from information_schema.tables t1 join information_schema.tables t2 join information_schema.tables t3; 
end if; 
end //
delimiter ;

-- help
delimiter //

CREATE PROCEDURE help_task()
 BEGIN
   SELECT "You need to call procedure test.crazy_timing() few times and find out why its execution time is different without examining code of the preocedure" AS "task";
 END//

CREATE PROCEDURE help_solve()
 BEGIN
   SELECT "Enable required Performance schema:\nupdate performance_schema.setup_instruments set ENABLED='YES' where name like 'statement/sp%';UPDATE performance_schema.setup_consumers SET ENABLED = 'YES' WHERE NAME LIKE 'events_statements%';\nYou can run these statements with CALL task_prepare(); command\nTo find out what was executed inside stored procedure each time you run it you can run SELECT thread_id, event_name, sql_text FROM performance_schema.events_statements_history_long WHERE event_name LIKE 'statement/sp%';\nTo have output nicer set pager to less: \\P less" AS "task";
 END//

CREATE PROCEDURE task_prepare()
 BEGIN
	UPDATE performance_schema.setup_instruments set ENABLED='YES' where name like 'statement/sp%';
	UPDATE performance_schema.setup_consumers SET ENABLED = 'YES' WHERE NAME LIKE 'events_statements%';
 END//

delimiter ;

