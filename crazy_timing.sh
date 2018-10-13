#!/bin/bash
source ./configs.sh

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
        echo "Exiting"
# kill load
	kill %1
}

#prepare
sandboxes/$msb_path/stop
sandboxes/$msb_path/clear
sandboxes/$msb_path/start
sandboxes/$msb_path/my sqladmin --wait ping

echo "Database setup"
sandboxes/$msb_path/use test < crazy_timing.setup.sql

# create load
#no load in this task

echo "Check task with CALL help_task()\\G"
echo "Help on solution CALL help_solve()\\G"
echo ""
sandboxes/$msb_path/use test
