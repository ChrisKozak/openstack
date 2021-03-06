include_recipe 'core::download_vendor_artifacts_prereqs'

raise 'Not implemented yet' if node[:platform] == 'ubuntu'

template "#{node[:ruby_scripts_dir]}/download_elastic_search.rb" do
  local true
  source "#{node[:ruby_scripts_dir]}/download_vendor_artifacts.erb"
  variables(
    :aws_access_key_id => node[:core][:aws_access_key_id],
    :aws_secret_access_key => node[:core][:aws_secret_access_key],
    :repository_source => node[:core][:repository_source],
    :s3_bucket => node[:core][:s3_bucket],
    :s3_repository => 'Vendor',
    :product => 'elastic_search',
    :version => '0.20.4',
    :artifacts => 'elastic_search',
    :target_directory => 'c:\installs'
  )
end

execute 'Download elastic_search' do
  command 'ruby c:\\rubyscripts\\download_elastic_search.rb'
  not_if { File.exist?('/installs/elastic_search.zip') }
end

windows_zipfile '/elastic_search' do
  source '/installs/elastic_search.zip'
  action :unzip
  not_if { File.exist?('/elastic_search') }
end

execute 'Installing plugin elasticsearch-head' do
  command 'plugin.bat -install Aconex/elasticsearch-head'
  cwd '/elastic_search/bin'
end

execute 'Installing plugin bigdesk' do
  command 'plugin.bat -install lukas-vlcek/bigdesk'
  cwd '/elastic_search/bin'
end

windows_task 'Start Elastic Search' do
  user 'Administrator'
  password node[:windows][:administrator_password]
  command 'c:\elastic_search\bin\elasticsearch.bat'
  run_level :highest
  frequency :onstart
  action :create
end

windows_task 'Start Elastic Search' do
  action :run
end
