Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.box = "ubuntu/bionic64"
  config.vm.provider "lxc" do |v, override|
    override.vm.box = "emptybox/ubuntu-bionic-amd64-lxc"
  end
  config.vm.provider "azure" do |az, override|
    override.vm.box = "azure-dummy"
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    # Specify VM parameters
    az.vm_name = 'tutorialengine'
    az.vm_size = 'Standard_B1s'
    az.vm_image_urn = 'Canonical:UbuntuServer:18.04-LTS:latest'
    az.resource_group_name = 'vagrant'
  end
  config.vm.provider "aws" do |aws, override|
    override.vm.box = "dummy"
    override.ssh.private_key_path = '~/.ssh/id_rsa-hadar'
    # Specify VM parameters
    # aws.access_key_id = "YOUR KEY"
    # aws.secret_access_key = "YOUR SECRET KEY"
    # aws.session_token = "SESSION TOKEN"
    aws.keypair_name = "nickolay.ihalainen"
    # https://cloud-images.ubuntu.com/locator/ec2/
    aws.ami = "ami-0cc10786e1d202f0c"
    override.ssh.username = "ubuntu"
  end

  config.vm.provision "shell" do |s|
    s.inline = "(grep -q vagrant /etc/passwd || useradd -m vagrant );mkdir -p /vagrant /home/vagrant/tutorial; chown vagrant:adm /vagrant /home/vagrant/tutorial; chmod g+w -R /vagrant /home/vagrant/tutorial"
    s.privileged = true
  end
  config.vm.provision "file", source: "files", destination: "/home/vagrant/tutorial"
  config.vm.provision "file", source: "playbook.yml", destination: "/vagrant/playbook.yml"
  config.vm.provision "ansible_local" do |ansible|
    ansible.compatibility_mode = "auto"
    ansible.playbook = "playbook.yml"
    ansible.compatibility_mode = "2.0"
  end
  config.vm.network "forwarded_port", guest: 22, host: 3622, host_ip: "0.0.0.0"
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 2
  end
end
