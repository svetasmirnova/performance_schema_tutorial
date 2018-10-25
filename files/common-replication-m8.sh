#!/bin/bash
source /home/vagrant/tutorial/common.sh
make_replication_sandbox --how_many_slaves=1 --check_base_port --sandbox_base_port $SANDBOX_PORT /home/vagrant/mysql-8.0.13-linux-glibc2.12-x86_64.tar.gz -- --no_show
export PATH=/home/$USER/sandboxes/rsandbox_mysql-8_0_13:$PATH


/home/$USER/sandboxes/rsandbox_mysql-8_0_13/master/my sqladmin --silent --wait --connect_timeout=120  ping
/home/$USER/sandboxes/rsandbox_mysql-8_0_13/node1/my sqladmin --silent --wait --connect_timeout=120  ping
