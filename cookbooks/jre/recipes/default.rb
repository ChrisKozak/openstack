product = 'jre'

download_vendor(product: product, version: '6.0.200.2')

execute "Install #{product}" do
  command "#{product}.exe /S"
  cwd "#{node[:installs_directory]}\\#{product}"
  not_if {Dir.exists? "#{ENV['ProgramFiles(x86)']}\\Java\\jre6"}
end

env 'PATH' do
  action :modify
  delim ::File::PATH_SEPARATOR
  value "#{ENV['ProgramFiles(x86)']}\\Java\\jre6\\bin"
end