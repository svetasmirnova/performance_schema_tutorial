#!/bin/bash
source ./configs.sh

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
        echo "Exiting"
# kill load
        pkill sysbench
        pkill mysqld
        pkill mysql
        killall sleep &>/dev/null
}

PATH_REPL="sandboxes/rsandbox_Percona-Server-5_7_17"


#prepare
$PATH_REPL/stop_all
$PATH_REPL/clear_all
$PATH_REPL/start_all
$PATH_REPL/status_all

echo "Database setup"
$PATH_REPL/m test < repl.setup.master.sql
$PATH_REPL/s1 test < repl.setup.slave.sql

$PATH_REPL/m test -e "insert into a values (NULL, 'a')" 

echo "Check task with CALL help_task()\\G"
echo "Help on solution CALL help_solve()\\G"
echo ""
$PATH_REPL/s1 test
ctrl_c
