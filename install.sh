#!/bin/bash
# Description: this is the bash file to install the DbFit on CentOS 7 Linux

$USERNAME = ""
# download the dbfit 
# in some server, you might need to download the wget, unzip, java as well, 
# e.g. 
# `yum install wget`
# `yum install unzip`
# `yum install java-1.8.0-openjdk`
# `yum install httpd` # this may not be needed
# if not finding the url base, do `dhclient` 
wget https://github.com/dbfit/dbfit/releases/download/v3.1.0/dbfit-complete-3.1.0.zip
unzip dbfit-complete-3.1.0.zip

# crete the group: fitnesse
sudo groupadd fitnesse
# create the user: fitnesse, and add the user to the group: fitnesse
sudo useradd -g fitnesse fitnesse

# create the dir: fitnesse
mkdir /usr/share/fitnesse

# cp the plugins.properties to the fitnesse dir
cp /home/$USERNAME/plugins.properties /usr/share/fitnesse/

# cp/create the daemon service file under /usr/share/fitnesse
cp DbFit_service.sh /usr/share/fitnesse/startFitness.sh

# change the permission of shell script and change the ownership of the dir
chmod 751 /usr/share/fitnesse/startFitnesse.sh
chown --recursive fitnesse:fitnesse /usr/share/fitnesse


# create the lib folder
mkdir /var/lib/fitnesse
cp /home/$USERNAME/lib/*.jar /var/lib/fitnesse
chown --recursive fitnesse:fitnesse /var/lib/fitnesse

# create the log folder
mkdir /var/log/fitnesse
chown --recursive fitnesse:fitnesse /var/log/fitnesse

# Make a symbolic link in /etc/init.d
ln --symbolic /usr/share/fitnesse/startFitnesse.sh /etc/init.d/fitnesse

# Add dbfit to the boot sequence:
chkconfig --add fitnesse


# after these few things need to check
# first make sure the 8085 port is open
# e.g.
# `firewall-cmd --list-port`
# if not need to open the 8085 port by:
# `firewall-cmd --permanent --add-service=http`
# `firewall-cmd --permanent --add-port=8085/tcp`
# `firewall-cmd --reload`

# lastly, start the fitness service
# `service fitnesse start` 
# or start the service as other user 
# `runuser -l fitnesse -c 'service fitnesse start'`

# this will helpful when the network has been start and stop to allocate the correct connection between the hosting machine and VM box
# `dhclient` 

