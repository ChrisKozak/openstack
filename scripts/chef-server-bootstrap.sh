#!/bin/sh
sudo echo 'chef.ulti-cloud.com' > /etc/hostname
sudo hostname -F /etc/hostname

echo "Downloading Chef Server"
sudo wget "https://opscode-omnitruck-release.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.0.4-1.ubuntu.12.04_amd64.deb" -O /tmp/chef_server.deb

echo "Installing Chef Server"
sudo dpkg -i /tmp/chef_server.deb

echo "Configuring Chef Server"
sudo chef-server-ctl reconfigure

echo "Verifying that Chef Server came up properly"
sudo chef-server-ctl test

