drop database if exists test;
create database test;
use test;


-- help
delimiter //

CREATE PROCEDURE help_task()
 BEGIN
   SELECT "Find the most important slow queries: sort by total response time, average response time, rows scanned. Find queries not using indexes or creating temp tables" AS "task";
 END//

CREATE PROCEDURE help_solve()
 BEGIN
   SELECT "pager less; select * from performance_schema.events_statements_summary_by_digest ignore index(schema_name) order by SUM_TIMER_WAIT DESC\\G
           ... where SUM_NO_INDEX_USED > 0 
           ... where SUM_ROWS_EXAMINED/SUM_ROWS_SENT > 10 and SUM_ROWS_SENT > 0 " AS "task";
 END//

CREATE PROCEDURE help_prepare()
 BEGIN
    SET GLOBAL innodb_lock_wait_timeout = 100000; 
 END//

delimiter ;

