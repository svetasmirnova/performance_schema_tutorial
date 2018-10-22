#!/bin/bash
DESCRIPTION="Find what locks ALTER query"
HINT="Use Ctrl+b,c to create new window\nUse Ctrl+b,p or Ctrl+b,n to switch between next and previous window\n\nType CALL help_task() for help\n"
source /home/vagrant/tutorial/common-single.sh
use test < /home/vagrant/tutorial/013-mdl.setup.sql
# create load
(while (echo 'start transaction; select * from test.a;';
   use test  -e 'ALTER TABLE test.a ADD COLUMN ID1 INT;' &>/dev/null &
   sleep 5
   my sqladmin KILL `use -N -e "select ID from information_schema.processlist where info like 'ALTER TABLE test.a ADD COLUMN ID1 INT' and (EXISTS (SELECT 1 FROM performance_schema.setup_consumers WHERE NAME LIKE 'events_statements%' and ENABLED = 'no') or EXISTS (select 1 from performance_schema.setup_instruments where (name='wait/lock/metadata/sql/mdl' or name like 'statement%') and enabled='no'));"`
   wait
   echo 'commit;') | use ; do : ;done ) &>load.log &
/usr/bin/clear
echo -e $HINT
sleep 5
tmux new-session -s "/home/dba/$CLIENT_ID/" -n mysql my sql test
cleanup

