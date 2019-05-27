#!/bin/bash
DESCRIPTION="Find an error and fix replication"
HINT="Use Ctrl+b,c to create new window\nUse Ctrl+b,p or Ctrl+b,n to switch between next and previous window\n\nType CALL help_task() for help\n"
source /home/vagrant/tutorial/common-replication.sh
m test < /home/vagrant/tutorial/016-broken-replication.setup.master.sql >>rep_m.log 2>&1
sleep 5
s1 test < /home/vagrant/tutorial/016-broken-replication.setup.slave.sql >>rep_s.log 2>&1
m test -e "insert into a values (NULL, 'a')"
/usr/bin/clear
tmux new-session -d -n master /home/vagrant/tutorial/run_command_with_hint.sh "$HINT" m --prompt='mysql> ' -t test 2>>r_m.log
tmux new-window -n slave /home/vagrant/tutorial/run_command_with_hint.sh "$HINT" s1 --prompt='mysql> ' -t test 2>>r_s.log
tmux attach
cleanup
