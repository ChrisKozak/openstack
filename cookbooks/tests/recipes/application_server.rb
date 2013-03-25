include_recipe 'tests::default'

TAGS = '-t @app_server'
OUT = '-f pretty -f html -o c:\temp\infrastructure_results.html'

ENV['windows/new_user_name'] = node[:windows][:new_user_name]

execute 'Running tests' do
  command "cmd /c \"cucumber #{node[:tests_directory]} #{TAGS} #{OUT}\""
  cwd '/'
end


