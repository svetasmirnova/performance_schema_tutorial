#!/bin/bash
DESCRIPTION="Find the most important slow queries, MySQL 8.0"
HINT="Use Ctrl+b,c to create new window\nUse Ctrl+b,p or Ctrl+b,n to switch between next and previous window\n\nType CALL help_task() for help\n"
source /home/vagrant/tutorial/common-single-m8.sh
use test < /home/vagrant/tutorial/010-statements_summary.setup.sql
use test < /home/vagrant/tutorial/010-statements_summary.dump.sql
# create load
(
sysbench --db-driver=mysql --test=/usr/share/doc/sysbench/tests/db/oltp.lua --threads=4 --mysql-socket=$sock --mysql-user=msandbox --mysql-password=msandbox --mysql-db=test  --oltp-table-size=500000 --max-requests=0 --max-time=100000 --oltp-test-mode=complex --oltp-point-selects=1 --oltp-simple-ranges=1 --oltp-sum-ranges=1 --oltp-order-ranges=1 --oltp-distinct-ranges=1 --oltp-index-updates=0 --oltp-non-index-updates=1 run &
) &>load.log &
/usr/bin/clear
echo -e $HINT
sleep 5
tmux new-session -s "/home/dba/$CLIENT_ID/" -n mysql my sql test
cleanup

