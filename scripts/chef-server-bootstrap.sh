#!/bin/sh

sudo apt-get update
sudo apt-get install -y ddclient

echo "Updating ddclient.conf"
sudo cat >> /etc/ddclient.conf <<EOF
daemon=600
cache=/tmp/ddclient.cache
pid=/var/run/ddclient.pid
use=if, if=eth0
login=ultimatesoftware
password=Ult1m@t3!
protocol=dyndns2
server=members.dyndns.org
#wildcard=YES
custom=yes, chef.ulti-cloud.com
EOF

echo "Updating DNS Record"
sudo ddclient -daemon=0 -debug -verbose -noquiet

sudo echo 'chef.ulti-cloud.com' > /etc/hostname
sudo hostname -F /etc/hostname

echo "Downloading Chef Server"
sudo wget "https://opscode-omnitruck-release.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.0.4-1.ubuntu.12.04_amd64.deb" -O /tmp/chef_server.deb

echo "Installing Chef Server"
sudo dpkg -i /tmp/chef_server.deb

echo "Configuring Chef Server"
sudo chef-server-ctl reconfigure
