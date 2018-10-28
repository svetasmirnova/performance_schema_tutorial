#!/bin/bash
DESCRIPTION="Find prepared statement execution statistics"
HINT="Use Ctrl+b,c to create new window\nUse Ctrl+b,p or Ctrl+b,n to switch between next and previous window\n\nType CALL help_task() for help\n"
source /home/vagrant/tutorial/common-single.sh
use test < /home/vagrant/tutorial/011-prepared.setup.sql
# create load
(
sb oltp_read_write.lua --table-size=1000 --mysql-db=test prepare
) &>load.log &
/usr/bin/clear
tmux new-session -n mysql /home/vagrant/tutorial/run_command_with_hint.sh "$HINT" my sql -s --prompt='mysql> ' -t test
cleanup

