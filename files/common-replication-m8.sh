#!/bin/bash
export CLIENT_ID=$(( $(ls |grep -v 5.7.23|egrep '^[[:digit:]]+$'|sort -n|tail -n 1 ) + 1 ))

function cleanup() {
  pkill -f /home/dba/$CLIENT_ID/
  rm -rf /home/dba/$CLIENT_ID
  cd
}

trap cleanup SIGHUP SIGTERM

cleanup
mkdir /home/dba/$CLIENT_ID
cd /home/dba/$CLIENT_ID
export SANDBOX_HOME=/home/dba/$CLIENT_ID
make_replication_sandbox --how_many_slaves=1 /home/dba/mysql-8.0.13-linux-glibc2.12-x86_64.tar.gz -- --no_show --check_port
export PATH=/home/dba/$CLIENT_ID/rsandbox_mysql-8_0_13:$PATH


/home/dba/$CLIENT_ID/rsandbox_mysql-8_0_13/master/my sqladmin --silent --wait  ping
/home/dba/$CLIENT_ID/rsandbox_mysql-8_0_13/node1/my sqladmin --silent --wait  ping
