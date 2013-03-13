include_recipe 'tests::default'

TAGS = '-t @database_server'
OUT = '-f pretty -f html -o c:\temp\infrastructure_results.html'

execute 'Running tests' do
  command "bundle exec cucumber . #{TAGS} #{OUT}"
  cwd node[:tests_directory]
end


