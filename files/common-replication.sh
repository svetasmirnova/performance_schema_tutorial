#!/bin/bash
MYSQL_VER=5.7.23
source /home/vagrant/tutorial/common.sh
dbdeployer deploy replication $MYSQL_VER --sandbox-binary=/home/vagrant/opt/percona -c 'innodb_buffer_pool_size=64M' --nodes=2 --base-port $SANDBOX_PORT
export PATH=/home/$USER/sandboxes/rsandbox_${MYSQL_VER//./_}:$PATH


/home/$USER/sandboxes/rsandbox_${MYSQL_VER//./_}/master/my sqladmin --silent --wait --connect_timeout=120  ping
/home/$USER/sandboxes/rsandbox_${MYSQL_VER//./_}/node1/my sqladmin --silent --wait --connect_timeout=120  ping
