#!/bin/bash
MYSQL_VER=5.7.23
source /home/vagrant/tutorial/common.sh
dbdeployer deploy single $MYSQL_VER -c 'innodb_buffer_pool_size=64M' --sandbox-binary=/home/vagrant/opt/percona --port $SANDBOX_PORT
export PATH=/home/$USER/sandboxes/msb_${MYSQL_VER//./_}:$PATH

my sqladmin --silent --wait --connect_timeout=120  ping
