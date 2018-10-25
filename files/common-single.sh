#!/bin/bash
source /home/vagrant/tutorial/common.sh
make_sandbox /home/vagrant/Percona-Server-5.7.23-23-Linux.x86_64.ssl102.tar.gz -- --no_show --check_port --sandbox_port $SANDBOX_PORT
export PATH=/home/$USER/sandboxes/msb_5_7_23:$PATH

my sqladmin --silent --wait --connect_timeout=120  ping
