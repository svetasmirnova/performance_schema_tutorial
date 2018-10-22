drop database if exists test;
create database test;
use test;
-- help
delimiter //

CREATE PROCEDURE help_task()
 BEGIN
   SELECT "Find memory usage caused by sysbench" AS "task";
 END//

CREATE PROCEDURE help_solve()
 BEGIN
   SELECT "Enable required Performance schema:\n  call sys.ps_setup_enable_instrument('memory'); \n\nselect thread_id tid, processlist_id pid, user, current_allocated ca, total_allocated from sys.memory_by_thread_by_current_bytes join performance_schema.threads using(thread_id) where user like 'msandbox%'; " AS "task";
 END//

CREATE PROCEDURE task_prepare()
 BEGIN
	 call sys.ps_setup_enable_instrument('memory');
 END//

delimiter ;

