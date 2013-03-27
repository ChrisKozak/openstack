require 'rake'

task :knife, :cookbook do |t, args|
  system("knife cookbook metadata #{args[:cookbook]} -o #{File.dirname(__FILE__)}/cookbooks")
end

task :solo, :role do |t, args|
  system("chef-solo -c solo/solo.rb -j solo/#{args[:role]}.json ")
end

task :bootstrap_windows_node, :hostname, :role do |t, args|
  require 'erb'
  require 'tempfile'

  @hostname = args.hostname
  @role = args.role

  template = ERB.new File.read('scripts/WindowsBootstrap.ps1.erb')

  user_data_file = Tempfile.new('windows_bootstrap_powershell_script', '/tmp')
  user_data_file.write(template.result(binding))
  user_data_file.flush

  `nova boot --flavor m1.small --image e4f1a8e2-4c4e-4ee1-b744-825b2acf0a96 --key_name chris-kozak  --security-groups management --user-data #{user_data_file.path} #{@hostname}`
  user_data_file.close
  user_data_file.unlink
end