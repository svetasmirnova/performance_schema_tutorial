## Prerequirements
Requires vagrant 2.1.2+ due to bug: https://github.com/hashicorp/vagrant/issues/10158 , I've used 2.1.5 from https://www.vagrantup.com/downloads.html (installed it on my ubuntu 18.04 from debian 64-bit package).
```
wget https://releases.hashicorp.com/vagrant/2.1.5/vagrant_2.1.5_x86_64.deb
dpkg -i vagrant_2.1.5_x86_64.deb
```

*Do not forget to generate passwords for users!*
```
update_passwords.sh
```
The script creates hashes at files/passwords.yml and userdetails.unencrypted.txt . First line of userdetails.unencrypted.txt belongs to dba1, last to dba50

## Access
* Change password from default 'dba': https://serversforhackers.com/c/create-user-in-ansible
* in virtualbox, connect to port 3622 with ssh
* do not forget to modify vagrant and dbaN users passwords if you are going to run tutorial engine in cloud

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

## Running with Azure cloud
Based on https://blog.scottlowe.org/2017/12/11/using-vagrant-with-azure/
1. Install azure cli https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-apt?view=azure-cli-latest
2. Install vagrant plugin
`vagrant plugin install vagrant-azure`
3. auth with az tools: https://docs.microsoft.com/en-us/cli/azure/authenticate-azure-cli?view=azure-cli-latest
4. Create a dummy box
`vagrant box add azure-dummy https://github.com/azure/vagrant-azure/raw/v2.0/dummy.box --provider azure`
5. Create your service principal and save the output
`az ad sp create-for-rbac`
6. get your account information
`az account show`
7. Create your env file and fill it in a safe place, no spaces between `=` and other symbols, `source envfile` at the end.
```
AZURE_TENANT_ID="put value of tenant from az ad sp create-for-rbac output"
AZURE_CLIENT_ID="put value of appId  from az ad sp create-for-rbac output"
AZURE_CLIENT_SECRET="put value of password from az ad sp create-for-rbac output"
AZURE_SUBSCRIPTION_ID="put value of id from az account show output"

export AZURE_TENANT_ID AZURE_CLIENT_ID AZURE_CLIENT_SECRET AZURE_SUBSCRIPTION_ID
```
8. In any bash shell intended for running vagrant up or ssh or destroy commands source access variables with `source envfile`
9. Modify playbook.yml to have strong passwords for vagrant and dbaN accounts.
10. Modify `Vagrantfile:az.vm_name` if needed (and VM size, currently it's 1 core & 1GB)
11. *Uncomment* `require azure-plugin` at the beginning of Vagrantfile to avoid error:
`The resource group 'vagrant' is in deprovisioning state and cannot perform this operation.`
12. Start vagrant box
`vagrant up --provider=azure`
13. Wait until creation and ansible run will be finished
14. Connect with attender account: `ssh dbaN@tutorialengine.westus.cloudapp.azure.com` where N from 1 to 50
15. Do not forget to remove VM after work to avoid wasting money: `vagrant destroy -f`
16. Check at https://portal.azure.com, VM should be destroyed completely after 10-15 minutes (Delete procedure is really slow)

## Running with Amazon AWS cloud
https://github.com/mitchellh/vagrant-aws
1. Install provider
```
vagrant plugin install vagrant-aws
vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box
```
2. Update Vagrant file to provide your account details. If aws configure was executed on your machine it's enough to change just:
```
override.ssh.private_key_path = '~/.ssh/id_rsa-hadar'
aws.keypair_name = "nickolay.ihalainen"
```
3. Start the box `vagrant up --provider=aws`
4. ssh dba1@ip
5. Do not forget to shutdown with `vagrant destroy -f` to save money


## Troubleshooting
* If you are not able to login with dba account with password, ansible failed first time, but finished after further vagrant up --provision, try to restart ssh daemon
`vagrant ssh -- sudo systemctl restart ssh`
* For Azure I was able to get the error `The resource group 'vagrant' is in deprovisioning state and cannot perform this operation.`
It seems like it's not happening if I add `require azure-plugin` at the beginning of Vagrantfile. But you can also wait until VM and "Resource group" will disappear after previous VM deletion.
* If you are getting:
```
TASK [Include passwords] *******************************************************
fatal: [default]: FAILED! => {"ansible_facts": {"dbausers": {}}, "ansible_included_var_files": [], "changed": false, "message": "Could not find or access '/home/vagrant/tutorial/passwords.yml' on the Ansible Controller.\nIf you are using a module and expect the file to exist on the remote, see the remote_src option"}
```
Run `./update_passwords.sh` . It uses mkpasswd tool (on debian/ubuntu there is `apt install whois` prerequirement.
On OS X there is no mkpasswd tool, but we can use slower simulation in python:
```
pip3 install passlib
replace mkpasswd -s --method=sha-512 with ./makepasswd-sha-512 in update_passwords.sh
```

## Typical usage scenario
1. Start vagrant box: `vagrant up --provider=lxc`
2. Create new tasks in files/NNN-testname.sh. Do not forget to add DESCRIPTION variable (menu item name).
3. Update push changes to existing vagrant box: `vagrant provision`
4. When you finished for today stop box: `vagrant halt`
5. If you have created, but stopped box you can start it: `vagrant up`
6. Renaming task files:
  * login to box: `vagrant ssh`
  * remove existing task files in box: `rm -rf tutorial/*`
  * exit from vagrant ssh
  * push all tutorial files to the box: `vagrant provision`
7. During demonstration you should have pre-configured halted box, just start it: `vagrant up`. The box is already provisioned, thus it will not require internet connection to start.

## Extending
### Installing packages from apt
`playbook.yml` file contains declarations what packages and files should be in the box. In order to add new packages add following lines before `# keep allow password login at the end` comment:
```
    - name: install sysbench
      package:
        name: sysbench
        update_cache: no
        state: present
```
`update_cache: yes` instructs ansible to run `apt update` before installing package.

Be careful with spaces and tabs, yml format is like a python programming language.

### Using sysbench
* sysbench 1.0.11 is pre-installed.
* Could be used from task script:
```
use test < /home/vagrant/tutorial/001-stored_procedure-setup.sql
sb oltp_read_only.lua prepare
```
* Could be used from tmux window:
```
sb oltp_read_only.lua prepare
sb oltp_read_only.lua run --threads=2 --time=60
# you can also use full script path
sb /usr/share/sysbench/oltp_read_only.lua run
```
* or even directly from mysql cli
```
master [localhost] {msandbox} (test) > \! sb oltp_read_only.lua run
sysbench 1.0.11 (using system LuaJIT 2.1.0-beta3)
...
```
* Both for single and master-slave setup (executed against master).

