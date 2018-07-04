# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box               = "ubuntu/xenial64"
    config.ssh.insert_key       = false
    config.vm.box_check_update  = false
    config.ssh.forward_agent    = true
    config.vm.boot_timeout      = 900
    config.vm.network "private_network", ip: "192.168.100.10"
    config.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--cpuexecutioncap", "20"]
        # Display the VirtualBox GUI when booting the machine
        vb.gui = false
        # Customize the amount of memory on the VM:
        vb.memory       = "1024"
    end
    #Aprovisionamiento
    config.vm.provision "shell", inline: "cd /vagrant && ./install.sh myusros"
end