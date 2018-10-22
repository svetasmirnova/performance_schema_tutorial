#!/bin/bash
DESCRIPTION="Find prepared statement execution statistics"
HINT="Use Ctrl+b,c to create new window\nUse Ctrl+b,p or Ctrl+b,n to switch between next and previous window\n\nType CALL help_task() for help\n"
source /home/vagrant/tutorial/common-single.sh
use test < /home/vagrant/tutorial/011-prepared.setup.sql
# create load
(
sysbench --db-driver=mysql --test=/usr/share/doc/sysbench/tests/db/oltp.lua --mysql-socket=/tmp/mysql_sandbox5717.sock --mysql-user=msandbox --mysql-password=msandbox --mysql-db=test  --oltp-table-size=1000 prepare
sandboxes/$msb_path/use test 
) &>load.log &
/usr/bin/clear
echo -e $HINT
sleep 5
tmux new-session -s "/home/dba/$CLIENT_ID/" -n mysql my sql test
cleanup

