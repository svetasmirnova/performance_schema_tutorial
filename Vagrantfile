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
    override.ssh.private_key_path = '~/_private/sveta-p_s-tutorial.pem'
    # Specify VM parameters
    # aws.access_key_id = "YOUR KEY"
    # aws.secret_access_key = "YOUR SECRET KEY"
    # aws.session_token = "SESSION TOKEN"
    aws.keypair_name = "sveta-p_s-tutorial"
    # https://cloud-images.ubuntu.com/locator/ec2/
    # aws.ami = "ami-0cc10786e1d202f0c"
    aws.ami = "ami-024a64a6685d05041"
    override.ssh.username = "ubuntu"

    aws.block_device_mapping = [{ 'DeviceName' => '/dev/sda1', 'Ebs.VolumeSize' => 100 }]
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
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 2
  end

  config.vm.define "default", primary: true do |default|
    default.vm.network "forwarded_port", guest: 22, host: 3622, host_ip: "0.0.0.0"
  end
  config.vm.define "tut1", autostart: false do |tut1|
    tut1.vm.network "forwarded_port", guest: 22, host: 3623, host_ip: "0.0.0.0"
  end
  config.vm.define "tut2", autostart: false do |tut2|
    tut2.vm.network "forwarded_port", guest: 22, host: 3624, host_ip: "0.0.0.0"
  end
  config.vm.define "tut3", autostart: false do |tut3|
    tut3.vm.network "forwarded_port", guest: 22, host: 3625, host_ip: "0.0.0.0"
  end
  config.vm.define "tut4", autostart: false do |tut4|
    tut4.vm.network "forwarded_port", guest: 22, host: 3626, host_ip: "0.0.0.0"
  end
  config.vm.define "tut5", autostart: false do |tut5|
    tut5.vm.network "forwarded_port", guest: 22, host: 3627, host_ip: "0.0.0.0"
  end
end
