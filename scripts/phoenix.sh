knife cookbook upload --all

nova delete application.ulti-cloud.com
knife node delete application.ulti-cloud.com -y
knife client delete application.ulti-cloud.com -y
#rake 'bootstrap_windows_node[application.ulti-cloud.com, application]'

nova delete database.ulti-cloud.com
knife node delete database.ulti-cloud.com -y
knife client delete database.ulti-cloud.com -y
rake 'bootstrap_windows_node[database.ulti-cloud.com, database]'