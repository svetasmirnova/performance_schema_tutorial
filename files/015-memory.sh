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
tmux new-session -n mysql /home/vagrant/tutorial/run_command_with_hint.sh "$HINT" my sql -s --prompt='mysql> ' -t test
cleanup

