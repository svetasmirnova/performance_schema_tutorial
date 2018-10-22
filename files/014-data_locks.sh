#!/bin/bash
DESCRIPTION="Which transaction holds the lock?"
HINT="Use Ctrl+b,c to create new window\nUse Ctrl+b,p or Ctrl+b,n to switch between next and previous window\n\nType CALL help_task() for help\n"
source /home/vagrant/tutorial/common-singlei-m8.sh
use test < /home/vagrant/tutorial/014-data_locks.setup.sql
use test < /home/vagrant/tutorial/014-data_locks.dump.sql
# create load
(
my sql test -e   "CALL help_prepare()" 
my sql test -e   "CALL data_locks_trx1(); system sleep 100000;" &
my sql test -e   "CALL data_locks_trx2()" &
sysbench --db-driver=mysql --test=/usr/share/doc/sysbench/tests/db/oltp.lua --threads=4 --mysql-socket=$sock --mysql-user=msandbox --mysql-password=msandbox --mysql-db=test  --oltp-table-size=500000 --max-requests=0 --max-time=100000 --oltp-test-mode=complex --oltp-point-selects=0 --oltp-simple-ranges=0 --oltp-sum-ranges=0 --oltp-order-ranges=0 --oltp-distinct-ranges=0 --oltp-index-updates=0 --oltp-non-index-updates=0 run &
) &>load.log &
/usr/bin/clear
echo -e $HINT
sleep 5
tmux new-session -s "/home/dba/$CLIENT_ID/" -n mysql my sql test
cleanup

