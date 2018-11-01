drop database if exists test;
create database test;
use test;
create table test.test (f1 varchar(255)) engine=innodb;


-- help
delimiter //

CREATE PROCEDURE perform_load()
 BEGIN
   l: LOOP
     INSERT INTO test VALUES('Percona Live 2018');
   END LOOP l;
 END//

CREATE PROCEDURE help_task()
 BEGIN
   SELECT "How many rows inserted by infinite loop INSERT INTO test VALUES('Percona Live 2018');" AS "task";
 END//

CREATE PROCEDURE help_solve()
 BEGIN
   SELECT "Disable show_compatibility_56 mode: SET GLOBAL show_compatibility_56 = 0; or simply run CALL task_prepare();\nThen query performance_schema.status_by_thread table:\nselect * from performance_schema.status_by_thread where variable_name='Handler_write';\nYou can limit number of rows returned if specify PROCESSLIST_ID:\nselect thread_id as tid, processlist_id as pid, variable_name as name, variable_value as value from performance_schema.status_by_thread join performance_schema.threads using(thread_id) where variable_name='Handler_write' and processlist_id=<Put ID of thread, doing LOAD DATA here>;" AS "task";
 END//

CREATE PROCEDURE task_prepare()
 BEGIN
    SET GLOBAL show_compatibility_56 = 0; 
 END//

delimiter ;

