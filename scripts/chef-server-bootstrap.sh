#!/bin/sh
sudo echo 'chef.dev.us.corp' > /etc/hostname
sudo hostname -F /etc/hostname
sudo echo '127.0.0.1 chef.dev.us.corp chef' >> /etc/hosts

echo "Downloading Chef Server"
sudo wget "https://opscode-omnitruck-release.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.0.4-1.ubuntu.12.04_amd64.deb" -O /tmp/chef_server.deb

echo "Installing Chef Server"
sudo dpkg -i /tmp/chef_server.deb

echo "Configuring Chef Server"
sudo chef-server-ctl reconfigure

echo "Verifying that Chef Server came up properly"
sudo chef-server-ctl test

echo "Changing hostname to chef.dev.us.corp"
sudo hostname chef.dev.us.corp

