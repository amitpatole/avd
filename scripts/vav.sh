#!/bin/bash

#install Vagrant and its plugins
echo "install Vagrant and its plugins"

wget https://releases.hashicorp.com/vagrant/2.1.5/vagrant_2.1.5_x86_64.deb
sudo dpkg -i vagrant_2.1.5_x86_64.deb
sudo apt-get update
sudo apt-get -y install software-properties-common gem python gcc make linux-headers-$(uname -r) dkms

while read plugin_name
do
	vagrant plugin install $plugin_name
done <plugin_list


#install virtualbox
echo "Install Virtualbox and Virtualbox extension pack"

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
sudo apt update
sudo apt -y install virtualbox-5.2
sudo apt -y install virtualbox-ext-pack

# Install ansible 
echo "Install Ansible"
sudo apt-get update
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt-get -y install ansible

#ansible_python_interpreter: python3
#151.101.64.70 rubygems.org
#205.251.207.74 gems.hashicorp.com

