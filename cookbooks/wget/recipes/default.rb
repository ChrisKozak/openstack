product = 'wget'

download_vendor(product: product, version: '1.11.4-1')

execute "Install #{product}" do
  command "#{product}.exe /verysilent"
  cwd "#{node[:installs_directory]}\\#{product}"
  not_if {Dir.exists? "#{ENV['ProgramFiles(x86)']}\\GnuWin32"}
end