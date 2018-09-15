#!/bin/bash
if grep -q Ubuntu /etc/lsb-release
then
   sudo wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
   sudo wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
   sudo add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian `lsb_release -cs` contrib"
   sudo apt-get update
   sudo apt-get install virtualbox-5.2
   if vagrant --version | grep Vagrant
   then
      sudo apt-get remove -y vagrant
   else
      echo installing vagrant
   fi
   sudo apt-get install vagrant
   sudo vagrant box add ubuntu/trusty64
   sudo vagrant init ubuntu/trusty64
   sudo vagrant up

else
   sudo yum update
   sudo yum install -y kernel-devel kernel-headers gcc make perl
   sudo yum -y install "kernel-devel-uname-r == $(uname -r)"
   sudo yum -y install wget
   sudo wget https://www.virtualbox.org/download/oracle_vbox.asc
   sudo rpm --import oracle_vbox.asc
   sudo  wget http://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo -O /etc/yum.repos.d/virtualbox.repo      
   sudo yum install -y VirtualBox-5.2
   if vagrant --version | grep Vagrant
   then
      sudo yum remove -y vagrant
   else 
      echo installing vagrant
   fi
   sudo yum -y install https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.rpm
   mkdir ~/test-vagrant
   cd ~/test-vagrant
   vagrant init ubuntu/trusty64
   vagrant up

fi
