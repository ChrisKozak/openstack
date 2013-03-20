root = File.dirname __FILE__

log_level :info
log_location STDOUT

node_name 'maykelsw7t3400.us.corp'
client_key "#{root}/chef/client.pem"
validation_client_name 'chef-validator'

chef_server_url 'https://precise64'