#!/bin/bash
DESCRIPTION="Find an error and fix replication"
HINT="Use Ctrl+b,c to create new window\nUse Ctrl+b,p or Ctrl+b,n to switch between next and previous window\n\nType CALL help_task() for help\n"
source /home/vagrant/tutorial/common-replication.sh
m test < /home/vagrant/tutorial/016-broken-replication.setup.master.sql
s1 test < /home/vagrant/tutorial/016-broken-replication.setup.slave.sql
m test -e "insert into a values (NULL, 'a')"
/usr/bin/clear
tmux new-session -d -n master /home/vagrant/tutorial/run_command_with_hint.sh "$HINT" m -s --prompt='mysql> ' -t test
tmux new-window -n slave /home/vagrant/tutorial/run_command_with_hint.sh "$HINT" s1 -s --prompt='mysql> ' -t test
tmux attach
cleanup
