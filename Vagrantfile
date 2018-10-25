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
  config.vm.provision "shell" do |s|
    s.inline = "mkdir /vagrant; chown vagrant:vagrant /vagrant"
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
