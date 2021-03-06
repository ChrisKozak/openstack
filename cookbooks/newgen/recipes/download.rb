include_recipe 'core::download_product_artifacts_prereqs'

gem_package('fog') { action :install }

template "#{node[:ruby_scripts_dir]}/download_binaries.rb" do
  local true
  source "#{node[:ruby_scripts_dir]}/download_product_artifacts.erb"
  variables(
    :aws_access_key_id => node[:core][:aws_access_key_id],
    :aws_secret_access_key => node[:core][:aws_secret_access_key],
    :artifacts => node[:newgen][:binaries_artifacts],
    :target_directory => node[:binaries_directory],
    :revision => node[:newgen][:binaries_revision],
    :s3_bucket => node[:core][:s3_bucket],
    :s3_repository => node[:core][:s3_repository],
    :s3_directory => 'Binaries'
  )
end

if node[:platform] == "ubuntu"
  bash 'Downloading artifacts' do
    code <<-EOF
      ruby #{node[:ruby_scripts_dir]}/download_binaries.rb
    EOF
  end
else
  powershell "Downloading artifacts" do
    code "ruby #{node[:ruby_scripts_dir]}/download_binaries.rb"
  end
end
