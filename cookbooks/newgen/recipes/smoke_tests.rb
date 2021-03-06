class Chef::Resource
  include ConfigFiles
end

powershell 'Copying ui_tests' do
  parameters({
    'source' => "c:#{node[:binaries_directory].gsub('/', '\\')}",
    'target' => "c:#{node[:ui_tests_directory].gsub('/', '\\')}"
  })
  script = <<-EOF

    if (test-path $env:target) { remove-item $env:target -recurse }
    new-item $env:target -type directory -force

    copy-item "$env:source\\ui_tests\\*" "$env:target" -recurse -force
    copy-item "$env:source\\common_tests\\TabularData" "$env:target" -recurse -force

  EOF
  source(script)
end

ruby_block 'Updating config files' do
  block do
    update_ui_settings
    update_database_settings node[:ui_tests_directory]
  end
end

execute 'Run tests' do
  command '"%VS110COMNTOOLS%\..\IDE\mstest" /testcontainer:bin/UltimateSoftware.Echo.Automation.NewGen.UITests.dll /category:smoke /testsettings:bin\UIAutomation.CI.testsettings'
  cwd node[:ui_tests_directory]
end
