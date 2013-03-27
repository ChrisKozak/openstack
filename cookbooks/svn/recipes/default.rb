product = 'psexec'

download_vendor(product: product, version: '1.94')

execute "Copy #{product} to system32" do
  command "copy #{product}.exe #{ENV['SYSTEMROOT']}\\Sysnative /Y"
  cwd "#{node[:installs_directory]}\\#{product}"
  not_if { File.exists? "#{ENV['SYSTEMROOT']}\\Sysnative\\#{product}.exe" }
end

execute "Accept #{product} eula" do
  command "#{ENV['SYSTEMROOT']}\\Sysnative\\#{product}.exe /accepteula"
  returns [0, -1]
end