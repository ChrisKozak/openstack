require 'rake'

task :knife, :cookbook do |t, args|
  system("knife cookbook metadata #{args[:cookbook]} -o #{File.dirname(__FILE__)}/cookbooks")
end
