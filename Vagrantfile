Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.provider "lxc" do |v, override|
    override.vm.box = "emptybox/ubuntu-bionic-amd64-lxc"
  end
  config.vm.provision "file", source: "files", destination: "/home/vagrant/tutorial"
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
