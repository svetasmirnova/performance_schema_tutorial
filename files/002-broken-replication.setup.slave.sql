STOP SLAVE SQL_THREAD; set global slave_parallel_type = 'LOGICAL_CLOCK'; set global slave_parallel_workers=4; START SLAVE SQL_THREAD;
drop table if exists test.a;
