name             "windows"
maintainer       "Opscode, Inc."
maintainer_email "cookbooks@opscode.com"
license          "Apache 2.0"
description      "Provides a set of useful Windows-specific primitives."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.8.4"

supports         "windows"
depends          "chef_handler"

recipe "windows::assign_logon_as_a_service_to_administrator", "assign logon as a service to administrator"
recipe "windows::set_administrator_password", "sets the administrator password"
recipe "windows::install_winhttpcertcfg", "installs winhttpcertcfg"
recipe "windows::share_temp_folder", "share the temp folder"
recipe "windows::create_user", "create a new windows user"

attribute "windows/administrator_password",
  :display_name => "administrator password",
  :required => "required",
  :recipes => ["windows::set_administrator_password"]

attribute 'windows/new_user_name',
  :display_name => 'new user name',
  :required => 'required',
  :recipes => ['windows::create_user']

attribute 'windows/new_user_password',
  :display_name => 'new user password',
  :required => 'required',
  :recipes => ['windows::create_user']
