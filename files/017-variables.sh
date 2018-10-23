#!/bin/bash
DESCRIPTION="Find how many rows inserted by an infinite loop"
HINT="Use Ctrl+b,c to create new window\nUse Ctrl+b,p or Ctrl+b,n to switch between next and previous window\n\nType CALL help_task() for help\n"
source /home/vagrant/tutorial/common-single.sh
use test < /home/vagrant/tutorial/017-variables.setup.sql
# create load
(
sb oltp_read_write.lua --tables-count=8 --table-size=1000 prepare
sb oltp_read_write.lua --num-threads=8 --max-requests=0 --max-time=10000 run &
use test -e "CALL perform_load()"
) &>load.log &
/usr/bin/clear
echo -e $HINT
sleep 5
tmux new-session -s "/home/dba/$CLIENT_ID/" -n mysql my sql test
cleanup

