#!/bin/bash
DESCRIPTION="Find memory usage caused by sysbench"
HINT="Use Ctrl+b,c to create new window\nUse Ctrl+b,p or Ctrl+b,n to switch between next and previous window\n\nType CALL help_task() for help\n"
source /home/vagrant/tutorial/common-single.sh
use test < /home/vagrant/tutorial/015-memory.setup.sql
# create load
(
sb oltp_read_only.lua prepare
sb oltp_read_only.lua run --threads=2 --events=10000000 --time=10000
) &>load.log &

/usr/bin/clear
echo -e $HINT
sleep 5
tmux new-session -s "/home/dba/$CLIENT_ID/" -n mysql my sql test
cleanup

