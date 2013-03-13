require 'rake'

task :knife, :cookbook do |t, args|
  system("knife cookbook metadata #{args[:cookbook]} -o #{File.dirname(__FILE__)}/cookbooks")
end

task :chef, :role do |t, args|
  system("chef-solo -c solo/solo.rb -j solo/#{args[:role]}.json ")
end
