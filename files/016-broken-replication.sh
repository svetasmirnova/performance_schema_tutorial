#!/bin/bash
DESCRIPTION="Find an error and fix replication"
HINT="Use Ctrl+b,c to create new window\nUse Ctrl+b,p or Ctrl+b,n to switch between next and previous window\n\nType CALL help_task() for help\n"
source /home/vagrant/tutorial/common-replication.sh
m test < /home/vagrant/tutorial/016-broken-replication.setup.master.sql
s1 test < /home/vagrant/tutorial/016-broken-replication.setup.slave.sql
m test -e "insert into a values (NULL, 'a')"
/usr/bin/clear
echo -e $HINT
sleep 5
tmux new-session -d -s "/home/dba/$CLIENT_ID/" -n master m test
tmux new-window -t "/home/dba/$CLIENT_ID/" -n slave s1 test
tmux attach -t "/home/dba/$CLIENT_ID/"
cleanup
