
include_recipe 'core::download_vendor_artifacts_prereqs'

artifact = 'git_install'
download_directory = '/installs'

template "#{node[:ruby_scripts_dir]}/download_git.rb" do
  local true
  source "#{node[:ruby_scripts_dir]}/download_vendor_artifacts.erb"
  variables(
    :aws_access_key_id => node[:core][:aws_access_key_id],
    :aws_secret_access_key => node[:core][:aws_secret_access_key],
    :s3_bucket => node[:core][:s3_bucket],
    :s3_repository => 'Vendor',
    :product => 'git',
    :version => '1.8.0',
    :artifacts => artifact,
    :target_directory => download_directory
  )
end

powershell 'Downloading git' do
  code("ruby #{node[:ruby_scripts_dir]}/download_git.rb")
  not_if { File.exist?("#{download_directory}/#{artifact}.zip") }
end

windows_zipfile "#{download_directory}/#{artifact}" do
  source "#{download_directory}/#{artifact}.zip"
  action :unzip
  not_if { File.exist?("#{download_directory}/#{artifact}") }
end

# The package name must match what is seen in add/remove programs to be idempotent
windows_package 'Git version 1.8.0-preview20121022' do
  source "#{download_directory}/#{artifact}/#{artifact}.exe"
  options '/verysilent'
  not_if { File.exist?("#{ENV['programfilesx86']}\\Git") }
end
