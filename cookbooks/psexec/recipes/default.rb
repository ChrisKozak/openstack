product = 'svn'

download_vendor(product: product, version: '1.6.16-1')

execute 'Install svn' do
  command "#{product}.exe /S"
  cwd "#{node[:installs_directory]}\\#{product}"
  not_if {Dir.exists? "#{ENV['ProgramFiles(x86)']}\\CollabNet\\Subversion Client"}
end
