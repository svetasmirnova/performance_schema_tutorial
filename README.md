## Prerequirements
Requires vagrant 2.1.2+ due to bug: https://github.com/hashicorp/vagrant/issues/10158 , I've used 2.1.5 from https://www.vagrantup.com/downloads.html (installed it on my ubuntu 18.04 from debian 64-bit package).
```
wget https://releases.hashicorp.com/vagrant/2.1.5/vagrant_2.1.5_x86_64.deb
dpkg -i vagrant_2.1.5_x86_64.deb
```

## Access
* Change password from default 'dba': https://serversforhackers.com/c/create-user-in-ansible
* in virtualbox, connect to port 3622 with ssh
* do not forget to modify vagrant and dba user passwords if you are going to run tutorial engine in cloud

## Create addition tutorial items
1. check examples, `001-stored_procedure.sh` for single instance, `002-broken-replication.sh` for master with one slave
2. Add files/N-testname.sh
3. If needed add sql files
4. Do not forget to chmod files/N-testname.sh to allow execution (755)
5. modify files/tutorials.sh => add to options and case
6. Update your vagrant instance with `vagrant up --provision`


## Running with LXC
1. Install dependencies (on ubuntu 18.04)
`sudo apt-get -y install build-essential git ruby lxc lxc-templates cgroup-lite redir`
2. install vagrant plugin
`vagrant plugin install vagrant-lxc`
3. up with lxc provider
`vagrant up --provider=lxc`

### Adding new tasks with LXC
It's not enough to just run vagrant up --provision, provisioning works only for first up, so destroy -f and run up again.

## Troubleshooting
* If you are not able to login with dba account with password, ansible failed first time, but finished after further vagrant up --provision, try to restart ssh daemon
`vagrant ssh -- sudo systemctl restart ssh`
