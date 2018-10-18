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
make_sandbox /home/dba/Percona-Server-5.7.23-23-Linux.x86_64.ssl102.tar.gz -- --no_show --check_port
export PATH=/home/dba/$CLIENT_ID/msb_5_7_23:$PATH

my sqladmin --silent --wait  ping
