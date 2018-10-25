#!/bin/bash
source /home/vagrant/tutorial/common.sh
make_sandbox /home/vagrant/mysql-8.0.13-linux-glibc2.12-x86_64.tar.gz -- --no_show --check_port --sandbox_port $SANDBOX_PORT
export PATH=/home/$USER/sandboxes/msb_8_0_13:$PATH

my sqladmin --silent --wait --connect_timeout=120  ping
