begin; insert into test.innodb_deadlock_maker values(1); select sleep(2); insert into test.innodb_deadlock_maker values(0);
