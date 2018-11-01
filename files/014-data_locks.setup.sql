drop database if exists test;
create database test;
use test;


-- help
delimiter //

CREATE PROCEDURE data_locks_trx1()
 BEGIN
 	start transaction; update test.sbtest1 set c = 'trx1' where id = 100;
 END//

CREATE PROCEDURE data_locks_trx2()
 BEGIN
	select sleep(2);
        start transaction; update test.sbtest1 set c = 'trx2' where id = 100; commit;
 END//

CREATE PROCEDURE help_task()
 BEGIN
   SELECT "Which transaction holds the lock, which row locked, which partition locked?\nIn addition, we will need to find what the locking transaction looks like (processlist does not show)\nHint: use the data_locks and data_locks_waits tables in performance_schema" AS "task";
 END//

CREATE PROCEDURE help_solve()
 BEGIN
   SELECT "select w.*, 
  (SELECT group_concat(SQL_TEXT SEPARATOR ';') 
     FROM performance_schema.threads th 
     LEFT JOIN performance_schema.events_statements_history esh ON esh.thread_id = th.thread_id
	 WHERE th.processlist_id = w.blocking_pid
  ) as blocking_transaction 
  from sys.innodb_lock_waits w" AS "task";
 END//

CREATE PROCEDURE help_prepare()
 BEGIN
    SET GLOBAL innodb_lock_wait_timeout = 100000; 
 END//

delimiter ;

