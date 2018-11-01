drop database if exists test;
create database test;
use test;

-- help
delimiter //

CREATE PROCEDURE help_task()
 BEGIN
   SELECT "Create prepared statement:\nPREPARE stmt FROM 'SELECT COUNT(*) FROM sbtest1 WHERE pad=?'\nexecute it using various values, find how effective the statement.\nThen fix the issue without touching statement (you can modify table definition) and re-examine execution statistics" AS "task";
 END//

CREATE PROCEDURE help_solve()
 BEGIN
   SELECT "In this task we will query table prepared_statements_instances.\nSELECT statement_name, sql_text, count_reprepare, count_execute, sum_rows_sent, sum_rows_examined, sum_no_index_used FROM performance_schema.prepared_statements_instances\\G\nThen you will need to add index on field pad to table sbtest1:\nALTER TABLE sbtest1 ADD KEY(pad);\nThen execute statement one more time and re-run query on Performance Schema. Check what changed." AS "task";
 END//

CREATE PROCEDURE task_prepare()
 BEGIN
 END//

delimiter ;

