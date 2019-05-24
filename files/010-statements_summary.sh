#!/bin/bash
DESCRIPTION="Find the most important slow queries"
HINT="Use Ctrl+b,c to create new window\nUse Ctrl+b,p or Ctrl+b,n to switch between next and previous window\n\nType CALL help_task() for help\n"
source /home/vagrant/tutorial/common-single.sh
use -e "create database sbtest"
use sbtest < /home/vagrant/tutorial/010-statements_summary.setup.sql
use sbtest < /home/vagrant/tutorial/010-statements_summary.dump.sql
# create load
(
use sbtest -e "select min(pad), max(pad) from sbtest.sbtest1 where k > 100" &>/dev/null &
sb oltp_read_write.lua --threads=4 --max-requests=0 --max-time=100000 --point-selects=1 --simple-ranges=1 --sum-ranges=1 --order-ranges=1 --distinct-ranges=1 --index-updates=0 --non-index-updates=1 run &
) &>load.log &
/usr/bin/clear
tmux new-session -n mysql /home/vagrant/tutorial/run_command_with_hint.sh "$HINT" my sql --prompt='mysql> ' -t test
cleanup

