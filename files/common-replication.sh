#!/bin/bash
source /home/vagrant/tutorial/common.sh
make_replication_sandbox --how_many_slaves=1 --check_base_port --sandbox_base_port $SANDBOX_PORT /home/vagrant/Percona-Server-5.7.23-23-Linux.x86_64.ssl102.tar.gz -- --no_show
export PATH=/home/$USER/sandboxes/rsandbox_Percona-Server-5_7_23:$PATH


/home/$USER/sandboxes/rsandbox_Percona-Server-5_7_23/master/my sqladmin --silent --wait --connect_timeout=120  ping
/home/$USER/sandboxes/rsandbox_Percona-Server-5_7_23/node1/my sqladmin --silent --wait --connect_timeout=120  ping
