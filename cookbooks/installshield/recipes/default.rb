product = 'installshield'

download_vendor(product: product, version: '2012')

#execute "Install #{product}" do
#  command "#{product}.exe /verysilent"
#  cwd "#{node[:installs_directory]}\\#{product}"
#  not_if {Dir.exists? "#{ENV['ProgramFiles(x86)']}\\GnuWin32"}
#end