drop database if exists test;
create database test;
use test;

create table test.innodb_deadlock_maker(a int primary key) engine=innodb;


-- help
delimiter //

CREATE PROCEDURE help_task()
 BEGIN
   SELECT "Find all occasions of statements with errors: 1. get the list all accounts which raised errors (group by account) 2. get the top 3 error types globally. Use the performance_schema.events errors summary tables." AS "task";
 END//

CREATE PROCEDURE help_solve()
 BEGIN
   SELECT "select user, host, count(*) 
from performance_schema.events_errors_summary_by_account_by_error where SUM_ERROR_RAISED>0 group by user, host; \nselect user, host, ERROR_NAME, SUM_ERROR_RAISED, FIRST_SEEN, LAST_SEEN 
from  performance_schema.events_errors_summary_by_account_by_error where SUM_ERROR_RAISED>0 ; " AS "task";
 END//

CREATE PROCEDURE help_prepare()
 BEGIN
    SET GLOBAL innodb_lock_wait_timeout = 100000; 
 END//

delimiter ;

