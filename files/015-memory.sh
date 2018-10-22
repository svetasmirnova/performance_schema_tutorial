#!/bin/bash
DESCRIPTION="Find slow statement in stored procedure"
HINT="Use Ctrl+b,c to create new window\nUse Ctrl+b,p or Ctrl+b,n to switch between next and previous window\n\nType CALL help_task() for help\n"
source /home/vagrant/tutorial/common-single.sh
use test < /home/vagrant/tutorial/015-memory.setup.sql
# create load
(
sysbench --db-driver=mysql --test=/usr/share/doc/sysbench/tests/db/oltp_simple.lua --mysql-socket=/tmp/mysql_sandbox5717.sock --mysql-user=msandbox --mysql-password=msandbox --mysql-db=test prepare
sysbench --db-driver=mysql --test=/usr/share/doc/sysbench/tests/db/oltp_simple.lua --mysql-socket=/tmp/mysql_sandbox5717.sock --mysql-user=msandbox --mysql-password=msandbox --mysql-db=test --num-threads=2 --max-requests=10000000 --max-time=10000 run
) &>load.log &

/usr/bin/clear
echo -e $HINT
sleep 5
tmux new-session -s "/home/dba/$CLIENT_ID/" -n mysql my sql test
cleanup

