#!/bin/bash
DESCRIPTION="Which transaction holds the lock?, MySQL 8.0"
HINT="Use Ctrl+b,c to create new window\nUse Ctrl+b,p or Ctrl+b,n to switch between next and previous window\n\nType CALL help_task() for help\n"
source /home/vagrant/tutorial/common-single-m8.sh
use test < /home/vagrant/tutorial/014-data_locks.setup.sql
use test < /home/vagrant/tutorial/014-data_locks.dump.sql
# create load
(
my sql test -e   "CALL help_prepare()" 
my sql test -e   "CALL data_locks_trx1(); system sleep 100000;" &
my sql test -e   "CALL data_locks_trx2()" &
sb oltp_read_write.lua --threads=4 --table-size=500000 --max-requests=0 --max-time=100000 --point-selects=0 --simple-ranges=0 --sum-ranges=0 --order-ranges=0 --distinct-ranges=0 --index-updates=0 --non-index-updates=0 run &
) &>load.log &
/usr/bin/clear
tmux new-session -n mysql /home/vagrant/tutorial/run_command_with_hint.sh "$HINT" my sql -s --prompt='mysql> ' -t test
cleanup

