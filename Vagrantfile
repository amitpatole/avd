# -*- mode: ruby -*-
# vi: set ft=ruby :
$script = <<-SCRIPT
systemctl disable docker --now
systemctl enable docker-latest --now
sed -i '/DOCKERBINARY/s/^#//g' /etc/sysconfig/docker
SCRIPT

VAGRANTFILE_API_VERSION = "2"

# The project name is base for directories, hostname and alike
project_name = "media-manager"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "centos/atomic-host"
    # Use hostonly network with a static IP Address and enable
    # hostmanager so we can have a custom domain for the server
    # by modifying the host machines hosts file
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    {
      'ds1'     => '192.168.31.11',
      'ds2'     => '192.168.31.12',
      'ds3'     => '192.168.31.13',
    }.each do |app_name, ip_address|
      config.vm.define app_name do |node|
          node.vm.hostname = app_name + "." + project_name + ".dev"
          disk='./data-drive.vdi'
          node.vm.network :private_network, ip: ip_address
          node.vm.provider :virtualbox do |virtualbox|
            unless File.exist?(disk)
                virtualbox.customize ['createhd', '--filename', app_name+disk, '--variant', 'Standard', '--size', 20 * 1024]
            end
            virtualbox.memory = 1024
            virtualbox.cpus = 1
            virtualbox.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', app_name+disk]
        end
    end
    end
    config.vm.provision :hostmanager
    config.vm.provision "shell", inline: $script
#    config.vm.provision :ansible do |ansible|
#      ansible.groups = {
#        "Master" => ["ds1"],
#        "nodes" => ["ds2", "ds3"],
#        "all_groups:children" => ["Master", "nodes"],
#      }
#      ansible.playbook = "./playbook.yml"
#    end
end
