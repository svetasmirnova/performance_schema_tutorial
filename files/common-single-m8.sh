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
make_sandbox /home/dba/mysql-8.0.13-linux-glibc2.12-x86_64.tar.gz -- --no_show --check_port
export PATH=/home/dba/$CLIENT_ID/msb_8_0_13:$PATH

my sqladmin --silent --wait  ping
