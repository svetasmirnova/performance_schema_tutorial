drop database if exists test;
create database test;
use test;
create table test.a (id int) engine=innodb;


-- help
delimiter //

CREATE PROCEDURE help_task()
 BEGIN
   SELECT "What locks query: ALTER TABLE TEST.A ADD COLUMN ID1 INT;" AS "task";
 END//

CREATE PROCEDURE help_solve()
 BEGIN
   SELECT "Enable required Performance schema:\nupdate performance_schema.setup_instruments set ENABLED='YES' where name='wait/lock/metadata/sql/mdl';\nUPDATE performance_schema.setup_instruments SET ENABLED = 'YES', timed = 'YES' WHERE NAME LIKE 'statement/%';\nUPDATE performance_schema.setup_consumers SET ENABLED = 'YES' WHERE NAME LIKE 'events_statements%';\nYou can run these statements with CALL task_prepare(); command\nSHOW all threads related to metadata lock:\nSELECT processlist_id, thread_id, object_type, lock_type, lock_status, source FROM performance_schema.metadata_locks JOIN performance_schema.threads ON (owner_thread_id = thread_id) WHERE object_schema='test' AND object_name='a';\nYou can also see what statement caused metadata lock:\nSELECT EVENT_ID, END_EVENT_ID, EVENT_NAME,    SQL_TEXT FROM performance_schema.events_statements_history WHERE thread_id = <thread_id for granted>\\G" AS "task";
 END//

CREATE PROCEDURE task_prepare()
 BEGIN
	UPDATE performance_schema.setup_instruments set ENABLED='YES' where name='wait/lock/metadata/sql/mdl';
	UPDATE performance_schema.setup_instruments SET ENABLED = 'YES', timed = 'YES' WHERE NAME LIKE 'statement/%';
	UPDATE performance_schema.setup_consumers SET ENABLED = 'YES' WHERE NAME LIKE 'events_statements%';
 END//

delimiter ;

