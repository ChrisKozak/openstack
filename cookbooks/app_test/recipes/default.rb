#
# Cookbook Name:: AppTest
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template 'c:\ipaddress.txt' do
  source 'ipaddress.txt.erb'
  puts "Search results: #{search(:node,"name:db*").first()['ipaddress']}"
  variables(:ipaddress => search(:node,"name:db*").first()['ipaddress'])
  action :create
end

